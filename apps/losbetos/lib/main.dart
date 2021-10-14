import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:losbetosapp/src/features/settings/settings_controller.dart';
import 'package:losbetosapp/src/features/settings/settings_service.dart';

import 'package:url_strategy/url_strategy.dart';

import 'src/app.dart';

//
final settingsController = SettingsController(SettingsService());
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

  await settingsController.loadSettings();

  runApp(FutureBuilder(
    future: Future.delayed(const Duration(milliseconds: 0)),
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
        return ProviderScope(
            child: MyApp(settingsController: settingsController));
      }

      return _view(_loading);
    },
  ));

  // Set up the SettingsController, which will glue user settings to multiple
  // Flutter Widgets.

  // Load the user's preferred theme while the splash screen is displayed.
  // This prevents a sudden theme change when the app is first displayed.

  // Run the app and pass in the SettingsController. The app listens to the
  // SettingsController for changes, then passes it further down to the
  // SettingsView.
  // runApp();
}
