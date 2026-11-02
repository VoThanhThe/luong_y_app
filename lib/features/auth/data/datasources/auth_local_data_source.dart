import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../../domain/entities/auth_session.dart';

class AuthLocalDataSource {
  AuthLocalDataSource(this._storage);
  final FlutterSecureStorage _storage;
  static const _tokenKey = 'auth.access_token';
  static const _userKey = 'auth.user';

  Future<void> save(AuthSession session) async {
    await _storage.write(key: _tokenKey, value: session.token);
    await _storage.write(
      key: _userKey,
      value: jsonEncode(session.user.toJson()),
    );
  }

  Future<AuthSession?> read() async {
    final token = await _storage.read(key: _tokenKey);
    final rawUser = await _storage.read(key: _userKey);
    if (token == null || token.isEmpty || rawUser == null) return null;
    try {
      final exp = _jwtExpiry(token);
      if (exp != null && !exp.isAfter(DateTime.now())) {
        await clear();
        return null;
      }
      return AuthSession(
        token: token,
        user: AuthUser.fromJson(jsonDecode(rawUser) as Map<String, dynamic>),
      );
    } catch (_) {
      await clear();
      return null;
    }
  }

  Future<void> clear() async {
    await _storage.delete(key: _tokenKey);
    await _storage.delete(key: _userKey);
  }

  DateTime? _jwtExpiry(String token) {
    final parts = token.split('.');
    if (parts.length != 3) return null;
    final payload =
        jsonDecode(utf8.decode(base64Url.decode(base64Url.normalize(parts[1]))))
            as Map<String, dynamic>;
    final exp = payload['exp'];
    return exp is num
        ? DateTime.fromMillisecondsSinceEpoch(exp.toInt() * 1000)
        : null;
  }
}
