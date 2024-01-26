import 'package:fb_auth_provider/providers/auth/auth_state.dart';
import 'package:firebase_auth/firebase_auth.dart' as fbAuth;
import 'package:fb_auth_provider/repositories/auth_repository.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class AuthProvider with ChangeNotifier {
  AuthState _state = AuthState.unknown();

  AuthProvider({required this.authRepository});
  AuthState get state => _state;

  final AuthRepository authRepository;
  void update(fbAuth.User? user) {
    if (user != null) {
      _state =
          _state.copyWith(authStatus: AuthStatus.authenticated, user: user);
    } else {
      _state =
          _state.copyWith(authStatus: AuthStatus.unauthenticated, user: user);
    }
    print('authState: $_state');
    notifyListeners();
  }

  void signout() async {
    await authRepository.signout();
  }
}
