import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../network/dio_provider.dart';
import '../storage/secure_storage_service.dart';

final secureStorageProvider =
    Provider<SecureStorageService>((ref) {
  return SecureStorageService();
});

final dioProvider = Provider<Dio>((ref) {
  return DioProvider.create(
    storage: ref.read(secureStorageProvider),
  );
});