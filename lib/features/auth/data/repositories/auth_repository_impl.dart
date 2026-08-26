import 'dart:convert';
import 'package:dartz/dartz.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:komet_collection/features/auth/domain/entities/user.dart';
import 'package:komet_collection/features/auth/data/models/user_model.dart';
import 'package:komet_collection/features/auth/domain/repositories/auth_repository.dart';
import 'package:komet_collection/core/error/failures.dart';
import 'package:komet_collection/features/auth/data/datasources/auth_remote_datasource.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource _remoteDataSource;

  AuthRepositoryImpl(this._remoteDataSource);

  @override
  Future<Either<Failure, User>> login(String username, String password) async {
    try {
      final userModel = await _remoteDataSource.login(username, password);

      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('user', jsonEncode(userModel.toJson()));

      return Right(userModel.toEntity());
    } on Failure catch (e) {
      return Left(e);
    } catch (e) {
      return const Left(UnknownFailure());
    }
  }

  @override
  Future<Either<Failure, void>> logout() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove('user');
      return const Right(null);
    } catch (e) {
      return const Left(UnknownFailure());
    }
  }

  @override
  Future<Either<Failure, User?>> getAuthenticatedUser() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final userJson = prefs.getString('user');
      if (userJson == null || userJson.isEmpty) {
        return const Right(null);
      }
      final userMap = jsonDecode(userJson) as Map<String, dynamic>;
      final userModel = UserModel.fromJson(userMap);
      return Right(userModel.toEntity());
    } catch (e) {
      return const Left(UnknownFailure());
    }
  }

  @override
  Future<Either<Failure, void>> saveUser(User user) async {
    try {
      final userModel = UserModel.fromEntity(user);
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('user', jsonEncode(userModel.toJson()));
      return const Right(null);
    } catch (e) {
      return const Left(UnknownFailure());
    }
  }
}
