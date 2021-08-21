import 'package:algolia/algolia.dart';
import 'package:flavor_client/components/page.dart';
import 'package:flavor_client/pages/onboarding/onboarding_v3.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:losbetos/components/appLayout.dart';
import 'package:losbetos/components/theme.dart';
import 'package:losbetos/pages/menu.category.detail.dart';
import 'package:losbetos/pages/menu.item.detail.dart';
import 'package:losbetos/routes/routes.dart';
import 'package:losbetos/state.dart';
import 'package:provider/provider.dart';
import 'package:regex_router/regex_router.dart';
import 'package:url_strategy/url_strategy.dart';

final Algolia algolia = Algolia.init(
  applicationId: '29GNM5X5TX',
  apiKey: '9242bfc2fc4529a96a0d0fa25426c0b1',
);

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  setPathUrlStrategy();

  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    statusBarBrightness: Brightness.dark,
  ));

  await Hive.initFlutter();
  var appBox = await Hive.openBox('losbetos_app');

  runApp(
    ChangeNotifierProvider<AppState>(
      create: (context) => AppState(appBox),
      child: BiteBootstrap(),
    ),
  );
}

class BiteBootstrap extends StatefulWidget {
  const BiteBootstrap({Key? key}) : super(key: key);

  @override
  _BiteBootstrapState createState() => _BiteBootstrapState();
}

// ignore: unused_element
GoogleSignIn _googleSignInAdmin = GoogleSignIn(
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

// ignore: unused_element
GoogleSignIn _googleSignInUser = GoogleSignIn(
  // Optional clientId
  // clientId: '479882132969-9i9aqik3jfjd7qhci1nqf0bm2g71rm1u.apps.googleusercontent.com',
  scopes: <String>[
    'email',
  ],
);

class _BiteBootstrapState extends State<BiteBootstrap> {
  @override
  Widget build(BuildContext context) {
    var app = context.watch<AppState>();

    if (app.user == null) {}
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
}
