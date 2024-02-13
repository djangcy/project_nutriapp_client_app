import 'package:auto_route/auto_route.dart';

import 'app_router.gr.dart';

export 'package:auto_route/auto_route.dart';

@AutoRouterConfig(replaceInRouteName: 'Page,Route')
class AppRouter extends $AppRouter {
  @override
  RouteType get defaultRouteType => const RouteType.adaptive();

  @override
  List<AutoRoute> get routes => [
        AutoRoute(
          page: HomeRoute.page,
          initial: true,
        ),
        AutoRoute(
          page: RecipeDetailRoute.page,
        ),
        AutoRoute(
          page: ProfileRoute.page,
        ),
      ];
}
