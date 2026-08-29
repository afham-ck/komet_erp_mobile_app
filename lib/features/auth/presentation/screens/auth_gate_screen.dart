import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:auto_route/auto_route.dart';
import 'package:komet_collection/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:komet_collection/features/auth/presentation/bloc/auth_event.dart';
import 'package:komet_collection/features/auth/presentation/bloc/auth_state.dart';
import 'package:komet_collection/core/router/app_router.gr.dart';

@RoutePage()
class AuthGateScreen extends StatefulWidget {
  const AuthGateScreen({super.key});

  @override
  State<AuthGateScreen> createState() => _AuthGateScreenState();
}

class _AuthGateScreenState extends State<AuthGateScreen> {
  @override
  void initState() {
    super.initState();
    context.read<AuthBloc>().add(const AuthEvent.checkAuthStatus());
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        state.whenOrNull(
          authenticated: (user) {
            context.router.replace(const CustomerListRoute());
          },
          unauthenticated: () {
            context.router.replace(const LoginRoute());
          },
        );
      },
      child: const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }
}
