// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i7;
import 'package:flutter/material.dart' as _i8;
import 'package:komet_collection/features/auth/presentation/screens/auth_gate_screen.dart'
    as _i2;
import 'package:komet_collection/features/auth/presentation/screens/login_screen.dart'
    as _i6;
import 'package:komet_collection/features/customer/domain/entities/customer.dart'
    as _i9;
import 'package:komet_collection/features/customer/presentation/screens/add_customer_screen.dart'
    as _i1;
import 'package:komet_collection/features/customer/presentation/screens/collect_payment_screen.dart'
    as _i3;
import 'package:komet_collection/features/customer/presentation/screens/customer_detail_screen.dart'
    as _i4;
import 'package:komet_collection/features/customer/presentation/screens/customer_list_screen.dart'
    as _i5;

/// generated route for
/// [_i1.AddCustomerScreen]
class AddCustomerRoute extends _i7.PageRouteInfo<void> {
  const AddCustomerRoute({List<_i7.PageRouteInfo>? children})
    : super(AddCustomerRoute.name, initialChildren: children);

  static const String name = 'AddCustomerRoute';

  static _i7.PageInfo page = _i7.PageInfo(
    name,
    builder: (data) {
      return const _i1.AddCustomerScreen();
    },
  );
}

/// generated route for
/// [_i2.AuthGateScreen]
class AuthGateRoute extends _i7.PageRouteInfo<void> {
  const AuthGateRoute({List<_i7.PageRouteInfo>? children})
    : super(AuthGateRoute.name, initialChildren: children);

  static const String name = 'AuthGateRoute';

  static _i7.PageInfo page = _i7.PageInfo(
    name,
    builder: (data) {
      return const _i2.AuthGateScreen();
    },
  );
}

/// generated route for
/// [_i3.CollectPaymentScreen]
class CollectPaymentRoute extends _i7.PageRouteInfo<CollectPaymentRouteArgs> {
  CollectPaymentRoute({
    _i8.Key? key,
    required _i9.Customer customer,
    List<_i7.PageRouteInfo>? children,
  }) : super(
         CollectPaymentRoute.name,
         args: CollectPaymentRouteArgs(key: key, customer: customer),
         initialChildren: children,
       );

  static const String name = 'CollectPaymentRoute';

  static _i7.PageInfo page = _i7.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<CollectPaymentRouteArgs>();
      return _i3.CollectPaymentScreen(key: args.key, customer: args.customer);
    },
  );
}

class CollectPaymentRouteArgs {
  const CollectPaymentRouteArgs({this.key, required this.customer});

  final _i8.Key? key;

  final _i9.Customer customer;

  @override
  String toString() {
    return 'CollectPaymentRouteArgs{key: $key, customer: $customer}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! CollectPaymentRouteArgs) return false;
    return key == other.key && customer == other.customer;
  }

  @override
  int get hashCode => key.hashCode ^ customer.hashCode;
}

/// generated route for
/// [_i4.CustomerDetailScreen]
class CustomerDetailRoute extends _i7.PageRouteInfo<CustomerDetailRouteArgs> {
  CustomerDetailRoute({
    _i8.Key? key,
    required _i9.Customer customer,
    List<_i7.PageRouteInfo>? children,
  }) : super(
         CustomerDetailRoute.name,
         args: CustomerDetailRouteArgs(key: key, customer: customer),
         initialChildren: children,
       );

  static const String name = 'CustomerDetailRoute';

  static _i7.PageInfo page = _i7.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<CustomerDetailRouteArgs>();
      return _i4.CustomerDetailScreen(key: args.key, customer: args.customer);
    },
  );
}

class CustomerDetailRouteArgs {
  const CustomerDetailRouteArgs({this.key, required this.customer});

  final _i8.Key? key;

  final _i9.Customer customer;

  @override
  String toString() {
    return 'CustomerDetailRouteArgs{key: $key, customer: $customer}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! CustomerDetailRouteArgs) return false;
    return key == other.key && customer == other.customer;
  }

  @override
  int get hashCode => key.hashCode ^ customer.hashCode;
}

/// generated route for
/// [_i5.CustomerListScreen]
class CustomerListRoute extends _i7.PageRouteInfo<void> {
  const CustomerListRoute({List<_i7.PageRouteInfo>? children})
    : super(CustomerListRoute.name, initialChildren: children);

  static const String name = 'CustomerListRoute';

  static _i7.PageInfo page = _i7.PageInfo(
    name,
    builder: (data) {
      return const _i5.CustomerListScreen();
    },
  );
}

/// generated route for
/// [_i6.LoginScreen]
class LoginRoute extends _i7.PageRouteInfo<void> {
  const LoginRoute({List<_i7.PageRouteInfo>? children})
    : super(LoginRoute.name, initialChildren: children);

  static const String name = 'LoginRoute';

  static _i7.PageInfo page = _i7.PageInfo(
    name,
    builder: (data) {
      return const _i6.LoginScreen();
    },
  );
}
