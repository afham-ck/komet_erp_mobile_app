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
    final message = _extractErrorMessage(e) ?? 'Server error (${statusCode ?? 'unknown'}). Please try again.';
    return ServerFailure(message, statusCode);
  }

  // Fallback for all other unexpected errors
  return const UnknownFailure();
}

/// Helper function to extract a user-friendly error message from the API response body.
/// Handles:
///   - `{"detail": "..."}` — DRF standard detail
///   - `{"message": "..."}` or `{"error": "..."}` — custom keys
///   - `{"non_field_errors": ["..."]}` — DRF non-field validation errors
///   - `{"phone": ["..."], "name": ["..."]}` — DRF field-level validation errors
///   - Plain string responses
String? _extractErrorMessage(DioException e) {
  final data = e.response?.data;
  if (data is Map<String, dynamic>) {
    // Standard detail / message / error keys
    if (data['detail'] is String) return data['detail'] as String;
    if (data['message'] is String) return data['message'] as String;
    if (data['error'] is String) return data['error'] as String;

    // DRF non_field_errors list
    final nonField = data['non_field_errors'];
    if (nonField is List && nonField.isNotEmpty) {
      return nonField.first.toString();
    }

    // DRF field-level validation errors — e.g. {"phone": ["This field is required."]}
    // Collect the first message from each field and join them.
    final fieldMessages = <String>[];
    for (final entry in data.entries) {
      final val = entry.value;
      if (val is List && val.isNotEmpty) {
        fieldMessages.add('${_capitalize(entry.key)}: ${val.first}');
      } else if (val is String) {
        fieldMessages.add('${_capitalize(entry.key)}: $val');
      }
    }
    if (fieldMessages.isNotEmpty) return fieldMessages.join('\n');
  } else if (data is String && data.isNotEmpty) {
    return data;
  }
  return null;
}

String _capitalize(String key) {
  final readable = key.replaceAll('_', ' ');
  if (readable.isEmpty) return readable;
  return readable[0].toUpperCase() + readable.substring(1);
}
