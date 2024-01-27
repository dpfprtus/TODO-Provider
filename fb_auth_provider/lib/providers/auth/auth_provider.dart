import 'package:fb_auth_provider/providers/auth/auth_state.dart';
import 'package:firebase_auth/firebase_auth.dart' as fbAuth;
import 'package:fb_auth_provider/repositories/auth_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_state_notifier/flutter_state_notifier.dart';
import 'package:state_notifier/state_notifier.dart';

class AuthProvider extends StateNotifier<AuthState> with LocatorMixin {
  AuthProvider() : super(AuthState.unknown());

  // void update(fbAuth.User? user) {
  //   if (user != null) {
  //     _state =
  //         _state.copyWith(authStatus: AuthStatus.authenticated, user: user);
  //   } else {
  //     _state =
  //         _state.copyWith(authStatus: AuthStatus.unauthenticated, user: user);
  //   }
  //   print('authState: $_state');
  //   notifyListeners();
  // }

  @override
  void update(Locator watch) {
    final user = watch<fbAuth.User?>();
    if (user != null) {
      state = state.copyWith(authStatus: AuthStatus.authenticated, user: user);
    } else {
      state =
          state.copyWith(authStatus: AuthStatus.unauthenticated, user: user);
    }
    print('authState: $state');
    super.update(watch);
  }

  void signout() async {
    await read<AuthRepository>().signout();
  }
}
