import 'package:dio/dio.dart';
import '../../core/constants/api_constants.dart';
import '../../core/network/dio_client.dart';
import '../../core/error/failures.dart';
import '../models/customer_model.dart';
import '../models/invoice_model.dart';
import '../models/payment_model.dart';

class CustomerRemoteDataSource {
  final Dio _dio;

  CustomerRemoteDataSource() : _dio = DioClient.instance;

  Future<List<CustomerModel>> getCustomers({int offset = 0, int limit = 50}) async {
    try {
      final response = await _dio.get(
        ApiConstants.customers,
        queryParameters: {'offset': offset, 'limit': limit},
      );
      final data = response.data;
      final results = data['results'] ?? data;
      return (results as List)
          .map((e) => CustomerModel.fromJson(e as Map<String, dynamic>))
          .toList();
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  Future<Map<String, dynamic>> getCustomerLedger(String customerId) async {
    try {
      final response = await _dio.post(
        ApiConstants.customerLedger,
        data: {'customer_id': customerId},
      );
      return response.data as Map<String, dynamic>;
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  Future<CustomerModel> createCustomer({
    required String name,
    required String phone,
    String? email,
    String? address,
  }) async {
    try {
      final response = await _dio.post(
        ApiConstants.createCustomer,
        data: {
          'name': name,
          'phone': phone,
          'email': email,
          'address': address,
        },
      );
      return CustomerModel.fromJson(response.data as Map<String, dynamic>);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  Future<Map<String, dynamic>> recordPayment({
    required String customerId,
    required double amount,
    required String paymentMode,
    String? note,
  }) async {
    try {
      final response = await _dio.post(
        ApiConstants.recordPayment,
        data: {
          'customer_id': customerId,
          'amount': amount,
          'payment_mode': paymentMode,
          'notes': note,
        },
      );
      return response.data as Map<String, dynamic>;
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  Failure _handleError(DioException e) {
    if (e.response?.statusCode == 401) {
      return const AuthFailure('Unauthorized');
    }
    return ServerFailure(
      e.message ?? 'An unexpected error occurred',
      statusCode: e.response?.statusCode,
    );
  }
}
