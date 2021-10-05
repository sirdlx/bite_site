import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

String userDocPath = '/users';

class AuthService {
  static final _auth = FirebaseAuth.instance;
  static final _firestore = FirebaseFirestore.instance;

  static Future<User?> signUpUser(
      String name, String email, String password) async {
    print('email::$email');
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
    User? signedInUser = authResult.user;
    print('path::$userDocPath/${signedInUser!.email}');
    if (signedInUser != null) {
      _firestore.doc('$userDocPath/$email').set({
        'displayName': name,
        'email': email,
        'phone': '9094879111',
        // 'profileImageUrl': '',
      });
      return Future.value(signedInUser);
    }
  }

  static Future logout() {
    return _auth.signOut();
  }

  static Future<UserCredential?> login(String email, String password) async {
    return await _auth.signInWithEmailAndPassword(
        email: email, password: password);
    //   .onError((error, stackTrace) {
    // var _message = 'Error::Auth:: ';
    // var errorObj = {'error_number': 500, 'message': 'Invalid credentials'};

    // if ((error.toString()).contains('user-not-found')) {
    //   return Future.error('Invalid email or password');
    // }

    // return Future.error(error.toString());
    // });
  }
}
