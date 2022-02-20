import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:losbetosapp/src/features/app/app_controller.dart';
import 'package:losbetosapp/src/themes/theme.dart';

/// The Widget that configures your application.
class LBApp extends StatelessWidget {
  const LBApp({
    Key? key,
    required this.appController,
  }) : super(key: key);

  final AppController appController;

  @override
  Widget build(BuildContext context) {
    // return LBMaterialApp(appController: appController);
    return AnimatedBuilder(
      animation: appController,
      builder: (BuildContext context, Widget? child) {
        return LBMaterialApp(appController: appController);
      },
    );
  }
}

class LBMaterialApp extends StatelessWidget {
  const LBMaterialApp({
    Key? key,
    required this.appController,
  }) : super(key: key);

  final AppController appController;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // Providing a restorationScopeId allows the Navigator built by the
      // MaterialApp to restore the navigation stack when a user leaves and
      // returns to the app after it has been killed while running in the
      // background.
      restorationScopeId: 'app',

      // Provide the generated AppLocalizations to the MaterialApp. This
      // allows descendant Widgets to display the correct translations
      // depending on the user's locale.
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('en', ''), // English, no country code
      ],

      // Use AppLocalizations to configure the correct application title
      // depending on the user's locale.
      //
      // The appTitle is defined in .arb files found in the localization
      // directory.
      onGenerateTitle: (BuildContext context) =>
          AppLocalizations.of(context)!.appTitle,
      themeMode: appController.themeMode,
      // Define a light and dark color theme. Then, read the user's
      // preferred ThemeMode (light, dark, or system default) from the
      // AppController to display the correct theme.
      navigatorKey: appController.globalNavKey,
      debugShowCheckedModeBanner: false,
      darkTheme: darkTheme2(Colors.red, textTheme),
      theme: lightTheme2(Colors.red, textTheme),
      // Define a function to handle named routes in order to support
      // Flutter web url navigation and deep linking.
      onGenerateRoute: appController.router.generateRoute,
    );
  }
}
