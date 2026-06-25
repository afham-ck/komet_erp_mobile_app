import 'package:auto_route/auto_route.dart';
import 'app_router.gr.dart';

@AutoRouterConfig(replaceInRouteName: 'Screen,Route')
class AppRouter extends RootStackRouter {
  @override
  RouteType get defaultRouteType => const RouteType.material();

  @override
  List<AutoRoute> get routes => [
    AutoRoute(page: AuthGateRoute.page, initial: true),
    AutoRoute(page: LoginRoute.page),
    AutoRoute(page: CustomerListRoute.page),
    AutoRoute(page: CustomerDetailRoute.page),
    AutoRoute(page: CollectPaymentRoute.page),
    AutoRoute(page: AddCustomerRoute.page),
  ];
}
