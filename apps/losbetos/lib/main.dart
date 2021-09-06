import 'package:firebase_core/firebase_core.dart';
import 'package:flavor_client/components/page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart' as Riverpod;
import 'package:google_sign_in/google_sign_in.dart';
import 'package:losbetos/components/future_state.dart';
import 'package:losbetos/components/theme.dart';
import 'package:losbetos/state/state.dart';
import 'package:url_strategy/url_strategy.dart';
import 'package:provider/provider.dart' as Provider;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  setPathUrlStrategy();

  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    statusBarBrightness: Brightness.dark,
  ));

  runApp(
    Riverpod.ProviderScope(
      child: Provider.ChangeNotifierProvider(
        create: (_) => AppState(),
        child: BiteBootstrap(),
      ),
    ),
  );
}

class BiteBootstrap extends StatelessWidget {
  // ignore: unused_fieldcl
  final GoogleSignIn _googleSignInAdmin = GoogleSignIn(
    // Optional clientId
    // clientId: '479882132969-9i9aqik3jfjd7qhci1nqf0bm2g71rm1u.apps.googleusercontent.com',
    scopes: <String>[
      'email',
      'https://www.googleapis.com/auth/youtube',
      'https://www.googleapis.com/auth/youtube.channel-memberships.creator',
      'https://www.googleapis.com/auth/youtube.force-ssl',
      'https://www.googleapis.com/auth/youtube.readonly	',
      'https://www.googleapis.com/auth/youtube.upload',
      'https://www.googleapis.com/auth/youtubepartner	',
      'https://www.googleapis.com/auth/youtubepartner-channel-audit',
    ],
  );

  // ignore: unused_field
  final GoogleSignIn _googleSignInUser = GoogleSignIn(
    // Optional clientId
    // clientId: '479882132969-9i9aqik3jfjd7qhci1nqf0bm2g71rm1u.apps.googleusercontent.com',
    scopes: <String>[
      'email',
    ],
  );

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

    var app = context.watch<AppState>();
    print(
        'app.useDark ? ThemeMode.dark : ThemeMode.light :: ${app.useDark ? ThemeMode.dark : ThemeMode.light}');
    if (app.alreadyInit) {
      return MaterialApp(
        navigatorKey: GlobalNav,
        debugShowCheckedModeBanner: false,
        themeMode: app.useDark ? ThemeMode.dark : ThemeMode.light,
        darkTheme: darkTheme(textTheme),
        theme: lightTheme(textTheme),
        // initialRoute: '/',
        onUnknownRoute: (settings) {
          return MaterialPageRoute(
            builder: (context) => PageError(
              errorCode: 404.toString(),
              msg: 'Unable to find "${settings.name}"',
            ),
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
      doneWidgetBuilder: (context, app) => MaterialApp(
        navigatorKey: GlobalNav,
        debugShowCheckedModeBanner: false,
        themeMode: app.useDark ? ThemeMode.dark : ThemeMode.light,
        darkTheme: darkTheme(textTheme),
        theme: lightTheme(textTheme),
        // initialRoute: '/',
        onUnknownRoute: (settings) {
          return MaterialPageRoute(
            builder: (context) => PageError(
              errorCode: 404.toString(),
              msg: 'Unable to find "${settings.name}"',
            ),
          );
        },

        onGenerateRoute: app.router.generateRoute,
      ),
    );
  }
}
