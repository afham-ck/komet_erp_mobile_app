import 'package:dio/dio.dart';
import 'package:komet_collection/core/constants/api_constants.dart';
import 'package:komet_collection/core/network/dio_client.dart';
import 'package:komet_collection/core/error/failures.dart';

class AuthRemoteDataSource {
  final Dio _dio;

  AuthRemoteDataSource() : _dio = DioClient.instance;

  Future<Map<String, dynamic>> login(String username, String password) async {
    try {
      final response = await _dio.post(
        ApiConstants.login,
        data: {'username': username, 'password': password},
      );
      return response.data as Map<String, dynamic>;
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  Failure _handleError(DioException e) {
    if (e.response?.statusCode == 401) {
      return const AuthFailure('Invalid credentials');
    }
    return ServerFailure(
      e.message ?? 'Login failed',
      statusCode: e.response?.statusCode,
    );
  }
}
