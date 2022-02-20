import 'dart:developer';
import 'dart:ui';

import 'package:flavor_auth/flavor_auth.dart';
import 'package:flavor_ui/flavor_ui.dart' as fui;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_remix/flutter_remix.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:losbetosapp/main.dart';
import 'package:losbetosapp/src/components/route.dart';
import 'package:losbetosapp/src/features/app/home_appbar.dart';
import 'package:losbetosapp/src/features/auth/auth_controller.dart';
import 'package:losbetosapp/src/themes/light.dart';
import 'package:losbetosapp/src/utilities/pageviewer.dart';

class LBScreenLayout extends StatefulWidget {
  final List<LBRouteWidget> routes;
  const LBScreenLayout({
    Key? key,
    required this.routes,
  }) : super(key: key);
  @override
  _LBScreenLayoutState createState() => _LBScreenLayoutState();
}

class _LBScreenLayoutState extends State<LBScreenLayout> {
  static const double _playerMinHeight = 60.0;

  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, watch, child) {
        return fui.ResponsiveView(
          breakpoints: {
            fui.DisplayType.s: buildMobileView(context),
            fui.DisplayType.l: _buildBodyLarge(context),
          },
        );
      },
    );
  }

  Scaffold buildMobileView(BuildContext context) {
    return Scaffold(
      key: appController.homeScaffoldKey,
      appBar: homeAppBar(context),
      body: SafeArea(child: buildBody(context)),
      bottomNavigationBar: _bottomNavBar(context),
      drawer: Drawer(
        child: buildDrawer(),
      ),
    );
  }

  Widget _buildBodyLarge(BuildContext context) {
    return Scaffold(
      key: appController.homeScaffoldKey,
      primary: true,
      body: Row(
        children: [
          SizedBox(
            width: 240,
            child: Drawer(
              elevation: 1,
              child: buildDrawer(),
            ),
          ),
          Expanded(
            flex: 1,
            child: buildBody(context),
          ),
        ],
      ),
    );
  }

  Widget buildDrawer() {
    return LBDrawer(
      onTap: (index) {
        log(index.toLowerCase());

        setState(() {
          for (var i = 0; i < appController.routesForDrawer.length; i++) {
            if (appController.routesForDrawer[i].path == index) {
              _selectedIndex = i;

              if (appController.homeScaffoldKey.currentState!.isDrawerOpen) {
                appController.globalNavKey.currentState!.pop();
              }
              return;
            }
          }
        });
      },
    );
  }

  Widget _bottomNavBar(context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 28),
      height: 56,
      width: double.infinity,
      // double.infinity means it cove the available width
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
        // boxShadow: [
        //   BoxShadow(
        //     offset: Offset(0, 2),
        //     blurRadius: 2,
        //     color: Colors.blueAccent,
        //   ),
        // ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: appController.routesForDrawer
            .asMap()
            .map(
              (i, screen) => MapEntry(
                i,
                IconButton(
                  color: _selectedIndex == i
                      ? lbThemeLight.primaryColor
                      : Theme.of(context).disabledColor,
                  icon: Icon(screen.icon),
                  // activeIcon: Icon(Icons.home),
                  onPressed: () {
                    setState(() {
                      for (var i = 0;
                          i < appController.routesForDrawer.length;
                          i++) {
                        if (appController.routesForDrawer[i].path ==
                            screen.path) {
                          _selectedIndex = i;

                          if (appController
                              .homeScaffoldKey.currentState!.isDrawerOpen) {
                            appController.globalNavKey.currentState!.pop();
                          }
                          return;
                        }
                      }
                    });
                  },
                ),
              ),
            )
            .values
            .toList(),
      ),
    );
  }

  Widget buildBody(BuildContext context) {
    return Stack(
        children: appController.routesForDrawer
            .asMap()
            .map((i, screen) => MapEntry(
                  i,
                  Offstage(
                    offstage: _selectedIndex != i,
                    child: PageViewItem(child: screen.child),
                  ),
                ))
            .values
            .toList());
  }
}

class LBDrawer extends StatelessWidget {
  final void Function(String route)? onTap;

  const LBDrawer({
    Key? key,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) {
        var auth = ref.watch(authControllerProvider);

        return Material(
          elevation: .3,
          child: Column(
            children: [
              Expanded(
                child: ListView(
                  shrinkWrap: true,
                  children: [
                    AspectRatio(
                      aspectRatio: 1,
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Image.asset('assets/images/logo.png'),
                      ),
                    ),
                    // appController

                    ListTile(
                      title: const Text('Menu'),
                      leading: const Icon(FlutterRemix.file_list_2_line),
                      onTap: () => onTap != null
                          ? onTap!('/')
                          : Navigator.of(context)
                              .restorablePopAndPushNamed('/'),
                    ),

                    ListTile(
                      title: const Text('Cart'),
                      leading: const Icon(FlutterRemix.shopping_bag_2_line),
                      onTap: () => onTap != null
                          ? onTap!('/cart')
                          : Navigator.of(context).restorablePushNamed('/cart'),
                    ),

                    if (auth.user != null)
                      ListTile(
                        title: const Text('Orders'),
                        leading: const Icon(FlutterRemix.history_line),
                        onTap: () => onTap != null
                            ? onTap!('/orders')
                            : Navigator.of(context)
                                .restorablePushNamed('/orders'),
                      ),
                    ListTile(
                      title: const Text('Account'),
                      leading: const Icon(CupertinoIcons.person),
                      onTap: () => onTap != null
                          ? onTap!('/account')
                          : Navigator.of(context)
                              .restorablePushNamed('/account'),
                    ),
                  ],
                ),
              ),
              LBBottomMenu(user: auth.user)
            ],
          ),
        );
      },
    );
  }
}

class LBBottomMenu extends StatelessWidget {
  final FlavorUser? user;
  const LBBottomMenu({
    Key? key,
    this.user,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          TextButton(
            onPressed: () {
              showAboutDialog(
                context: context,
                useRootNavigator: true,
              );
            },
            child: const Text('About'),
          ),
          TextButton(
            onPressed: () async {
              user != null
                  ? await appController.isAdmin(user!)
                      ? Navigator.of(context).restorablePushNamed('/admin/')
                      : showCupertinoDialog(
                          context: context,
                          builder: (context) {
                            return Scaffold(
                              body: Column(
                                children: const [Text('built with flavor')],
                              ),
                            );
                          },
                        )
                  : null;
            },
            child: const Text('DLX Studios 2021'),
          )
        ],
      ),
    );
  }
}
