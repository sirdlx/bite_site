import 'package:flutter/material.dart';
import 'package:losbetos/fake_data.dart';

class PageCartView extends StatelessWidget {
  const PageCartView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(),
      body: Container(
        child: FutureBuilder(
            future: Future.delayed(Duration(milliseconds: 3000)),
            builder: (context, snapshot) {
              if (snapshot.hasData || demoCartItems.length > 0) {
                return ListView(
                  children: [
                    ListTile(
                      title: Text('Item Title'),
                    ),
                  ],
                );
              }

              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.shopping_cart_outlined,
                      size: 200,
                    ),
                    Text(
                      'No items in your cart.',
                      style: Theme.of(context).textTheme.headline4,
                    )
                  ],
                ),
              );
            }),
      ),
    );
  }
}
