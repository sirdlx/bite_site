import 'package:flavor/components/route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flavor_auth/flavor_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:losbetosapp/models/models.dart';
import 'package:losbetosapp/src/screens/account.dart';
import 'package:losbetosapp/src/screens/category.dart';
import 'package:losbetosapp/src/screens/layout.dart';
import 'package:losbetosapp/src/screens/menu.dart';
import 'package:losbetosapp/src/screens/menu_item.dart';
import 'package:losbetosapp/src/screens/orders.dart';
import 'package:losbetosapp/src/screens/settings.dart';
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
  late ThemeMode _themeMode;

  // Allow Widgets to read the user's preferred ThemeMode.
  ThemeMode get themeMode => _themeMode == null ? ThemeMode.system : _themeMode;

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
    notifyListeners();

    // Persist the changes to a local database or the internet using the
    // SettingService.
    await _settingsService.updateThemeMode(newThemeMode);
  }

  late Box? appBox;
  bool alreadyInit = false;

  FlavorUser? _user;
  FlavorUser? get user => _user != null ? _user! : null;

  set user(FlavorUser? newUser) {
    _user = newUser;
    // if (_user != null) {
    //   FirebaseFirestore.instance
    //       .doc('users/${_user!.email}')
    //       .update(_user!.toJson() as Map<String, dynamic>);
    // }
    updateAndSave();
  }

  BSCart cart = BSCart();

  List<FlavorRouteWidget> get routesDrawer {
    List<FlavorRouteWidget> arr = [];
    for (var i = 0; i < dashRoutes.length; i++) {
      FlavorRouteWidget ii = dashRoutes[i];
      if (ii.routeInDrawer == true) {
        arr.add(ii);
      }
    }
    return arr;
  }

  get router => RegexRouter.create({
        // "/": (context, _) => AppLayoutWidget(),
        "/": (context, _) => ScreenLayout(routes: routesDrawer),
        "/menu/category/:catId/item/:itemId/": (context, args) =>
            ScreenMenuItem(id: args["itemId"]!),
        "/menu/category/:catId": (context, args) =>
            ScreenCategory(id: args["catId"]!),
        "/orders": (context, args) => ScreenOrders(),
        "/orders/:orderID": (context, args) =>
            ScreenOrders(id: args["orderID"]!),
      });

  updateQuanity(int index, int quanity) {
    cart.items[index].quanity = quanity;
  }

  void updateAndSave() {
    print('updateAndSave()::_themeMode::$_themeMode');
    appBox!.put('_user', user != null ? user!.toJson() : null);
    appBox!.put('_cart', {'cart': cart.toList()});
    appBox!.put('_themeMode', _themeMode);
    notifyListeners();
  }

  void loadAppSettingsFromDisk() {
    // appBox!.delete('_cart');

    //
    _themeMode = appBox!.get('_themeMode') ?? _themeMode;
    print('loadAppSettingsFromDisk()::_themeMode::$_themeMode');
    //
    var __user = appBox!.get('_user');
    print('loadAppSettingsFromDisk()::__user::$__user');
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

  List<FlavorRouteWidget> get dashRoutes {
    if (user != null) {}
    return [
      FlavorRouteWidget(
        path: '/',
        icon: CupertinoIcons.home,
        title: 'Menu',
        child: const ScreenMenu(),
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

// class FlavorRouteWidget {
//   final String? path;
//   final IconData? icon;
//   final String? title;
//   final Widget? child;
//   final Color? backgroundColor;
//   final bool? routeInDrawer;

//   FlavorRouteWidget(
//       {this.path,
//       this.icon,
//       this.title,
//       this.child,
//       this.backgroundColor,
//       this.routeInDrawer});
// }
