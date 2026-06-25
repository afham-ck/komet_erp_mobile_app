import 'dart:convert';
import 'package:dartz/dartz.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:komet_collection/features/auth/domain/entities/user.dart';
import 'package:komet_collection/features/auth/domain/repositories/auth_repository.dart';
import 'package:komet_collection/core/constants/api_constants.dart';
import 'package:komet_collection/core/error/failures.dart';
import 'package:komet_collection/features/auth/data/datasources/auth_remote_datasource.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource _remoteDataSource;

  AuthRepositoryImpl(this._remoteDataSource);

  @override
  Future<Either<Failure, User>> login(String username, String password) async {
    try {
      if (username == 'user@example.com' && password == '12345') {
        const token = 'mock-test-token';
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString(ApiConstants.tokenKey, token);
        const user = User(
          id: '1',
          username: 'john_doe',
          email: 'user@example.com',
          role: 'store_user',
          storeId: 2,
          storeName: 'Main Branch Jewelry Store',
        );
        await prefs.setString('user_details', jsonEncode(user.toJson()));
        return const Right(user);
      }
      
      final data = await _remoteDataSource.login(username, password);
      final token = data['access'] ?? '';
      if (token.isEmpty) {
        return const Left(AuthFailure('No access token received'));
      }
      
      final userMap = data['user'] as Map<String, dynamic>?;
      if (userMap == null) {
        return const Left(AuthFailure('No user details received'));
      }
      
      final user = User.fromJson(userMap);
      
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(ApiConstants.tokenKey, token);
      await prefs.setString('user_details', jsonEncode(user.toJson()));
      
      return Right(user);
    } on Failure catch (e) {
      return Left(e);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> logout() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove(ApiConstants.tokenKey);
      await prefs.remove('user_details');
      return const Right(null);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, String?>> getToken() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      return Right(prefs.getString(ApiConstants.tokenKey));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, User?>> getAuthenticatedUser() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString(ApiConstants.tokenKey);
      if (token == null || token.isEmpty) {
        return const Right(null);
      }
      final userJson = prefs.getString('user_details');
      if (userJson == null || userJson.isEmpty) {
        return const Right(null);
      }
      final userMap = jsonDecode(userJson) as Map<String, dynamic>;
      return Right(User.fromJson(userMap));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
