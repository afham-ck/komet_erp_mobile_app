import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:komet_collection/features/auth/domain/repositories/auth_repository.dart';
import 'package:komet_collection/core/di/injection.dart';
import 'package:komet_collection/core/router/app_router.dart';
import 'package:komet_collection/core/router/app_router.gr.dart';
import 'auth_event.dart';
import 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository _repository;

  AuthBloc(this._repository) : super(const AuthState.initial()) {
    on<CheckAuthStatusEvent>(_onCheckAuthStatus);
    on<LoginEvent>(_onLogin);
    on<LogoutEvent>(_onLogout);
    on<UpdateUserEvent>(_onUpdateUser);
    on<SessionExpiredEvent>(_onSessionExpired);
  }

  Future<void> _onCheckAuthStatus(CheckAuthStatusEvent event, Emitter<AuthState> emit) async {
    final result = await _repository.getAuthenticatedUser();
    result.fold(
      (failure) => emit(const AuthState.unauthenticated()),
      (user) {
        if (user != null) {
          emit(AuthState.authenticated(user: user));
        } else {
          emit(const AuthState.unauthenticated());
        }
      },
    );
  }

  Future<void> _onLogin(LoginEvent event, Emitter<AuthState> emit) async {
    emit(const AuthState.loading());
    final result = await _repository.login(event.username, event.password);
    result.fold(
      (failure) => emit(AuthState.error(message: failure.message)),
      (user) => emit(AuthState.authenticated(user: user)),
    );
  }

  Future<void> _onLogout(LogoutEvent event, Emitter<AuthState> emit) async {
    emit(const AuthState.loading());
    final result = await _repository.logout();
    result.fold(
      (failure) => emit(AuthState.error(message: failure.message)),
      (_) => emit(const AuthState.unauthenticated()),
    );
  }

  Future<void> _onUpdateUser(UpdateUserEvent event, Emitter<AuthState> emit) async {
    emit(AuthState.authenticated(user: event.user));
    await _repository.saveUser(event.user);
  }

  Future<void> _onSessionExpired(SessionExpiredEvent event, Emitter<AuthState> emit) async {
    await _repository.logout();
    emit(const AuthState.unauthenticated());
    getIt<AppRouter>().replaceAll([const LoginRoute()]);
  }
}
