import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:losbetosapp/src/features/settings/settings_controller.dart';
import 'package:losbetosapp/src/features/settings/settings_service.dart';

import 'package:url_strategy/url_strategy.dart';

import 'src/app.dart';

final settingsController = SettingsController(SettingsService());
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

  runApp(FutureBuilder(
    future: Firebase.initializeApp()
        .then((value) => Future.delayed(const Duration(seconds: 4))),
    builder: (context, snapshot) {
      const _loading = Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
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

      return _view(_loading);
    },
  ));

  // Set up the SettingsController, which will glue user settings to multiple
  // Flutter Widgets.

  // Load the user's preferred theme while the splash screen is displayed.
  // This prevents a sudden theme change when the app is first displayed.
  await settingsController.loadSettings();

  // Run the app and pass in the SettingsController. The app listens to the
  // SettingsController for changes, then passes it further down to the
  // SettingsView.
  runApp(ProviderScope(child: MyApp(settingsController: settingsController)));
}
