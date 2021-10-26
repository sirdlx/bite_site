import 'package:flavor_client/components/route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_remix/flutter_remix.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:losbetosapp/src/models/models.dart';
import 'package:losbetosapp/src/screens/account.dart';
import 'package:losbetosapp/src/screens/cart.dart';
import 'package:losbetosapp/src/screens/category.dart';
import 'package:losbetosapp/src/screens/layout02.dart';
import 'package:losbetosapp/src/screens/menu02.dart';
import 'package:losbetosapp/src/screens/menu_item02.dart';
import 'package:losbetosapp/src/screens/orders.dart';
import 'package:regex_router/regex_router.dart';

import 'settings_service.dart';

/// A class that many Widgets can interact with to read user settings, update
/// user settings, or listen to user settings changes.
///
/// Controllers glue Data Services to Flutter Widgets. The SettingsController
/// uses the SettingsService to store and retrieve user settings.
class SettingsController with ChangeNotifier {
  final GlobalKey<NavigatorState> globalNavKey = GlobalKey<NavigatorState>();
  final GlobalKey<ScaffoldState> homeScaffoldKey = GlobalKey<ScaffoldState>();

  SettingsController(this._settingsService);

  // Make SettingsService a private variable so it is not used directly.
  final SettingsService _settingsService;

  // Make ThemeMode a private variable so it is not updated directly without
  // also persisting the changes with the SettingsService.
  late ThemeMode _themeMode = ThemeMode.system;

  // Allow Widgets to read the user's preferred ThemeMode.
  ThemeMode get themeMode => _themeMode;

  // Provider<LBAuthNotifier> auth = authControllerProvider;

  /// Load the user's settings from the SettingsService. It may load from a
  /// local database or the internet. The controller only knows it can load the
  /// settings from the service.
  Future<void> loadSettings() async {
    await Hive.initFlutter();
    appBox = await Hive.openBox('losbetos_app');
    loadAppSettingsFromDisk();
    // _themeMode = await _settingsService.themeMode();
    // Important! Inform listeners a change has occurred.

    notifyListeners();
  }

  /// Update and persist the ThemeMode based on the user's selection.
  Future<void> updateThemeMode(ThemeMode? newThemeMode) async {
    if (newThemeMode == null) return;

    // Dot not perform any work if new and old ThemeMode are identical
    if (newThemeMode == _themeMode) return;

    // Otherwise, store the new theme mode in memory
    _themeMode = newThemeMode;

    // Important! Inform listeners a change has occurred.

    await appBox!.put('_themeMode', _themeMode.toString());
    notifyListeners();
    // Persist the changes to a local database or the internet using the
    // SettingService.
    // await _settingsService.updateThemeMode(newThemeMode);
  }

  late Box? appBox;

  // FlavorUser? _user;
  // FlavorUser? get user => _user != null ? _user! : null;

  BSCart cart = BSCart();

  get router => RegexRouter.create({
        // "/": (context, _) => AppLayoutWidget(),
        // "/": (context, _) => ScreenLayout(routes: routesForDrawer),
        "/": (context, _) => LBScreenLayout(routes: routesForDrawer),

        // "/menu/category/:catId/item/:itemId/": (context, args) =>
        //     ScreenMenuItem(id: args["itemId"]!),

        "/menu/category/:catId/item/:itemId/": (context, args) =>
            LBScreenMenuItem(id: args["itemId"]!),
        "/menu/category/:catId": (context, args) =>
            ScreenCategory(id: args["catId"]!),
        "/orders": (context, args) => const ScreenOrders(),
        "/orders/:orderID": (context, args) =>
            ScreenOrders(id: args["orderID"]!),
      });

  updateQuanity(int index, int quanity) {
    cart.items[index].quanity = quanity;
  }

  void updateAndSave() {
    // print('updateAndSave()::_themeMode::$_themeMode');
    // appBox!.put('_user', user != null ? user!.toJson() : null);
    appBox!.put('_cart', {'cart': cart.toList()});
    notifyListeners();
  }

  void loadAppSettingsFromDisk() {
    //
    var __themeMode = appBox!.get('_themeMode');
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
    var __user = appBox!.get('_user');
    // print('loadAppSettingsFromDisk()::__user::$__user');
    // _user = __user != null
    //     ? FlavorUser(
    //         displayName: __user['displayName'],
    //         email: __user['email'],
    //         emailVerified: __user['emailVerified'],
    //         localId: __user['localId'],
    //       )
    //     : null;

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

  List<FlavorRouteWidget> get dashRoutes {
    // if (user != null) {}
    return [
      // FlavorRouteWidget(
      //   path: '/',
      //   icon: CupertinoIcons.home,
      //   title: 'Menu',
      //   child: const ScreenMenu(),
      //   backgroundColor: Colors.green,
      //   routeInDrawer: true,
      // ),
      FlavorRouteWidget(
        path: '/',
        icon: CupertinoIcons.home,
        title: 'Menu',
        child: const LBScreenMenu(),
        backgroundColor: Colors.green,
        routeInDrawer: true,
      ),

      FlavorRouteWidget(
        path: '/cart',
        icon: FlutterRemix.shopping_bag_2_line,
        title: 'Cart',
        child: const ScreenCartView(),
        backgroundColor: Colors.green,
        routeInDrawer: true,
      ),

      FlavorRouteWidget(
        path: '/ordrers',
        icon: FlutterRemix.history_line,
        title: 'Orders',
        child: const ScreenOrders(),
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
      // FlavorRouteWidget(
      //   path: '/settings',
      //   icon: CupertinoIcons.settings,
      //   title: 'Settings',
      //   child: ScreenSettings(),
      //   backgroundColor: Colors.green,
      //   routeInDrawer: true,
      // ),
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
