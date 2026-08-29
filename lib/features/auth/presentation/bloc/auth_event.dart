import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:komet_collection/features/auth/domain/entities/user.dart';

part 'auth_event.freezed.dart';

@freezed
class AuthEvent with _$AuthEvent {
  const factory AuthEvent.checkAuthStatus() = CheckAuthStatusEvent;
  const factory AuthEvent.login({
    required String username,
    required String password,
  }) = LoginEvent;
  const factory AuthEvent.logout() = LogoutEvent;
  const factory AuthEvent.updateUser({
    required User user,
  }) = UpdateUserEvent;
  const factory AuthEvent.sessionExpired() = SessionExpiredEvent;
}
