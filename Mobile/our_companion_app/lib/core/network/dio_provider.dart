import 'package:dio/dio.dart';
import 'package:our_companion_app/core/network/api_endpont.dart';
import 'package:our_companion_app/core/network/auth_interceptor.dart';
import 'package:our_companion_app/core/storage/secure_storage_service.dart';

class DioProvider {
  static Dio create({required SecureStorageService storage}) {
    final dio = Dio(
      BaseOptions(
        baseUrl: ApiEndpoints.baseUrl,
        connectTimeout: const Duration(seconds: 30),
        receiveTimeout: const Duration(seconds: 30),

        headers: {"Content-Type": "application/json"},
      ),
    );

    dio.interceptors.add(AuthInterceptor(storage));

    return dio;
  }
}
