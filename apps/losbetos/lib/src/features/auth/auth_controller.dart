import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final authControllerProvider = StateNotifierProvider<AuthController, User?>(
  (ref) => AuthController(
      // ref.read,
      )
    ..appStarted(),
);

class AuthController extends StateNotifier<User?> {
  // final Reader _read;

  StreamSubscription<User?>? _authStateChangesSubscription;

  AuthController(
      // this._read,
      )
      : super(null) {
    _authStateChangesSubscription?.cancel();
    // _authStateChangesSubscription = _read(firebaseAuthRepositoryProvider)
    //     .authStateChanges
    //     .listen((user) => state = user);
  }

  @override
  void dispose() {
    _authStateChangesSubscription?.cancel();
    super.dispose();
  }

  void appStarted() async {
    // final user = _read(firebaseAuthRepositoryProvider).getCurrentUser();
    // if (user == null) {
    // await _read(firebaseAuthRepositoryProvider).signInAnonymously();
    // }
  }

  void signOut() async {
    // await _read(firebaseAuthRepositoryProvider).signOut();
  }
}
