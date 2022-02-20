import 'package:firebase_auth/firebase_auth.dart';
import 'package:flavor_auth/flavor_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:losbetosapp/src/features/auth/auth_controller.dart';

class ScreenOrders extends StatelessWidget {
  final String? id;
  const ScreenOrders({
    Key? key,
    this.id,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) {
        var auth = ref.watch(authControllerProvider);
        if (auth.user != null) {
          return _ScreenOrders(id: id, user: auth.user!);
        } else {
          return const NotLoggedInMessage();
        }
      },
    );
  }
}

class NotLoggedInMessage extends StatelessWidget {
  const NotLoggedInMessage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Orders'),
      ),
      body: const Center(
        child: Text('You have to login to view this page'),
      ),
    );
  }
}

class _ScreenOrders extends StatelessWidget {
  final String? id;
  final FlavorUser user;
  const _ScreenOrders({
    Key? key,
    this.id,
    required this.user,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget child;
    if (id != null) {
      child = _buildWithID(context);
    }

    child = ListView(
      children: List.generate(
        10,
        (index) => ListTile(
          title: Text('index $index'),
        ),
      ),
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text('Orders'),
      ),
      body: child,
    );
  }

  Widget _buildWithID(BuildContext context) {
    return Center(
      child: Text('Orders $id'),
    );
  }
}
