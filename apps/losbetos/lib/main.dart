import 'package:algolia/algolia.dart';
import 'package:flavor/components/page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:losbetos/components/appLayout.dart';
import 'package:losbetos/components/theme.dart';
import 'package:losbetos/pages/menu.category.detail.dart';
import 'package:losbetos/pages/login.dart';
import 'package:losbetos/pages/menu.item.detail.dart';
import 'package:losbetos/state.dart';
import 'package:provider/provider.dart';
import 'package:regex_router/regex_router.dart';
import 'package:url_strategy/url_strategy.dart';

final Algolia algolia = Algolia.init(
  applicationId: '29GNM5X5TX',
  apiKey: '9242bfc2fc4529a96a0d0fa25426c0b1',
);
Box? appBox;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  appBox = await Hive.openBox('losbetos_app');

  setPathUrlStrategy();

  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    statusBarBrightness: Brightness.dark,
  ));

  runApp(
    ChangeNotifierProvider<AppState>(
      create: (context) => AppState(appBox),
      child: BiteBootstrap(),
    ),
  );
}

final router = RegexRouter.create({
  "/": (context, _) => AppLayoutWidget(),
  "/:viewId": (context, args) => AppLayoutWidget(
        viewId: args["viewId"]!,
      ),
  "/menu/category/:catId/item/:itemId/": (context, args) =>
      PageMenuItem(id: args["itemId"]!),
  "/menu/category/:catId": (context, args) => PageCategory(id: args["catId"]!),
  "/login": (context, args) => LoginScreen(),
});

class BiteBootstrap extends StatelessWidget {
  const BiteBootstrap({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: GlobalNav,
      debugShowCheckedModeBanner: false,
      themeMode:
          context.watch<AppState>().useDark ? ThemeMode.dark : ThemeMode.light,
      darkTheme: darkTheme(textTheme),
      theme: lightTheme(textTheme),
      initialRoute: '/',
      onUnknownRoute: (settings) {
        return MaterialPageRoute(
          builder: (context) => PageError(
            errorCode: 404.toString(),
            msg: 'Unable to find "${settings.name}"',
          ),
        );
      },
      onGenerateRoute: router.generateRoute,
    );
  }

  MaterialPageRoute bitePage(RouteSettings settings, Widget screen) =>
      MaterialPageRoute(
        builder: (context) => screen,
        fullscreenDialog: true,
        maintainState: true,
        settings: settings,
      );
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
