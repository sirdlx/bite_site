import 'package:firebase_auth/firebase_auth.dart';
import 'package:flavor_auth/flavor_auth.dart';
import 'package:flavor_client/repository/firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:losbetos/pages/account.dart';
import 'package:losbetos/pages/cart.dart';
import 'package:flavor_client/components/route.dart';
import 'package:losbetos/components/appLayout.dart';
import 'package:losbetos/pages/menu.category.detail.dart';
import 'package:losbetos/pages/menu.dart';
import 'package:losbetos/pages/menu.item.detail.dart';
import 'package:losbetos/pages/settings.dart';
import 'package:regex_router/regex_router.dart';

// ignore: non_constant_identifier_names
final GlobalKey<NavigatorState> GlobalNav = GlobalKey<NavigatorState>();
final GlobalKey<ScaffoldState> homeScaffoldKey = GlobalKey<ScaffoldState>();

class AppState extends ChangeNotifier {
  final Box? appBox;
  AppState(this.appBox) {
    if (appBox == null) {
      return;
    } else {
      loadAppSettings();
    }
  }

  bool _useDark = false;

  bool get useDark => _useDark;

  set useDark(bool value) {
    _useDark = !useDark;
    updateAndSave();
  }

  FlavorUser? _user;
  FlavorUser? get user => _user != null ? _user! : null;

  set user(FlavorUser? newUser) {
    _user = newUser;
    if (_user != null) {
      FlavorFirestoreRepository()
          .firestore
          .doc('users/${_user!.email}')
          .set(_user!.toJson() as Map<String, dynamic>);
    }
    updateAndSave();
    notifyListeners();
  }

  BSCart cart = BSCart();

  final router = RegexRouter.create({
    "/": (context, _) => AppLayoutWidget(),
    "/menu/category/:catId/item/:itemId/": (context, args) =>
        PageMenuItem(id: args["itemId"]!),
    "/menu/category/:catId": (context, args) =>
        PageCategory(id: args["catId"]!),
    // "/account": (context, args) => Builder(
    //       builder: (context) {
    //         var app = context.read<AppState>();
    //         if (app.user != null) {
    //           return PageAccount();
    //         }
    //         // return FlavorOnboardingV3(
    //         //   gApiKey: 'AIzaSyDaGm_f6SvznyHIQnPHk7s4V2UygStMb6g',
    //         //   isLoggedIn: app.user != null,
    //         //   onEmailLogin: (email, password) => FirebaseAuth.instance
    //         //       .signInWithEmailAndPassword(email: email, password: password)
    //         //       .then(
    //         //     (value) {
    //         //       print('hee');
    //         //       return app.user = FlavorUser(
    //         //         displayName: value.user!.displayName,
    //         //         email: value.user!.email,
    //         //         emailVerified: value.user!.emailVerified,
    //         //         localId: value.user!.uid,
    //         //         photoUrl: value.user!.photoURL,
    //         //       );
    //         //     },
    //         //   ).then((value) => GlobalNav.currentState!.popAndPushNamed('/')),
    //         //   // onEmailLogin: (email, password) {
    //         //   //   print('$email, $password');
    //         //   //   return Future.value();
    //         //   // },
    //         //   onEmailSignup: (email, password, passwordReEnter) =>
    //         //       FirebaseAuth.instance
    //         //           .createUserWithEmailAndPassword(
    //         //     email: email,
    //         //     password: password,
    //         //   )
    //         //           .then((value) {
    //         //     print(value);
    //         //     return app.user = FlavorUser(
    //         //       displayName: value.user!.displayName,
    //         //       email: value.user!.email,
    //         //       emailVerified: value.user!.emailVerified,
    //         //       localId: value.user!.uid,
    //         //       photoUrl: value.user!.photoURL,
    //         //     );
    //         //   }).then((value) => GlobalNav.currentState!.popAndPushNamed('/')),
    //         // );
    //       },
    //     ),
  });

  updateQuanity(int index, int quanity) {
    cart.items[index].quanity = quanity;
    notifyListeners();
  }

  void updateAndSave() {
    appBox!.put('_user', user != null ? user!.toJson() : null);
    appBox!.put('_cart', {'cart': cart.toList()});
    appBox!.put('_useDark', _useDark);
    notifyListeners();
  }

  void loadAppSettings() {
    // appBox!.delete('_cart');

    //
    _useDark = appBox!.get('_useDark') ?? _useDark;
    //
    var __user = appBox!.get('_user');
    print(__user);
    _user = __user != null
        ? FlavorUser(
            displayName: __user['displayName'],
            email: __user['email'],
            emailVerified: __user['emailVerified'],
            localId: __user['localId'],
          )
        : null;

    //
    Map _cart = appBox!.get('_cart') ?? {};
    if (_cart.containsKey('cart')) {
      // print(_cart['cart'][0]);
      List _items = _cart['cart'];
      cart = BSCart.fromList(_items);
    }
  }

  void addToCart(BSCartMenuItem bsCartMenuItem) {
    cart.items.add(bsCartMenuItem);
    updateAndSave();
    notifyListeners();
  }

  logoutUser() {
    FirebaseAuth.instance.signOut();
    user = null;
    notifyListeners();
    updateAndSave();
  }

  signInUser() {
    user = null;
    updateAndSave();
    notifyListeners();
  }
}

final List<FlavorRouteWidget> dashRoutes = [
  FlavorRouteWidget(
    path: '/',
    icon: CupertinoIcons.home,
    title: 'Menu',
    child: PageMenu(),
    backgroundColor: Colors.green,
    routeInDrawer: true,
  ),
  // FlavorRouteWidget(
  //   path: '/',
  //   icon: CupertinoIcons.home,
  //   title: 'Home',
  //   child: BiteSiteHomeBody(),
  //   backgroundColor: Colors.green,
  //   routeInDrawer: true,
  // ),

  FlavorRouteWidget(
    path: '/cart',
    icon: CupertinoIcons.shopping_cart,
    title: 'Cart',
    child: PageCartView(),
    backgroundColor: Colors.green,
    routeInDrawer: true,
  ),

  // FlavorRouteWidget(
  //   path: '/orders',
  //   icon: CupertinoIcons.bag_fill,
  //   title: 'Orders',
  //   child: BiteSiteHomeBody(),
  //   backgroundColor: Colors.green,
  //   routeInDrawer: true,
  // ),

  FlavorRouteWidget(
    path: '/account',
    icon: CupertinoIcons.person,
    title: 'Account',
    child: PageAccount(),
    backgroundColor: Colors.green,
    routeInDrawer: true,
  ),
  // FlavorRouteWidget(
  //   path: '/category',
  //   icon: CupertinoIcons.settings,
  //   title: 'Category',
  //   child: PageCategory(),
  //   backgroundColor: Colors.green,
  //   routeInDrawer: false,
  // ),

  FlavorRouteWidget(
    path: '/settings',
    icon: CupertinoIcons.settings,
    title: 'Settings',
    child: PageSettings(),
    backgroundColor: Colors.green,
    routeInDrawer: true,
  ),
];

List<FlavorRouteWidget> get routesForDrawer {
  List<FlavorRouteWidget> arr = [];
  for (var i = 0; i < dashRoutes.length; i++) {
    FlavorRouteWidget ii = dashRoutes[i];
    if (ii.routeInDrawer == true) {
      arr.add(ii);
    }
  }

  return arr;
}

MaterialPageRoute bitePage(RouteSettings settings, Widget screen) =>
    MaterialPageRoute(
      builder: (context) => screen,
      fullscreenDialog: true,
      maintainState: true,
      settings: settings,
    );
