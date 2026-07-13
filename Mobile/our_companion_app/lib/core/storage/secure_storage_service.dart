import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorageService {
  final FlutterSecureStorage _storage =
      const FlutterSecureStorage();

  static const _accessToken = "access_token";
  static const _refreshToken = "refresh_token";

  Future<void> saveAccessToken(String token) async {
    await _storage.write(
      key: _accessToken,
      value: token,
    );
  }

  Future<void> saveRefreshToken(String token) async {
    await _storage.write(
      key: _refreshToken,
      value: token,
    );
  }

  Future<String?> getAccessToken() async {
    return _storage.read(key: _accessToken);
  }

  Future<String?> getRefreshToken() async {
    return _storage.read(key: _refreshToken);
  }

  Future<void> clear() async {
    await _storage.deleteAll();
  }
}