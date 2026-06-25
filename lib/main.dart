import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:komet_collection/core/theme/app_theme.dart';
import 'package:komet_collection/core/di/injection.dart';
import 'package:komet_collection/core/router/app_router.dart';
import 'package:komet_collection/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:komet_collection/features/customer/presentation/bloc/customer_bloc.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  initDependencies();
  runApp(const KometCollectionApp());
}

class KometCollectionApp extends StatelessWidget {
  const KometCollectionApp({super.key});

  @override
  Widget build(BuildContext context) {
    final appRouter = getIt<AppRouter>();

    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthBloc>(create: (_) => getIt<AuthBloc>()),
        BlocProvider<CustomerBloc>(create: (_) => getIt<CustomerBloc>()),
      ],
      child: MaterialApp.router(
        title: 'Komet Collection',
        debugShowCheckedModeBanner: false,
        theme: AppTheme.lightTheme,
        routerConfig: appRouter.config(),
      ),
    );
  }
}
