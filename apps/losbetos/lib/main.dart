import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart' as Riverpod;
import 'package:losbetos/components/future_state.dart';
import 'package:losbetos/themes/theme.dart';
import 'package:losbetos/state/state.dart';
import 'package:losbetos/themes/light.dart';
import 'package:url_strategy/url_strategy.dart';
import 'package:provider/provider.dart' as Provider;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  setPathUrlStrategy();

  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    statusBarBrightness: Brightness.dark,
  ));

  runApp(Riverpod.ProviderScope(
    child: Provider.ChangeNotifierProvider(
      create: (_) => AppState(),
      child: BiteBootstrap(),
    ),
  ));
}

class BiteBootstrap extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight
    ]);

    var app = context.watch<AppState>();
    print(
        'app.useDark ? ThemeMode.dark : ThemeMode.light :: ${app.useDark ? ThemeMode.dark : ThemeMode.light}');
    if (app.alreadyInit) {
      return MaterialApp(
        navigatorKey: GlobalNav,
        debugShowCheckedModeBanner: false,
        themeMode: app.useDark ? ThemeMode.dark : ThemeMode.light,
        darkTheme: darkTheme(Colors.red, textTheme),
        theme: lightTheme(Colors.red, textTheme),
        // theme: LBThemeLight,

        // initialRoute: '/',
        onUnknownRoute: (settings) {
          return MaterialPageRoute(
            //   builder: (context) => PageError(
            //     errorCode: 404.toString(),
            //     msg: 'Unable to find "${settings.name}"',
            //   ),
            // );
            builder: (context) => Container(),
            fullscreenDialog: true,

            settings: settings,
            maintainState: true,
          );
        },

        onGenerateRoute: app.router.generateRoute,
      );
    }
    return FutureState<AppState>(
      future: Future.delayed(Duration(milliseconds: 300))
          .then((value) => Firebase.initializeApp())
          .then((value) => app.init()),
      waitingWidget: Container(
        color: Colors.white,
        constraints: BoxConstraints(minHeight: 200, maxHeight: 200),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // CircularProgressIndicator(),
              // SizedBox(
              //   height: 16,
              // ),
              SizedBox(
                child: Image.asset('assets/images/logo.png'),
                width: 300,
              ),
            ],
          ),
        ),
      ),
      doneWidgetBuilder: (context, app) {
        return MaterialApp(
          navigatorKey: GlobalNav,
          debugShowCheckedModeBanner: false,
          themeMode: app.useDark ? ThemeMode.dark : ThemeMode.light,
          darkTheme: darkTheme(LBThemeLight.primaryColor, textTheme),
          theme: lightTheme(LBThemeLight.primaryColor, textTheme),
          // initialRoute: '/',
          // onUnknownRoute: (settings) {
          //   return MaterialPageRoute(
          //     builder: (context) => PageError(
          //       errorCode: 404.toString(),
          //       msg: 'Unable to find "${settings.name}"',
          //     ),
          //   );
          // },

          onGenerateRoute: app.router.generateRoute,
        );
      },
    );
  }
}
