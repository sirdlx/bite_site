import 'package:firebase_auth/firebase_auth.dart';
import 'package:flavor_auth/flavor_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:losbetosapp/src/features/auth/auth_repo.dart';

final authControllerProvider = ChangeNotifierProvider<LBAuthNotifier>((ref) {
  return LBAuthNotifier();
});

class LBAuthNotifier extends ChangeNotifier {
  LBAuthNotifier() : super() {
    FirebaseAuth.instance.authStateChanges().listen((event) async {
      if (event == null) {
        _user = FlavorUser(isAnonymous: true);

        // await repo.signInAnonymously();
      } else {
        _user = await repo.loginFromFBCache(user: event);
      }

      print('user::$_user');
    });

    repo.authStateChanges.listen((event) async {
      // if (_user != null && event != null && _user?.localId == event.uid) {
      //   return;
      // }
      if (event == null) {
        _user = FlavorUser(isAnonymous: true);

        // await repo.signInAnonymously();
      } else {
        _user = await repo.loginFromFBCache(user: event);
      }
      // print('here::$_user');

      notifyListeners();
    });
  }
  FlavorUser? _user;
  FlavorUser? get user => _user;
  final FirebaseAuthRepository repo = FirebaseAuthRepository();
  // set user(User newUser) => FlavorUser.fromJson(newUser.);

  Future<void> signUpWithEmailAndPassword({
    required String displayName,
    required String email,
    required String password,
  }) async {
    _user = await repo.signUpWithEmailAndPassword(
        displayName: displayName, email: email, password: password);
  }

  Future<void> logInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    _user =
        await repo.logInWithEmailAndPassword(email: email, password: password);
  }

  Future<void> signInAnonymously() async {
    // return repo.signInAnonymously();
  }
}
