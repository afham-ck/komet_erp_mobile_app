import 'package:dio/dio.dart';
import 'package:komet_collection/core/constants/api_constants.dart';
import 'package:komet_collection/core/network/dio_client.dart';
import 'package:komet_collection/core/error/dio_exception_handler.dart';
import 'package:komet_collection/features/customer/data/models/customer_model.dart';

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
      throw e.toFailure();
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
      throw e.toFailure();
    }
  }

  Future<CustomerModel> createCustomer({
    required String name,
    required String phone,
    String? email,
    String? address,
    String? aadhar,
  }) async {
    try {
      final response = await _dio.post(
        ApiConstants.createCustomer,
        data: {
          'name': name,
          'phone': phone,
          'email': email,
          'address': address,
          'aadhar': aadhar,
        },
      );
      return CustomerModel.fromJson(response.data as Map<String, dynamic>);
    } on DioException catch (e) {
      throw e.toFailure();
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
      throw e.toFailure();
    }
  }
}

