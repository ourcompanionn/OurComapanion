import 'package:dio/dio.dart';

import '../storage/secure_storage_service.dart';

class AuthInterceptor extends Interceptor {
  final SecureStorageService storage;

  AuthInterceptor(this.storage);

  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {

    final token = await storage.getAccessToken();

    if (token != null && token.isNotEmpty) {
      options.headers["Authorization"] =
          "Bearer $token";
    }

    handler.next(options);
  }
}