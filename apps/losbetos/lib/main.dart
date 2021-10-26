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
}
