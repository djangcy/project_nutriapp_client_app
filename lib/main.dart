import 'package:flutter/material.dart';
import 'package:nutrition_app/bootstrap.dart';
import 'package:nutrition_app/config/config.dart';

void main() {
  bootstrap(
    () => const MyApp(),
  );
}

final _routerConfig = AppRouter().config(
  navigatorObservers: () => [RouteObserver()],
);

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      theme: ThemeData(
        scaffoldBackgroundColor: PrimaryColorScheme.light.background,
        colorScheme: PrimaryColorScheme.light,
        textTheme: PrimaryTextTheme.theme,
        textSelectionTheme: TextSelectionThemeData(
          cursorColor: PrimaryColorScheme.light.onSurface,
          selectionColor: PrimaryColorScheme.light.surfaceVariant,
          selectionHandleColor: PrimaryColorScheme.light.onSurface,
        ),
      ),
      routerConfig: _routerConfig,
    );
  }
}
