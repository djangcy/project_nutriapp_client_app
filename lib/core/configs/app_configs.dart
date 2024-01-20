import 'package:flutter_dotenv/flutter_dotenv.dart';

/// App level configuration variables
class AppConfigs {
  /// The max allowed age duration for the http cache
  static const Duration maxCacheAge = Duration(minutes: 30);

  /// Key used in dio options to indicate whether
  /// cache should be force refreshed
  static const String dioCacheForceRefreshKey = 'dio_cache_force_refresh_key';

  // -- config.env keys --
  // Auth token for accessing the API
  static String apiBaseUrl = dotenv.env['API_BASE_URL']!;
  static String authToken = dotenv.env['API_KEY']!;
}
