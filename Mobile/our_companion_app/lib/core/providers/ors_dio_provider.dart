import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final orsDioProvider = Provider<Dio>((ref) {
  return Dio(
    BaseOptions(
      connectTimeout: const Duration(seconds: 30),
      receiveTimeout: const Duration(seconds: 30),
      headers: {
        "Content-Type": "application/json",
      },
    ),
  );
});