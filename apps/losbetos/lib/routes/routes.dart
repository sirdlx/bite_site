import 'package:flavor/components/route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:losbetos/pages/cart.dart';
import 'package:losbetos/pages/home.dart';
import 'package:losbetos/pages/menu.dart';
import 'package:losbetos/pages/settings.dart';

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
  //   path: '/profile',
  //   icon: CupertinoIcons.person,
  //   title: 'Profile',
  //   child: BiteSiteHomeBody(),
  //   backgroundColor: Colors.green,
  //   routeInDrawer: true,
  // ),

  FlavorRouteWidget(
    path: '/orders',
    icon: CupertinoIcons.bag_fill,
    title: 'Orders',
    child: BiteSiteHomeBody(),
    backgroundColor: Colors.green,
    routeInDrawer: true,
  ),

  FlavorRouteWidget(
    path: '/settings',
    icon: CupertinoIcons.settings,
    title: 'Settings',
    child: PageSettings(),
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
