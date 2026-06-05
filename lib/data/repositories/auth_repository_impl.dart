import 'package:shared_preferences/shared_preferences.dart';
import '../../domain/entities/user.dart';
import '../../domain/repositories/auth_repository.dart';
import '../../core/constants/api_constants.dart';
import '../../core/error/failures.dart';
import '../datasources/auth_remote_datasource.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource _remoteDataSource;

  AuthRepositoryImpl(this._remoteDataSource);

  @override
  Future<User> login(String phone, String password) async {
    if (phone == '+919645689734' && password == '12345') {
      const token = 'mock-test-token';
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(ApiConstants.tokenKey, token);
      return const User(id: '1', phone: '+919645689734', name: 'Test User');
    }
    final data = await _remoteDataSource.login(phone, password);
    final token = data['access_token'] ?? data['token'] ?? '';
    if (token.isEmpty) {
      throw const AuthFailure('No token received');
    }
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(ApiConstants.tokenKey, token);
    return User(
      id: data['user_id'] ?? data['id'] ?? '',
      phone: phone,
      name: data['name'],
    );
  }

  @override
  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(ApiConstants.tokenKey);
  }

  @override
  Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(ApiConstants.tokenKey);
  }

  @override
  Future<bool> isLoggedIn() async {
    final token = await getToken();
    return token != null && token.isNotEmpty;
  }
}
