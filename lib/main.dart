import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nutrition_app/bootstrap.dart';
import 'package:nutrition_app/config/config.dart';

void main() {
  bootstrap(
    () => ProviderScope(
      observers: [ProviderLogger()],
      child: const MyApp(),
    ),
  );
}

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
      routerConfig: AppRouter().config(
        navigatorObservers: () => [RouteObserver()],
      ),
    );
  }
}

class ProviderLogger extends ProviderObserver {
  @override
  void didUpdateProvider(
    ProviderBase<dynamic> provider,
    Object? previousValue,
    Object? newValue,
    ProviderContainer container,
  ) {
    log('''
{
  "provider": "${provider.name ?? provider.runtimeType}",
  "newValue": "$newValue"
}''');
  }
}
