import 'package:dio/dio.dart';
import 'package:komet_collection/core/constants/api_constants.dart';
import 'package:komet_collection/core/network/dio_client.dart';
import 'package:komet_collection/core/error/dio_exception_handler.dart';
import 'package:komet_collection/features/auth/data/models/user_model.dart';

class AuthRemoteDataSource {
  final Dio _dio;

  AuthRemoteDataSource() : _dio = DioClient.instance;

  Future<UserModel> login(String username, String password) async {
    try {
      final response = await _dio.post(
        ApiConstants.login,
        data: {'username': username, 'password': password},
      );
      final userMap = response.data['user'] as Map<String, dynamic>;
      return UserModel.fromJson(userMap);
    } on DioException catch (e) {
      throw e.toFailure();
    }
  }
}
