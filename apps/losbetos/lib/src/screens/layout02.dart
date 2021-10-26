import 'dart:ui';

import 'package:flavor_client/components/route.dart';
import 'package:flavor_client/layout/FlavorResponsiveView.dart';
import 'package:flavor_client/layout/adaptive.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:losbetosapp/main.dart';
import 'package:losbetosapp/src/components/home_appbar.dart';
import 'package:losbetosapp/src/components/pageviewer.dart';
import 'package:losbetosapp/src/themes/light.dart';

class LBScreenLayout extends StatefulWidget {
  final List<FlavorRouteWidget> routes;
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
        return FlavorResponsiveView(
          breakpoints: {
            DisplayType.s: buildMobileView(context),
            DisplayType.l: _buildBodyLarge(context),
          },
        );
      },
    );
  }

  Scaffold buildMobileView(BuildContext context) {
    return Scaffold(
      key: settingsController.homeScaffoldKey,
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
      key: settingsController.homeScaffoldKey,
      primary: true,
      body: Row(
        children: [
          SizedBox(
            width: 160,
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
        setState(() {
          for (var i = 0; i < settingsController.routesForDrawer.length; i++) {
            if (settingsController.routesForDrawer[i].path == index.path) {
              _selectedIndex = i;

              if (settingsController
                  .homeScaffoldKey.currentState!.isDrawerOpen) {
                settingsController.globalNavKey.currentState!.pop();
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
        children: settingsController.routesForDrawer
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
                          i < settingsController.routesForDrawer.length;
                          i++) {
                        if (settingsController.routesForDrawer[i].path ==
                            screen.path) {
                          _selectedIndex = i;

                          if (settingsController
                              .homeScaffoldKey.currentState!.isDrawerOpen) {
                            settingsController.globalNavKey.currentState!.pop();
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
        children: settingsController.routesForDrawer
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
  final void Function(FlavorRouteWidget index)? onTap;

  const LBDrawer({
    Key? key,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: .3,
      child: ListView(
        children: [
          AspectRatio(
            aspectRatio: 1,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Image.asset('assets/images/logo.png'),
            ),
          ),
          ...settingsController.routesForDrawer
              .map(
                (e) => ListTile(
                  title: Text(e.title!),
                  leading: Icon(e.icon),
                  onTap: onTap != null ? () => onTap!(e) : null,
                ),
              )
              .toList(),
        ],
      ),
    );
  }
}
