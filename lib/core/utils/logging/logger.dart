import 'package:logger/logger.dart' as l;

final _logger = l.Logger(
  printer: l.PrettyPrinter(
    methodCount: 4,
  ),
);

class Logger {
  static void trace(String message) {
    _logger.t(message);
  }

  static void debug(String message) {
    _logger.d(message);
  }

  static void info(String message) {
    _logger.i(message);
  }

  static void warning(String message) {
    _logger.w(message);
  }

  static void error(
    String message, {
    required Object? error,
    StackTrace? stackTrace,
  }) {
    _logger.e(
      message,
      error: error,
      stackTrace: stackTrace ??
          (error is Error ? error.stackTrace : StackTrace.current),
    );
  }

  static void fatal(
    String message, {
    required Object? error,
    StackTrace? stackTrace,
  }) {
    _logger.f(message, error: error, stackTrace: stackTrace);
  }
}
