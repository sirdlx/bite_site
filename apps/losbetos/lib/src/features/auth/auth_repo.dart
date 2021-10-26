import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flavor_auth/flavor_auth.dart';

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:losbetosapp/src/config/paths.dart';

abstract class BaseAuthRepository {
  // Stream<User?> get authStateChanges;
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

// final firebaseAuthRepositoryProvider =
//     Provider<FirebaseAuthRepository>((ref) => FirebaseAuthRepository(ref.read));

class FirebaseAuthRepository implements BaseAuthRepository {
  static final fbAuth = FirebaseAuth.instance;
  static final firestore = FirebaseFirestore.instance;

  Future init() async {
    // print('_user == null');

    // // print(_user == null);
    // if (_user == null) {
    //   print('_repo.signInAnonymously');
    //   // await _repo.signInAnonymously();
    // }
  }

  Stream<User?> get authStateChanges => fbAuth.userChanges();

  @override
  Future<void> signInAnonymously() async {
    try {
      await fbAuth.signInAnonymously();
      // .then((cred) => FlavorUser(
      //       email: cred.user!.email,
      //       isAnonymous: true,
      //       localId: cred.user!.uid,
      //       refreshToken: cred.user!.refreshToken,
      //     ));
    } on FirebaseAuthException catch (e) {
      throw CustomException(message: e.message);
    }
  }

  @override
  User? getCurrentUser() {
    try {
      return fbAuth.currentUser;
      // return _read(firebaseAuthProvider).currentUser;
    } on FirebaseAuthException catch (e) {
      throw CustomException(message: e.message);
    }
  }

  @override
  Future<void> signOut() async {
    try {
      // await _read(firebaseAuthProvider).signOut();
      await fbAuth.signOut();
      // return signInAnonymously().then((value) {
      //   return FlavorUser(
      //     displayName: value.user!.displayName,
      //     email: value.user!.email,
      //     emailVerified: value.user!.emailVerified,
      //     localId: value.user!.uid,
      //     photoUrl: value.user!.photoURL,
      //     refreshToken: value.user!.refreshToken,
      //   );
      // });
    } on FirebaseAuthException catch (e) {
      throw CustomException(message: e.message);
    }
  }

  Future<FlavorUser> signUpWithEmailAndPassword({
    required String displayName,
    required String email,
    required String password,
  }) async {
    UserCredential authResult = await fbAuth
        .createUserWithEmailAndPassword(
      email: email,
      password: password,
    )
        .onError((error, stackTrace) {
      if (error.toString().contains('firebasefbAuth/email-already-in-use')) {
        return Future.error('Email "$email" is already in use. ');
      }
      return Future.error(error!);
    });
    User signedInUser = authResult.user!;

    // ignore: avoid_print
    print('path::${Paths.users}/${signedInUser.email}');
    return await firestore
        .doc('${Paths.users}/${signedInUser.email}')
        .get()
        .then((value) async {
      if (value.exists) {
        var data = value.data();
        return FlavorUser(
          displayName:
              data!.containsKey('display_name') ? data['display_name'] : null,
          phoneNumber:
              data.containsKey('phone_number') ? data['phone_number'] : null,
          email: signedInUser.email,
          emailVerified: signedInUser.emailVerified,
          localId: signedInUser.uid,
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

        await firestore.doc('${Paths.users}/$email').set(user.toMap());

        return user;
      }
    });
  }

  Future<FlavorUser> logInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    return await fbAuth
        .signInWithEmailAndPassword(email: email, password: password)
        .then((value) {
      return FirebaseFirestore.instance
          .doc('/users/${value.user!.email}')
          .get();
    }).then((DocumentSnapshot<Map<String, dynamic>> userJson) {
      var data = userJson.data();
      // print('data::$data');

      if (data == null) {
        return Future.error({'message': 'No user data'});
      }
      return FlavorUser(
        displayName: data['display_name'],
        email: data['email'],
        emailVerified: data['emailVerified'],
        localId: data['localId'],
      );
    });
  }

  Future<FlavorUser> loginFromFBCache({
    required User user,
  }) async {
    if (user.isAnonymous) {
      return FlavorUser(
        email: user.email,
        isAnonymous: true,
        localId: user.uid,
        refreshToken: user.refreshToken,
      );
    }

    return firestore
        .doc('/users/${user.email}')
        .get()
        .then((DocumentSnapshot<Map<String, dynamic>> userJson) {
      var data = userJson.data();
      // print('data::$data');

      if (data == null) {
        return Future.error({'message': 'No user data'});
      }
      return FlavorUser(
        email: user.email,
        emailVerified: user.emailVerified,
        localId: user.uid,
        phoneNumber: data['phone_number'],
        displayName: data['display_name'],
        refreshToken: user.refreshToken,
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
