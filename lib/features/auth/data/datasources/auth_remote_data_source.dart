import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../domain/entities/auth_session.dart';

class AuthRemoteDataSource {
  AuthRemoteDataSource(this._client);
  final http.Client _client;
  static final _endpoint = Uri.parse(
    'https://apis-dev.xheroapp.com/users/authenticate',
  );

  Future<AuthSession> login({
    required String username,
    required String password,
  }) async {
    final response = await _client
        .post(
          _endpoint,
          headers: const {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
          },
          body: jsonEncode({
            'username': username,
            'password': password,
            'fromPlatform': 'app',
          }),
        )
        .timeout(const Duration(seconds: 20));
    Map<String, dynamic> body;
    try {
      body = jsonDecode(response.body) as Map<String, dynamic>;
    } catch (_) {
      throw const AuthException('Máy chủ trả về dữ liệu không hợp lệ.');
    }
    final data = body['data'];
    final ok =
        response.statusCode >= 200 &&
        response.statusCode < 300 &&
        (body['status'] == true || body['success'] == true);
    if (!ok ||
        data is! Map<String, dynamic> ||
        data['token'] is! String ||
        data['user'] is! Map<String, dynamic>) {
      throw AuthException(
        (body['message'] ??
                body['msg'] ??
                'Đăng nhập thất bại. Vui lòng kiểm tra thông tin.')
            .toString(),
      );
    }
    return AuthSession(
      token: data['token'] as String,
      user: AuthUser.fromJson(data['user'] as Map<String, dynamic>),
    );
  }
}

class AuthException implements Exception {
  const AuthException(this.message);
  final String message;
  @override
  String toString() => message;
}
