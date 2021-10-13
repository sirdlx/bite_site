import 'package:flutter/material.dart';

class ScreenOrders extends StatelessWidget {
  final String? id;
  const ScreenOrders({
    Key? key,
    this.id,
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
        title: Text('Orders'),
      ),
      body: child,
    );
  }

  Widget _buildWithID(BuildContext context) {
    return Container(
      child: Center(
        child: Text('Orders $id'),
      ),
    );
  }
}
