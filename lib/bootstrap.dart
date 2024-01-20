import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:nutrition_app/core/core.dart';

Future<void> bootstrap(FutureOr<Widget> Function() builder) async {
  await runZonedGuarded(
    () async {
      WidgetsFlutterBinding.ensureInitialized();

      // Load config file
      await dotenv.load(fileName: 'config.env');

      await DioHttp.initDio();

      runApp(await builder());
    },
    (error, stack) => debugPrint('Error | $error\nStack | $stack'),
  );
}
