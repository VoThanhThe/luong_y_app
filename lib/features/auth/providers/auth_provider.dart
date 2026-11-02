import 'package:flutter/foundation.dart';
import '../data/datasources/auth_remote_data_source.dart';
import '../domain/entities/auth_session.dart';
import '../domain/repositories/auth_repository.dart';
import '../domain/usecases/login_use_case.dart';

enum AuthStatus { initializing, unauthenticated, authenticated }

class AuthProvider extends ChangeNotifier {
  AuthProvider(this._repository) : _loginUseCase = LoginUseCase(_repository) {
    restoreSession();
  }
  final AuthRepository _repository;
  final LoginUseCase _loginUseCase;
  AuthStatus _status = AuthStatus.initializing;
  bool _isLoading = false;
  AuthUser? _user;
  String? _error;
  AuthStatus get status => _status;
  bool get isLoggedIn => _status == AuthStatus.authenticated;
  bool get isLoading => _isLoading;
  AuthUser? get user => _user;
  String? get error => _error;

  Future<void> restoreSession() async {
    try {
      final session = await _repository.restoreSession();
      _user = session?.user;
      _status = session == null
          ? AuthStatus.unauthenticated
          : AuthStatus.authenticated;
    } catch (_) {
      _user = null;
      _status = AuthStatus.unauthenticated;
    }
    notifyListeners();
  }

  Future<bool> onLogin({
    required String username,
    required String password,
  }) async {
    _isLoading = true;
    _error = null;
    notifyListeners();
    try {
      final session = await _loginUseCase(
        username: username.trim(),
        password: password,
      );
      _user = session.user;
      _status = AuthStatus.authenticated;
      return true;
    } catch (e) {
      _error = e is AuthException
          ? e.message
          : 'Không thể kết nối. Vui lòng thử lại.';
      return false;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> onLogout() async {
    await _repository.logout();
    _user = null;
    _error = null;
    _status = AuthStatus.unauthenticated;
    notifyListeners();
  }

  void clearError() {
    _error = null;
    notifyListeners();
  }
}
