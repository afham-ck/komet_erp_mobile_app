import 'package:get_it/get_it.dart';
import 'package:komet_collection/core/router/app_router.dart';
import 'package:komet_collection/features/auth/data/datasources/auth_remote_datasource.dart';
import 'package:komet_collection/features/customer/data/datasources/customer_remote_datasource.dart';
import 'package:komet_collection/features/auth/domain/repositories/auth_repository.dart';
import 'package:komet_collection/features/customer/domain/repositories/customer_repository.dart';
import 'package:komet_collection/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:komet_collection/features/customer/data/repositories/customer_repository_impl.dart';
import 'package:komet_collection/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:komet_collection/features/customer/presentation/bloc/customer_bloc.dart';

final getIt = GetIt.instance;

void initDependencies() {
  // Router
  getIt.registerSingleton<AppRouter>(AppRouter());

  // Data sources
  getIt.registerLazySingleton<AuthRemoteDataSource>(() => AuthRemoteDataSource());
  getIt.registerLazySingleton<CustomerRemoteDataSource>(() => CustomerRemoteDataSource());

  // Repositories
  getIt.registerLazySingleton<AuthRepository>(() => AuthRepositoryImpl(getIt<AuthRemoteDataSource>()));
  getIt.registerLazySingleton<CustomerRepository>(() => CustomerRepositoryImpl(getIt<CustomerRemoteDataSource>()));

  // BLoCs
  getIt.registerLazySingleton<AuthBloc>(() => AuthBloc(getIt<AuthRepository>()));
  getIt.registerFactory<CustomerBloc>(() => CustomerBloc(getIt<CustomerRepository>()));
}
