import 'dart:ui';

import 'package:flavor/layout/FlavorResponsiveView.dart';
import 'package:flavor/layout/adaptive.dart';
import 'package:flutter/material.dart';
import 'package:flutter_remix/flutter_remix.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:losbetos/components/pageviewer.dart';
import 'package:losbetos/screens/cart.dart';
import 'package:losbetos/state/state.dart';
import 'package:losbetos/themes/light.dart';
import 'package:losbetos/utilities/utilities.dart';
import 'package:miniplayer/miniplayer.dart';
import 'package:provider/provider.dart' as Provider;

final miniPlayerControllerProvider =
    StateProvider.autoDispose<MiniplayerController>(
  (ref) => MiniplayerController(),
);

class ScreenLayout extends StatefulWidget {
  final List<FlavorRouteWidget> routes;
  const ScreenLayout({
    Key? key,
    required this.routes,
  }) : super(key: key);
  @override
  _ScreenLayoutState createState() => _ScreenLayoutState();
}

class _ScreenLayoutState extends State<ScreenLayout> {
  static const double _playerMinHeight = 60.0;

  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, watch, child) {
        var app = context.watch<AppState>();
        return FlavorResponsiveView(
          breakpoints: {
            DisplayType.s: Scaffold(
              appBar: AppBar(
                // leading: Padding(
                //   padding: const EdgeInsets.all(10.0),
                //   child: Image.asset(
                //     'assets/images/logo.png',
                //     fit: BoxFit.contain,
                //   ),
                // ),
                // leadingWidth: 116,

                leading: Icon(
                  FlutterRemix.cactus_fill,
                  // color: LBThemeLight.primaryColor,
                ),
              ),
              body: SafeArea(child: buildBody(context, app)),
              bottomNavigationBar: _buildBottomNav(app),
              primary: true,
            ),
            DisplayType.l: Scaffold(
              // key: homeScaffoldKey,
              primary: true,
              body: _buildBodyLarge(context, app),
            ),
          },
        );
      },
    );
  }

  Row _buildBodyLarge(BuildContext context, AppState app) {
    return Row(
      children: [
        Container(
          width: 160,
          padding: const EdgeInsets.only(right: 1),
          child: NavigationRail(
            elevation: 1,
            onDestinationSelected: (i) => setState(() => _selectedIndex = i),
            extended: true,
            leading: SafeArea(
              child: Center(
                child: Padding(
                  padding:
                      const EdgeInsets.only(left: 12.0, right: 12, bottom: 16),
                  child: Image.asset('assets/images/logo.png'),
                ),
              ),
            ),
            destinations: app.routesForDrawer
                .map(
                  (e) => NavigationRailDestination(
                    padding: EdgeInsets.all(0),
                    label: Text(e.title.toString()),
                    icon: Icon(e.icon),
                  ),
                )
                .toList(),
            selectedIndex: _selectedIndex,
          ),
        ),
        Flexible(
          flex: 11,
          child: Scaffold(
              // appBar: homeAppBar(context),
              // body: BiteSiteHomeBody(),
              body: buildBody(context, app)),
        ),
      ],
    );
  }

  BottomNavigationBar _buildBottomNav(AppState app) {
    return BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _selectedIndex,
        onTap: (i) => setState(() => _selectedIndex = i),
        selectedFontSize: 10.0,
        unselectedFontSize: 10.0,
        items: app.routesForDrawer
            .asMap()
            .map(
              (i, screen) => MapEntry(
                i,
                BottomNavigationBarItem(
                  icon: Icon(screen.icon),
                  // activeIcon: Icon(Icons.home),
                  label: screen.title,
                ),
              ),
            )
            .values
            .toList());
  }

  buildBody(BuildContext context, AppState app) {
    return Scaffold(
      body: Consumer(
        builder: (context, watch, _) {
          final miniPlayerController =
              watch(miniPlayerControllerProvider).state;
          return Stack(
            children: app.routesForDrawer
                .asMap()
                .map((i, screen) => MapEntry(
                      i,
                      Offstage(
                        offstage: _selectedIndex != i,
                        child: PageViewItem(child: screen.child!),
                      ),
                    ))
                .values
                .toList()
              ..add(
                Offstage(
                  offstage: false,
                  child: Miniplayer(
                    controller: miniPlayerController,
                    minHeight: _playerMinHeight,
                    maxHeight: MediaQuery.of(context).size.height,
                    builder: (height, percentage) {
                      if (height <= _playerMinHeight + 50.0)
                        return Container(
                          padding: EdgeInsets.all(8),
                          color: Theme.of(context).scaffoldBackgroundColor,
                          child: Row(
                            children: [
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Flexible(
                                        child: RichText(
                                            text: TextSpan(
                                                text: 'Total : ',
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodyText2!
                                                    .copyWith(
                                                        fontWeight:
                                                            FontWeight.w300),
                                                children: [
                                              TextSpan(
                                                  text:
                                                      '${toPricingText(app.cart.itemsTotal)}'),
                                            ])),
                                      ),
                                      Flexible(
                                        child: Text(
                                          'Location : ',
                                          overflow: TextOverflow.ellipsis,
                                          style: Theme.of(context)
                                              .textTheme
                                              .caption!
                                              .copyWith(
                                                  fontWeight: FontWeight.w500),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              IconButton(
                                icon: const Icon(
                                  Icons.shopping_cart_outlined,
                                ),
                                onPressed: () {
                                  miniPlayerControllerProvider.select((value) =>
                                      value.state.animateToHeight(
                                          state: PanelState.MAX));
                                },
                              ),
                              SizedBox(
                                width: 16,
                              )
                            ],
                          ),
                        );
                      return ScreenCartView(app: app);
                    },
                  ),
                ),
              ),
          );
        },
      ),
    );
  }
}
