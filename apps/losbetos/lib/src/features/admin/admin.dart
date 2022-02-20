import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flavor_auth/flavor_auth.dart';
import 'package:flavor_redis/flavor_redis.dart';
import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:losbetosapp/main.dart';
import 'package:losbetosapp/src/components/error.dart';
import 'package:losbetosapp/src/features/orders/order_model.dart';
import 'package:regex_router/regex_router.dart';

var app = appController;

class LBAdmin extends StatelessWidget {
  LBAdmin({Key? key}) : super(key: key);

  final admincontroller = LBAppAdminController();

  @override
  Widget build(BuildContext context) {
    String? admin = app.appBox?.get('d');
    log(admin.toString());
    return Navigator(
      onGenerateRoute: admincontroller.router.generateRoute,
    );
  }
}

class LBAppAdminController with ChangeNotifier {
  final GlobalKey<NavigatorState> globalNavKey = GlobalKey<NavigatorState>();
  final GlobalKey<ScaffoldState> homeScaffoldKey = GlobalKey<ScaffoldState>();

  final String baseUrl = '/apps/bitesite.losbetos';
  String get ordersUrl => '$baseUrl/orders';
  Stream<QuerySnapshot<Map<String, dynamic>>> get ordersStream =>
      FirebaseFirestore.instance
          .collection(ordersUrl)
          .snapshots(includeMetadataChanges: true);

  RegexRouter get router => RegexRouter.create({
        "/": (context, _) => LBAdminScreenDashboard(),
        "/admin/order": (context, args) => LBAdminScreenOrder(admin: this),
        "/admin/order/:id": (context, args) =>
            LBAdminScreenOderByID(id: args["id"]!, admin: this),
      });

  void updateAndSave() {}
}

class LBAdminScreenOderByID extends StatelessWidget {
  final String? id;

  const LBAdminScreenOderByID(
      {Key? key, this.id, required LBAppAdminController admin})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    if (id == null) {
      return ErrorView(
        // errorCode: '404',
        message: 'Missing {id} field',
        // title: 'Param {id} is null',
        // type: 'fire',
      );
    }

    return StreamBuilder(
      builder: (context, snapshot) {
        Widget _widget = Container();

        switch (snapshot.connectionState) {
          case ConnectionState.none:
            _widget = const Center(
              child: Text('ConnectionState.none'),
            );
            break;
          case ConnectionState.waiting:
            _widget = const Center(
              child: Text('ConnectionState.waiting'),
            );
            break;
          case ConnectionState.active:
            _widget = const Center(
              child: Text('ConnectionState.active'),
            );
            break;
          case ConnectionState.done:
            _widget = const Center(
              child: Text('ConnectionState.done'),
            );
            break;
        }

        return _widget;
      },
    );
  }
}

class LBAdminScreenOrder extends StatelessWidget {
  final LBAppAdminController admin;
  const LBAdminScreenOrder({
    Key? key,
    required this.admin,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('All Orders'),
        ),
        body: buildStreamBody());
  }

  Widget buildStreamBody() {
    return StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
      stream: admin.ordersStream,
      builder: (context, snapshot) {
        Widget _widget = Container();

        switch (snapshot.connectionState) {
          case ConnectionState.none:
            log(snapshot.connectionState.toString());
            _widget = Center(
              child: Text('ConnectionState.none'),
            );
            break;
          case ConnectionState.waiting:
            log(snapshot.connectionState.toString());
            _widget = Center(
              child: Text('ConnectionState.waiting'),
            );
            break;
          case ConnectionState.active:
            log(snapshot.hasData.toString());
            var _itemsJson = snapshot.data?.docs ?? [];

            if (_itemsJson.isEmpty) {
              _widget = Center(
                child: Text('waiting for new orders'),
              );
            } else {
              List<OrderModel> orders =
                  _itemsJson.map((e) => OrderModel.fromMap(e.data())).toList();

              _widget = ListView(
                children: _itemsJson.map(
                  (e) {
                    print(e.data());
                    return ListTile(
                      onTap: () {},
                      title: Text('Michael B Jordan'),
                      subtitle: Text('5 items'),
                      trailing: ElevatedButton.icon(
                          onPressed: () {},
                          icon: Icon(CupertinoIcons.check_mark_circled),
                          label: Text('Complete')),
                    );
                  },
                ).toList(),
              );
            }

            break;
          case ConnectionState.done:
            log(snapshot.connectionState.toString());
            _widget = Center(
              child: Text('ConnectionState.done'),
            );
            break;
        }

        return _widget;
      },
    );
  }
}

class LBAdminScreenDashboard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        backgroundColor: Theme.of(context).cardColor,
        title: Text('Dashboard'),
      ),
      body: Row(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: GridView.count(
                shrinkWrap: true,
                crossAxisCount: 3,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                padding: const EdgeInsets.all(16),
                children: [
                  ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).restorablePushNamed('/admin/order');
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text('Orders'),
                          Text(
                            '26',
                            style: Theme.of(context).textTheme.caption,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
