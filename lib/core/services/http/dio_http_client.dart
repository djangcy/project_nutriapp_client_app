import 'package:dio/dio.dart';
import 'package:dio_cache_interceptor/dio_cache_interceptor.dart';
import 'package:dio_cache_interceptor_hive_store/dio_cache_interceptor_hive_store.dart';
import 'package:flutter/foundation.dart';
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
      DioCacheInterceptor? cacheInterceptor;

      if (!kIsWeb) {
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

        cacheInterceptor = DioCacheInterceptor(
          options: cacheOptions,
        );
      }

      _dioInstance = Dio(
        BaseOptions(
          baseUrl: AppConfigs.apiBaseUrl,
          headers: {
            'Authorization': 'Bearer ${AppConfigs.authToken}',
          },
        ),
      );

      if (cacheInterceptor != null) {
        _dioInstance?.interceptors.add(cacheInterceptor);
      }
    }
  }
}
