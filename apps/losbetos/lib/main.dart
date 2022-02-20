import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:losbetosapp/losbetos.dart';
import 'package:losbetosapp/src/features/app/app_controller.dart';

import 'package:losbetosapp/src/features/settings/settings_service.dart';

import 'package:url_strategy/url_strategy.dart';

import 'src/features/app/app.dart';

//
final appController = AppController(SettingsService());
//
Widget _view(Widget child) => CupertinoApp(
      debugShowCheckedModeBanner: false,
      home: child,
    );
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  setPathUrlStrategy();

  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    statusBarBrightness: Brightness.dark,
  ));

  await Firebase.initializeApp();

  await appController.loadSettings();

  // runApp(LBAdmin());

  // var db = FirebaseFirestore.instance
  //     .collection('/apps/bitesite.losbetos/menu.test.1');

  // getMenuItemsAll.map((e) {
  //   db.add(e.toMap());
  // }).toList();

  runApp(FutureBuilder(
    future: Future.delayed(const Duration(milliseconds: 100)),
    builder: (context, snapshot) {
      var _loading = Scaffold(
        body: Center(
          child: Column(
            children: const [
              CircularProgressIndicator(),
            ],
          ),
        ),
      );
      const _error = Scaffold(
        body: Center(
          child: Text('Error'),
        ),
      );

      if (snapshot.hasData && snapshot.hasError) {
        _view(_error);
      }

      if (snapshot.connectionState == ConnectionState.done) {
        return ProviderScope(child: LBApp(appController: appController));
      }

      return _view(_loading);
    },
  ));
}
