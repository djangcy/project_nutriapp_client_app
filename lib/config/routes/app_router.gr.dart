// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i3;
import 'package:flutter/material.dart' as _i4;
import 'package:nutrition_app/features/home/presentation/pages/home.dart'
    as _i1;
import 'package:nutrition_app/features/recipes/presentation/pages/recipe_detail.dart'
    as _i2;

abstract class $AppRouter extends _i3.RootStackRouter {
  $AppRouter({super.navigatorKey});

  @override
  final Map<String, _i3.PageFactory> pagesMap = {
    HomeRoute.name: (routeData) {
      return _i3.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i1.HomePage(),
      );
    },
    RecipeDetailRoute.name: (routeData) {
      final args = routeData.argsAs<RecipeDetailRouteArgs>();
      return _i3.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i2.RecipeDetailPage(
          key: args.key,
          recipeUrl: args.recipeUrl,
        ),
      );
    },
  };
}

/// generated route for
/// [_i1.HomePage]
class HomeRoute extends _i3.PageRouteInfo<void> {
  const HomeRoute({List<_i3.PageRouteInfo>? children})
      : super(
          HomeRoute.name,
          initialChildren: children,
        );

  static const String name = 'HomeRoute';

  static const _i3.PageInfo<void> page = _i3.PageInfo<void>(name);
}

/// generated route for
/// [_i2.RecipeDetailPage]
class RecipeDetailRoute extends _i3.PageRouteInfo<RecipeDetailRouteArgs> {
  RecipeDetailRoute({
    _i4.Key? key,
    required String recipeUrl,
    List<_i3.PageRouteInfo>? children,
  }) : super(
          RecipeDetailRoute.name,
          args: RecipeDetailRouteArgs(
            key: key,
            recipeUrl: recipeUrl,
          ),
          initialChildren: children,
        );

  static const String name = 'RecipeDetailRoute';

  static const _i3.PageInfo<RecipeDetailRouteArgs> page =
      _i3.PageInfo<RecipeDetailRouteArgs>(name);
}

class RecipeDetailRouteArgs {
  const RecipeDetailRouteArgs({
    this.key,
    required this.recipeUrl,
  });

  final _i4.Key? key;

  final String recipeUrl;

  @override
  String toString() {
    return 'RecipeDetailRouteArgs{key: $key, recipeUrl: $recipeUrl}';
  }
}
