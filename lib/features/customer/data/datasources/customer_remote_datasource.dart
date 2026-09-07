import 'package:dio/dio.dart';
import 'package:komet_collection/core/constants/api_constants.dart';
import 'package:komet_collection/core/network/dio_client.dart';
import 'package:komet_collection/core/error/dio_exception_handler.dart';
import 'package:komet_collection/features/customer/data/models/customer_model.dart';
import 'package:komet_collection/features/customer/data/models/customer_detail_model.dart';
import 'package:komet_collection/features/customer/data/models/enrollment_model.dart';
import 'package:komet_collection/features/customer/data/models/payment_result_model.dart';

class CustomerRemoteDataSource {
  final Dio _dio;

  CustomerRemoteDataSource() : _dio = DioClient.instance;

  Future<List<CustomerModel>> getCustomers({
    int page = 1,
    int pageSize = 100,
    String? search,
  }) async {
    try {
      final queryParams = <String, dynamic>{
        'page': page,
        'page_size': pageSize,
      };
      if (search != null && search.isNotEmpty) {
        queryParams['search'] = search;
      }
      final response = await _dio.get(
        ApiConstants.customers,
        queryParameters: queryParams,
      );
      final data = response.data;
      final results = data is Map<String, dynamic> ? (data['results'] ?? data) : data;
      return (results as List)
          .map((e) => CustomerModel.fromJson(e as Map<String, dynamic>))
          .toList();
    } on DioException catch (e) {
      throw e.toFailure();
    }
  }

  Future<List<EnrollmentModel>> getEnrollments({
    required int customerId,
    String status = 'active',
  }) async {
    try {
      final queryParams = <String, dynamic>{
        'customer': customerId,
      };
      if (status.isNotEmpty) {
        queryParams['status'] = status;
      }
      final response = await _dio.get(
        ApiConstants.enrollments,
        queryParameters: queryParams,
      );
      final data = response.data;
      final results = data is Map<String, dynamic> ? (data['results'] ?? data) : data;
      return (results as List)
          .map((e) => EnrollmentModel.fromJson(e as Map<String, dynamic>))
          .toList();
    } on DioException catch (e) {
      throw e.toFailure();
    }
  }

  Future<CustomerDetailDataModel> getCustomerDetail(String customerId) async {
    try {
      final response = await _dio.get(
        ApiConstants.customerDetail,
        queryParameters: {'id': customerId},
      );
      return CustomerDetailDataModel.fromJson(response.data as Map<String, dynamic>);
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

  Future<PaymentResultModel> collectPayment({
    required int enrollmentId,
    required double amount,
    String? paymentDate,
    String paymentMode = 'cash',
    String? notes,
  }) async {
    try {
      final data = <String, dynamic>{
        'enrollmentId': enrollmentId,
        'amount': amount,
        'paymentMode': paymentMode,
      };
      if (paymentDate != null && paymentDate.isNotEmpty) {
        data['paymentDate'] = paymentDate;
      }
      if (notes != null && notes.isNotEmpty) {
        data['notes'] = notes;
      }
      final response = await _dio.post(
        ApiConstants.collectPayment,
        data: data,
      );
      return PaymentResultModel.fromJson(response.data as Map<String, dynamic>);
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

