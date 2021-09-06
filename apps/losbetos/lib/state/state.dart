import 'package:firebase_auth/firebase_auth.dart';
import 'package:flavor_auth/flavor_auth.dart';
import 'package:flavor_client/repository/firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:losbetos/models/models.dart';
import 'package:flavor_client/components/route.dart';
import 'package:losbetos/screens/account.dart';
import 'package:losbetos/screens/category.dart';
import 'package:losbetos/screens/layout.dart';
import 'package:losbetos/screens/menu.dart';
import 'package:losbetos/screens/menu_item.dart';
import 'package:losbetos/screens/settings.dart';
import 'package:regex_router/regex_router.dart';

// ignore: non_constant_identifier_names
final GlobalKey<NavigatorState> GlobalNav = GlobalKey<NavigatorState>();
final GlobalKey<ScaffoldState> homeScaffoldKey = GlobalKey<ScaffoldState>();

final globalAppState = StateProvider<AppState>((ref) => AppState());

class AppStateNotifier extends StateNotifier<AppState> {
  AppStateNotifier() : super(AppState());
}

class AppState with ChangeNotifier, DiagnosticableTreeMixin {
  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(IntProperty('count', cart.items.length));
  }

  late Box? appBox;
  bool alreadyInit = false;

  AppState();
  Future<AppState> init() async {
    if (alreadyInit) {
      return this;
    }
    await Hive.initFlutter();
    appBox = await Hive.openBox('losbetos_app');
    loadAppSettings();
    alreadyInit = true;
    return this;
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
  }

  BSCart cart = BSCart();

  get router => RegexRouter.create({
        // "/": (context, _) => AppLayoutWidget(),
        "/": (context, _) => ScreenLayout(routes: routesForDrawer),
        "/menu/category/:catId/item/:itemId/": (context, args) =>
            ScreenMenuItem(id: args["itemId"]!),
        "/menu/category/:catId": (context, args) =>
            ScreenCategory(id: args["catId"]!),
      });

  updateQuanity(int index, int quanity) {
    cart.items[index].quanity = quanity;
  }

  void updateAndSave() {
    print('updateAndSave()::_useDark::$_useDark');
    appBox!.put('_user', user != null ? user!.toJson() : null);
    appBox!.put('_cart', {'cart': cart.toList()});
    appBox!.put('_useDark', _useDark);
    notifyListeners();
  }

  void loadAppSettings() {
    // appBox!.delete('_cart');

    //
    _useDark = appBox!.get('_useDark') ?? _useDark;
    print('loadAppSettings()::_useDark::$_useDark');
    //
    var __user = appBox!.get('_user');
    print('loadAppSettings()::__user::$__user');
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
    cart.add(bsCartMenuItem);
    updateAndSave();
  }

  logoutUser() {
    FirebaseAuth.instance.signOut();
    user = null;
    updateAndSave();
  }

  signInUser() {
    user = null;
    updateAndSave();
  }

  List<FlavorRouteWidget> get dashRoutes {
    if (user != null) {}
    return [
      FlavorRouteWidget(
        path: '/',
        icon: CupertinoIcons.home,
        title: 'Menu',
        child: ScreenMenu(),
        backgroundColor: Colors.green,
        routeInDrawer: true,
      ),
      FlavorRouteWidget(
        path: '/account',
        icon: CupertinoIcons.person,
        title: 'Account',
        child: ScreenAccount(),
        backgroundColor: Colors.green,
        routeInDrawer: true,
      ),
      FlavorRouteWidget(
        path: '/settings',
        icon: CupertinoIcons.settings,
        title: 'Settings',
        child: ScreenSettings(),
        backgroundColor: Colors.green,
        routeInDrawer: true,
      ),
    ];
  }

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
}

MaterialPageRoute bitePage(RouteSettings settings, Widget screen) =>
    MaterialPageRoute(
      builder: (context) => screen,
      fullscreenDialog: true,
      maintainState: true,
      settings: settings,
    );
