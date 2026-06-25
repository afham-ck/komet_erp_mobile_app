import 'package:freezed_annotation/freezed_annotation.dart';

part 'auth_event.freezed.dart';

@freezed
class AuthEvent with _$AuthEvent {
  const factory AuthEvent.checkAuthStatus() = CheckAuthStatusEvent;
  const factory AuthEvent.login({
    required String username,
    required String password,
  }) = LoginEvent;
  const factory AuthEvent.logout() = LogoutEvent;
}
