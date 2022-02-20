import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flavor_auth/flavor_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_remix/flutter_remix.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:losbetosapp/src/components/route.dart';
import 'package:losbetosapp/src/features/admin/admin.dart';
import 'package:losbetosapp/src/features/cart/cart_controller.dart';
import 'package:losbetosapp/src/features/checkout/checkout.dart';
import 'package:losbetosapp/src/features/settings/settings_service.dart';
import 'package:losbetosapp/src/features/account/account_view.dart';
import 'package:losbetosapp/src/features/cart/cart_view.dart';
import 'package:losbetosapp/src/features/menu_category/menu_category_view.dart';
import 'package:losbetosapp/src/features/app/app_layout.dart';
import 'package:losbetosapp/src/features/menu/menu_view.dart';
import 'package:losbetosapp/src/features/menu_item/menu_item_view.dart';
import 'package:losbetosapp/src/features/orders/orders_view.dart';
import 'package:regex_router/regex_router.dart';

class AppController with ChangeNotifier {
  final GlobalKey<NavigatorState> globalNavKey = GlobalKey<NavigatorState>();
  final GlobalKey<ScaffoldState> homeScaffoldKey = GlobalKey<ScaffoldState>();

  bool? _isAdmin;
  Future isAdmin(FlavorUser user) async {
    if (_isAdmin != null) {
      return Future.value(_isAdmin);
    }
    var fs = FirebaseFirestore.instance;
    var _result = await fs
        .doc('/users/${user.email}')
        .get()
        .then((snap) => snap.data()?.containsKey('isAdmin'));
    _isAdmin = _result as bool;
    return Future.value(_result);
  }

  AppController(this._settingsService);

  final SettingsService _settingsService;

  late ThemeMode _themeMode = ThemeMode.system;

  ThemeMode get themeMode => _themeMode;

  Future<void> loadSettings() async {
    await Hive.initFlutter();
    appBox = await Hive.openBox('losbetos_app');
    loadAppSettingsFromDisk();
    notifyListeners();
  }

  Future<void> updateThemeMode(ThemeMode? newThemeMode) async {
    if (newThemeMode == null) return;

    if (newThemeMode == _themeMode) return;

    _themeMode = newThemeMode;

    await appBox!.put('_themeMode', _themeMode.toString());
    notifyListeners();
  }

  late Box? appBox;

  late CartController cart;

  get router => RegexRouter.create({
        // "/": (context, _) => AppLayoutWidget(),
        // "/": (context, _) => ScreenLayout(routes: routesForDrawer),
        "/": (context, _) => LBScreenLayout(routes: routesForDrawer),

        "/menu/category/:catId/item/:itemId/": (context, args) =>
            LBScreenMenuItem(id: args["itemId"]!),
        "/menu/category/:catId": (context, args) =>
            ScreenCategory(id: args["catId"]!),
        "/orders": (context, args) => const ScreenOrders(),
        "/orders/:orderID": (context, args) =>
            ScreenOrders(id: args["orderID"]!),
        "/checkout": (context, args) => const ScreenCheckout(),
        "/admin/": (context, args) => LBAdmin(),
      });

  void updateAndSave() {
    // print('updateAndSave()::_themeMode::$_themeMode');
    // appBox!.put('_user', user != null ? user!.toJson() : null);

    notifyListeners();
  }

  void loadAppSettingsFromDisk() {
    //
    String? __themeMode = appBox!.get('themeMode');
    if (__themeMode != null) {
      if (__themeMode == "ThemeMode.dark") {
        _themeMode = ThemeMode.dark;
      } else if (__themeMode == "ThemeMode.light") {
        _themeMode = ThemeMode.light;
      } else if (__themeMode == "ThemeMode.system") {
        _themeMode = ThemeMode.system;
      }
    }
    //
    // var __user = appBox!.get('user');
    cart = CartController(onUpdate: () {
      print('onUpdate');
      appBox!.put('cart', cart.cart.toJson());
    });
    String? _cart = appBox!.get('cart');
    print('_cart::$_cart');

    if (_cart != null) {
      cart.loadFromJson(_cart);
      notifyListeners();
    }
  }

  List<LBRouteWidget> get dashRoutes {
    return [
      LBRouteWidget(
        path: '/',
        icon: FlutterRemix.file_paper_line,
        title: 'Menu',
        child: const LBScreenMenu(),
        backgroundColor: Colors.green,
        routeInDrawer: true,
      ),
      LBRouteWidget(
        path: '/cart',
        icon: FlutterRemix.shopping_bag_2_line,
        title: 'Cart',
        child: const ScreenCartView(),
        backgroundColor: Colors.green,
        routeInDrawer: true,
      ),
      LBRouteWidget(
        path: '/ordrers',
        icon: FlutterRemix.history_line,
        title: 'Orders',
        child: const ScreenOrders(),
        routeInDrawer: true,
      ),
      LBRouteWidget(
        path: '/account',
        icon: CupertinoIcons.person,
        title: 'Account',
        child: ScreenAccount(),
        backgroundColor: Colors.green,
        routeInDrawer: true,
      ),
    ];
  }

  List<LBRouteWidget> get routesForDrawer {
    List<LBRouteWidget> arr = [];
    for (var i = 0; i < dashRoutes.length; i++) {
      LBRouteWidget ii = dashRoutes[i];
      if (ii.routeInDrawer == true) {
        arr.add(ii);
      }
    }
    return arr;
  }
}
