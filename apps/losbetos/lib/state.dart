import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:losbetos/pages/cart.dart';

// ignore: non_constant_identifier_names
final GlobalKey<NavigatorState> GlobalNav = GlobalKey<NavigatorState>();
final GlobalKey<ScaffoldState> homeScaffoldKey = GlobalKey<ScaffoldState>();

class AppState extends ChangeNotifier {
  final Box? appBox;
  AppState(this.appBox) {
    if (appBox == null) {
      return;
    }

    _useDark = appBox!.get('_useDark') ?? _useDark;
    _user = appBox!.get('_user');
  }

  bool _useDark = false;

  bool get useDark => _useDark;

  set useDark(bool value) {
    _useDark = !useDark;
    notifyListeners();
  }

  BSUser? _user;
  BSUser? get user => _user != null ? _user! : null;

  set user(BSUser? newUser) {
    _user = newUser;
    notifyListeners();
  }

  final BSCart cart = BSCart();
}

class BSUser {}
