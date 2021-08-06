import 'package:flavor/layout/FlavorResponsiveView.dart';
import 'package:flavor/layout/adaptive.dart';
import 'package:flutter/material.dart';
import 'package:losbetos/components/homeAppbar.dart';
import 'package:losbetos/components/pageviewer.dart';
import 'package:losbetos/pages/home.dart';
import 'package:losbetos/routes/routes.dart';
import 'package:losbetos/state.dart';

class AppLayoutWidget extends StatefulWidget {
  const AppLayoutWidget({
    Key? key,
  }) : super(key: key);

  @override
  _AppLayoutWidgetState createState() => _AppLayoutWidgetState();
}

class _AppLayoutWidgetState extends State<AppLayoutWidget>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    _tabController = new TabController(
      length: routesForDrawer.length,
      vsync: this,
      initialIndex: _selectedIndex,
    );
  }

  @override
  Widget build(BuildContext context) {
    return FlavorResponsiveView(
      breakpoints: {
        DisplayType.s: buildMobileView(context),
        DisplayType.l: Scaffold(
          key: homeScaffoldKey,
          body: Row(
            children: [
              Flexible(
                flex: 3,
                child: Padding(
                  padding: const EdgeInsets.only(right: 0.0),
                  child: NavigationRail(
                    elevation: 1,
                    onDestinationSelected: (value) {
                      _tabController.animateTo(value);
                      setState(() {
                        _selectedIndex = value;
                      });
                    },
                    extended: true,
                    leading: Center(child: Text('data')),
                    destinations: routesForDrawer
                        .map(
                          (e) => NavigationRailDestination(
                            label: Text(e.title.toString()),
                            icon: Icon(e.icon),
                            // selectedIcon: Icon(
                            //   Icons.home_rounded,
                            //   // color: Colors.amber,
                            // ),
                          ),
                        )
                        .toList(),
                    selectedIndex: _selectedIndex,
                  ),
                ),
              ),
              Flexible(
                flex: 11,
                child: Scaffold(
                    // appBar: homeAppBar(context),
                    // body: BiteSiteHomeBody(),
                    body: buildMobileView(context)),
              ),
            ],
          ),
        ),
        DisplayType.xl: Scaffold(
          appBar: homeAppBar(context),
          body: BiteSiteHomeBody(),
        ),
      },
    );
  }

  Widget buildMobileView(BuildContext context) {
    return FlavorResponsiveView(
      global: true,
      breakpoints: {
        DisplayType.s: Scaffold(
          key: homeScaffoldKey,
          appBar: buildAppBar(context),
          drawer: buildDrawer(),
          body: buildBody(),
          bottomNavigationBar: buildBottomBar(),
        ),
        DisplayType.l: Scaffold(
          key: homeScaffoldKey,
          // appBar: buildAppBar(context),
          drawer: buildDrawer(),
          body: buildBody(),
        ),
      },
    );
  }

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      // elevation: 3,
      automaticallyImplyLeading: false,
      title: Container(
        height: 58,
        padding: EdgeInsets.all(12),
        // color: Colors.amber,
        child: Row(
          children: [
            Image.asset('assets/images/logo.png'),
            SizedBox(
              width: 16,
            ),
          ],
        ),
        // height: 18,
      ),
      actions: [
        IconButton(
          onPressed: () {
            GlobalNav.currentState!.pushNamed('/login');
          },
          icon: Icon(Icons.person),
        ),
        IconButton(
          onPressed: () {
            GlobalNav.currentState!.pushNamed('/login');
          },
          icon: CircleAvatar(
            backgroundColor: Theme.of(context).primaryColor,
          ),
        ),
      ],
    );
  }

  Material buildBottomBar() {
    return Material(
      elevation: 4,
      child: TabBar(
        controller: _tabController,
        onTap: (value) {
          setState(() {
            _selectedIndex = value;
          });
        },
        tabs: routesForDrawer
            .map(
              (e) => Tab(
                icon: Icon(e.icon),
              ),
            )
            .toList(),
      ),
    );
  }

  TabBarView buildBody() {
    return TabBarView(
      controller: _tabController,
      children:
          routesForDrawer.map((e) => PageViewItem(child: e.child)).toList(),
    );
  }

  SizedBox buildDrawer() {
    return SizedBox(
      width: 260,
      child: Material(
        child: ListView(
          children: [
            ListTile(
              title: Text('Search'),
            ),
            ListTile(
              title: Text('Orders'),
            ),
            ListTile(
              title: Text('Payment'),
            ),
            ListTile(
              title: Text('Sign Out'),
            ),
            ListTile(
              title: Text('Help'),
            ),
          ],
        ),
      ),
    );
  }
}
