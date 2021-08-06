import 'package:flutter/cupertino.dart';

// ignore: non_constant_identifier_names
final GlobalKey<NavigatorState> GlobalNav = GlobalKey<NavigatorState>();

class AppState extends ChangeNotifier {
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
}

class BSUser {}
