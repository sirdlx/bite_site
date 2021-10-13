import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flavor_auth/flavor_auth.dart';
import 'package:flutter/services.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:losbetosapp/src/config/paths.dart';

abstract class BaseAuthRepository {
  Stream<User?> get authStateChanges;
  Future<void> signInAnonymously();
  User? getCurrentUser();
  Future<void> signOut();

  // Future<User> signUpWithEmailAndPassword({
  //   required String username,
  //   required String email,
  //   required String password,
  // });
  // Future<User> logInWithEmailAndPassword({
  //   required String email,
  //   required String password,
  // });
}

final firebaseAuthRepositoryProvider =
    Provider<FirebaseAuthRepository>((ref) => FirebaseAuthRepository(ref.read));

class FirebaseAuthRepository implements BaseAuthRepository {
  static final _auth = FirebaseAuth.instance;
  static final _firestore = FirebaseFirestore.instance;

  final Reader _read;

  const FirebaseAuthRepository(this._read);

  @override
  Stream<User?> get authStateChanges =>
      _read(firebaseAuthProvider).authStateChanges();

  @override
  Future<void> signInAnonymously() async {
    try {
      await _read(firebaseAuthProvider).signInAnonymously();
    } on FirebaseAuthException catch (e) {
      throw CustomException(message: e.message);
    }
  }

  @override
  User? getCurrentUser() {
    try {
      return _read(firebaseAuthProvider).currentUser;
    } on FirebaseAuthException catch (e) {
      throw CustomException(message: e.message);
    }
  }

  @override
  Future<void> signOut() async {
    try {
      await _read(firebaseAuthProvider).signOut();
      await signInAnonymously();
    } on FirebaseAuthException catch (e) {
      throw CustomException(message: e.message);
    }
  }

  Future<FlavorUser> signUpWithEmailAndPassword({
    required String displayName,
    required String email,
    required String password,
  }) async {
    UserCredential authResult = await _auth
        .createUserWithEmailAndPassword(
      email: email,
      password: password,
    )
        .onError((error, stackTrace) {
      if (error.toString().contains('firebase_auth/email-already-in-use')) {
        return Future.error('Email "$email" is already in use. ');
      }
      return Future.error(error!);
    });
    User signedInUser = authResult.user!;

    print('path::${Paths.users}/${signedInUser.email}');
    return await _firestore
        .doc('${Paths.users}/${signedInUser.email}')
        .get()
        .then((value) async {
      if (value.exists) {
        var data = value.data();
        return FlavorUser(
          displayName:
              data!.containsKey('displayName') ? data['displayName'] : null,
          email: data.containsKey('email') ? data['email'] : null,
          emailVerified:
              data.containsKey('emailVerified') ? data['emailVerified'] : null,
          localId: data.containsKey('uid') ? data['uid'] : null,
          photoUrl: signedInUser.photoURL,
          refreshToken: signedInUser.refreshToken,
        );
      } else {
        var user = FlavorUser(
          displayName: displayName,
          email: signedInUser.email,
          emailVerified: signedInUser.emailVerified,
          localId: signedInUser.uid,
          photoUrl: signedInUser.photoURL,
          refreshToken: signedInUser.refreshToken,
        );

        await _firestore.doc('${Paths.users}/$email').set(user.toMap());

        return user;
      }
    });
  }

  Future<FlavorUser> logInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    return await _auth
        .signInWithEmailAndPassword(email: email, password: password)
        .then((value) {
      return FirebaseFirestore.instance
          .doc('/users/${value.user!.email}')
          .get();
    }).then((DocumentSnapshot<Map<String, dynamic>> userJson) {
      var data = userJson.data();
      print('data::$data');

      if (data == null) {
        return Future.error({'message': 'No user data'});
      }
      return FlavorUser(
        displayName: data['displayName'],
        email: data['email'],
        emailVerified: data['emailVerified'],
        localId: data['localId'],
      );
    });
  }
}

class CustomException implements Exception {
  final String? message;

  const CustomException({this.message = 'Something went wrong!'});

  @override
  String toString() => 'CustomException { message: $message }';
}

final firebaseAuthProvider =
    Provider<FirebaseAuth>((ref) => FirebaseAuth.instance);

final firebaseFirestoreProvider =
    Provider<FirebaseFirestore>((ref) => FirebaseFirestore.instance);
