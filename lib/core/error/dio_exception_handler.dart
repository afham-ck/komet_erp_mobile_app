import 'dart:io';
import 'package:dio/dio.dart';
import 'failures.dart';

extension DioExceptionX on DioException {
  /// Converts a [DioException] into an appropriate domain [Failure].
  Failure toFailure() {
    return handleDioException(this);
  }
}

/// Central function to handle [DioException] and map it to a domain [Failure].
Failure handleDioException(DioException e) {
  final statusCode = e.response?.statusCode;

  // 401 Unauthorized
  if (statusCode == 401) {
    final message = _extractErrorMessage(e);
    return message != null ? AuthFailure(message) : const AuthFailure();
  }

  // Network / Connection errors
  if (e.type == DioExceptionType.connectionTimeout ||
      e.type == DioExceptionType.sendTimeout ||
      e.type == DioExceptionType.receiveTimeout ||
      e.type == DioExceptionType.connectionError ||
      e.error is SocketException) {
    return const NetworkFailure();
  }

  // Server responses with error status codes (4xx, 5xx)
  if (e.response != null) {
    final message = _extractErrorMessage(e) ?? e.message ?? 'An unexpected error occurred';
    return ServerFailure(message, statusCode);
  }

  // Fallback for all other unexpected errors
  return const UnknownFailure();
}

/// Helper function to extract error message from API response body if present.
String? _extractErrorMessage(DioException e) {
  final data = e.response?.data;
  if (data is Map<String, dynamic>) {
    if (data['detail'] is String) return data['detail'] as String;
    if (data['message'] is String) return data['message'] as String;
    if (data['error'] is String) return data['error'] as String;
  } else if (data is String && data.isNotEmpty) {
    return data;
  }
  return null;
}
