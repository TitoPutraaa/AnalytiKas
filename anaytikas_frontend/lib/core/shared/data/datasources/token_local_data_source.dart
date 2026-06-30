import 'package:flutter_secure_storage/flutter_secure_storage.dart';

abstract class TokenLocalDataSource {
  Future<void> saveToken(String token);
  Future<String?> getToken();
  Future<bool> isTokenExpired();
  Future<void> deleteToken();
}

class TokenLocalDataSourceImpl implements TokenLocalDataSource {
  final FlutterSecureStorage secureStorage;
  static const _tokenKey = 'auth_token';
  static const _savedAtKey = 'auth_token_saved_at';
  static const Duration tokenLifetime = Duration(days: 30);

  TokenLocalDataSourceImpl({required this.secureStorage});

  @override
  Future<void> saveToken(String token) async {
    await secureStorage.write(key: _tokenKey, value: token);
    await secureStorage.write(
      key: _savedAtKey,
      value: DateTime.now().toIso8601String(),
    );
  }

  @override
  Future<String?> getToken() => secureStorage.read(key: _tokenKey);

  @override
  Future<bool> isTokenExpired() async {
    final savedAtStr = await secureStorage.read(key: _savedAtKey);
    if (savedAtStr == null) return true;

    final savedAt = DateTime.parse(savedAtStr);
    final expiredAt = savedAt.add(tokenLifetime);
    return DateTime.now().isAfter(expiredAt);
  }

  @override
  Future<void> deleteToken() async {
    await secureStorage.delete(key: _tokenKey);
    await secureStorage.delete(key: _savedAtKey);
  }
}
