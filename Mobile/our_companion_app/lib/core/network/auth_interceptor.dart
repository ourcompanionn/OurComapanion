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
   
   print("TOKEN: $token");

    if (token != null && token.isNotEmpty) {
      options.headers["Authorization"] =
          "Bearer $token";
    }

    print("HEADERS: ${options.headers}");

    handler.next(options);
  }
}