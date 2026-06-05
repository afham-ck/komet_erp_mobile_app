import '../entities/user.dart';
import '../../core/error/failures.dart';

abstract class AuthRepository {
  Future<User> login(String phone, String password);
  Future<void> logout();
  Future<String?> getToken();
  Future<bool> isLoggedIn();
}
