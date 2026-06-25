import 'package:dartz/dartz.dart';
import 'package:komet_collection/features/auth/domain/entities/user.dart';
import 'package:komet_collection/core/error/failures.dart';

abstract class AuthRepository {
  Future<Either<Failure, User>> login(String username, String password);
  Future<Either<Failure, void>> logout();
  Future<Either<Failure, String?>> getToken();
  Future<Either<Failure, User?>> getAuthenticatedUser();
}
