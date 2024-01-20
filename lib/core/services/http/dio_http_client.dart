import 'package:dio/dio.dart';
import 'package:dio_cache_interceptor/dio_cache_interceptor.dart';
import 'package:dio_cache_interceptor_hive_store/dio_cache_interceptor_hive_store.dart';
import 'package:nutrition_app/core/core.dart';
import 'package:path_provider/path_provider.dart' as path;

class DioHttp {
  static Dio? _dioInstance;

  static Dio get dioHttpClient {
    if (_dioInstance == null) {
      throw Exception('Instance of DioHttp has not been initialized');
    }
    return _dioInstance!;
  }

  static Future<void> initDio() async {
    if (_dioInstance == null) {
      final cacheDir = await path.getTemporaryDirectory();
      final hiveCacheStore = HiveCacheStore(
        cacheDir.path,
        // ignore: avoid_redundant_argument_values
        hiveBoxName: 'dio_cache',
      );

      final cacheOptions = CacheOptions(
        store: hiveCacheStore,
        hitCacheOnErrorExcept: [401, 403],
        maxStale: const Duration(days: 7),
      );

      _dioInstance = Dio(
        BaseOptions(
          baseUrl: AppConfigs.apiBaseUrl,
          headers: {
            'Authorization':
                'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpYXQiOjE3MDQxMjQwMTkwOTksImFjY2Vzc190b2tlbiI6IjYzZjg4MzQ1ODQ3OGM2YjE5MzE0OWEyNzlhOTRkMmI1ZTZlYjgwM2MzZGY0ZDFhNzk5NzIyMDhlNzczNmJiOTciLCJleHAiOjE3MDQxMjQwMjI2OTl9.xVsSuSehpTytygy4AhBzNKEoUH1GGTu4AnCtqeJ6x6A',
          },
        ),
      )..interceptors.add(
          DioCacheInterceptor(
            options: cacheOptions,
          ),
        );
    }
  }
}
