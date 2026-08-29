import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:komet_collection/core/di/injection.dart';
import 'package:komet_collection/features/auth/data/models/user_model.dart';
import 'package:komet_collection/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:komet_collection/features/auth/presentation/bloc/auth_event.dart';
import '../constants/api_constants.dart';
import 'dio_client.dart';

class _QueuedRequest {
  final RequestOptions options;
  final ErrorInterceptorHandler handler;

  _QueuedRequest({required this.options, required this.handler});
}

class AuthInterceptor extends Interceptor {
  bool _isRefreshing = false;
  final List<_QueuedRequest> _requestQueue = [];

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    final prefs = await SharedPreferences.getInstance();
    final userJson = prefs.getString('user');
    if (userJson != null && userJson.isNotEmpty) {
      try {
        final userMap = jsonDecode(userJson) as Map<String, dynamic>;
        final token = userMap['access_token'] as String?;
        if (token != null &&
            options.path != ApiConstants.login &&
            options.path != ApiConstants.refreshToken) {
          options.headers['Authorization'] = 'Bearer $token';
        }
      } catch (_) {
        // Ignored, key might be malformed or empty
      }
    }
    options.headers['Content-Type'] = 'application/json';
    handler.next(options);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    // If it's a 401 error and not from login or token refresh endpoints
    if (err.response?.statusCode == 401 &&
        err.requestOptions.path != ApiConstants.login &&
        err.requestOptions.path != ApiConstants.refreshToken) {
      
      final options = err.requestOptions;

      // If already refreshing, queue the request
      if (_isRefreshing) {
        _requestQueue.add(_QueuedRequest(options: options, handler: handler));
        return;
      }

      _isRefreshing = true;
      _requestQueue.add(_QueuedRequest(options: options, handler: handler));

      try {
        final prefs = await SharedPreferences.getInstance();
        final userJson = prefs.getString('user');
        if (userJson == null || userJson.isEmpty) {
          throw DioException(
            requestOptions: options,
            message: 'No user session available',
          );
        }

        final userMap = jsonDecode(userJson) as Map<String, dynamic>;
        final user = UserModel.fromJson(userMap);
        final refreshToken = user.refreshToken;

        if (refreshToken == null || refreshToken.isEmpty) {
          throw DioException(
            requestOptions: options,
            message: 'No refresh token available',
          );
        }

        // Call the Refresh Token API using a clean/separate Dio instance to avoid recursive interception
        final dio = Dio(BaseOptions(
          baseUrl: ApiConstants.baseUrl,
          connectTimeout: const Duration(seconds: 15),
          receiveTimeout: const Duration(seconds: 15),
          headers: {'Content-Type': 'application/json'},
        ));

        final response = await dio.post(
          ApiConstants.refreshToken,
          data: {'refresh': refreshToken},
        );

        if (response.statusCode == 200) {
          final data = response.data as Map<String, dynamic>;
          
          // Robust token parsing to handle different backend response shapes
          final String newAccessToken;
          final String newRefreshToken;
          
          if (data.containsKey('access') && data.containsKey('refresh')) {
            newAccessToken = data['access'] as String;
            newRefreshToken = data['refresh'] as String;
          } else if (data.containsKey('access')) {
            newAccessToken = data['access'] as String;
            newRefreshToken = refreshToken;
          } else if (data.containsKey('refresh')) {
            // Fallback if the endpoint returns the access token or new single token under 'refresh'
            newAccessToken = data['refresh'] as String;
            newRefreshToken = data['refresh'] as String;
          } else {
            throw DioException(
              requestOptions: options,
              message: 'Invalid response from refresh token endpoint',
            );
          }

          // Update AuthBloc state and storage via GetIt
          final updatedUser = user.copyWith(
            accessToken: newAccessToken,
            refreshToken: newRefreshToken,
          );

          final authBloc = getIt<AuthBloc>();
          authBloc.add(AuthEvent.updateUser(user: updatedUser.toEntity()));

          // Retry all queued requests with the new access token
          _isRefreshing = false;
          final queue = List<_QueuedRequest>.from(_requestQueue);
          _requestQueue.clear();

          for (final queued in queue) {
            // Update the Authorization header with the new token
            queued.options.headers['Authorization'] = 'Bearer $newAccessToken';
            
            // Retry the request using the main Dio instance
            try {
              final retryResponse = await DioClient.instance.fetch(queued.options);
              queued.handler.resolve(retryResponse);
            } on DioException catch (retryErr) {
              queued.handler.reject(retryErr);
            }
          }
          return;
        } else {
          throw DioException(
            requestOptions: options,
            response: response,
            message: 'Refresh token request failed',
          );
        }
      } catch (e) {
        _isRefreshing = false;
        final queue = List<_QueuedRequest>.from(_requestQueue);
        _requestQueue.clear();

        // Reject all queued requests with the original error
        for (final queued in queue) {
          queued.handler.reject(err);
        }

        // Failure Flow:
        // Clear all user session data, emit Unauthenticated, and redirect to Login Page
        final authBloc = getIt<AuthBloc>();
        authBloc.add(const AuthEvent.sessionExpired());

        return;
      }
    }

    // Pass the error to the next interceptor/handler if it's not a 401 or is from auth endpoints
    handler.next(err);
  }
}
