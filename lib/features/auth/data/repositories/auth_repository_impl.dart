import '../../domain/entities/auth_session.dart';
import '../../domain/repositories/auth_repository.dart';
import '../datasources/auth_local_data_source.dart';
import '../datasources/auth_remote_data_source.dart';

class AuthRepositoryImpl implements AuthRepository {
  AuthRepositoryImpl(this._remote, this._local);
  final AuthRemoteDataSource _remote;
  final AuthLocalDataSource _local;
  @override
  Future<AuthSession> login({
    required String username,
    required String password,
  }) async {
    final session = await _remote.login(username: username, password: password);
    await _local.save(session);
    return session;
  }

  @override
  Future<AuthSession?> restoreSession() => _local.read();
  @override
  Future<void> logout() => _local.clear();
}
