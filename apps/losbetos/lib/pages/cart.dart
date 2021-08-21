import 'package:flutter/material.dart';
import 'package:losbetos/models/models.dart';
import 'package:losbetos/state.dart';
import 'package:losbetos/utilities.dart';
import 'package:provider/provider.dart';

class PageCartView extends StatelessWidget {
  const PageCartView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var app = context.watch<AppState>();
    print('app.cart.items.length::${app.cart.items.length}');
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text('Cart'),
        leading: Text('data'),
      ),
      bottomNavigationBar: app.cart.items.length > 0
          ? Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  RichText(
                      text: TextSpan(
                          text: 'Total : ',
                          style: Theme.of(context).textTheme.headline6,
                          children: [
                        TextSpan(text: '${toPricingText(app.cart.itemsTotal)}'),
                      ])),
                  ElevatedButton(
                    onPressed: () {},
                    child: Text(
                      'Checkout',
                      // style: Theme.of(context).textTheme.headline5,
                    ),
                  ),
                ],
              ),
            )
          : null,
      body: Container(
        child: FutureBuilder(
            future: Future.delayed(Duration(milliseconds: 3000)),
            builder: (context, snapshot) {
              if (snapshot.hasData || app.cart.items.length > 0) {
                return Card(
                  margin: EdgeInsets.all(16),
                  child: ListView.separated(
                    shrinkWrap: true,
                    separatorBuilder: (context, index) => Divider(
                      thickness: 1,
                    ),
                    itemBuilder: (context, index) => CartMenuItemTile(
                      cartMenuItem: app.cart.items[index],
                    ),
                    itemCount: app.cart.items.length,
                  ),
                );
              }

              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.shopping_cart_outlined,
                      size: 120,
                    ),
                    Text(
                      'No items in your cart.',
                      style: Theme.of(context).textTheme.headline5,
                    )
                  ],
                ),
              );
            }),
      ),
    );
  }
}

class CartMenuItemTile extends StatelessWidget {
  final BSCartMenuItem cartMenuItem;
  const CartMenuItemTile({
    Key? key,
    required this.cartMenuItem,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // print('menuItem.imageUrl::${menuItem.imageUrl}');
    // ignore: unused_local_variable
    Widget leading = Container();

    return ListTile(
      // isThreeLine: true,
      leading: cartMenuItem.menuitem.imageUrl != null
          ? AspectRatio(
              aspectRatio: 1,
              child:
                  // HeroImage(
                  //   image:
                  Image.asset(
                cartMenuItem.menuitem.imageUrl!,
                fit: BoxFit.cover,
              )
              //   .image,
              // ),
              )
          // : AspectRatio(
          //     aspectRatio: 1,
          //     child: Container(),
          //   ),

          : null,
      title: Text(cartMenuItem.menuitem.title!),
      subtitle: Column(
        children: [
          cartMenuItem.menuitem.description != null
              ? Text(
                  cartMenuItem.menuitem.description!,
                  // style: Theme.of(context).textTheme.caption!.copyWith(
                  //       color: Colors.white70,
                  //     ),
                )
              : Container(),
        ],
      ),
      // onTap: () {
      //   // GlobalNav.currentState!.pushNamed(
      //   //     '/menu/category/${menuItem.categoryId}/item/${menuItem.id}');
      // },0
      trailing: SizedBox(
        width: 96,
        child: Column(
          children: [
            Text(
                '${cartMenuItem.quanity} x ${toPricingText(cartMenuItem.menuitem.basePrice)}'),
            Flexible(
              child: Row(
                children: [
                  IconButton(
                    onPressed: () {
                      newMethod.currentState!.pushNamed('/');
                    },
                    // label: Text(
                    //     '${cartMenuItem.quanity} x ${toPricingText(cartMenuItem.menuitem.basePrice)}'),
                    icon: Icon(Icons.edit_rounded),
                  ),
                  Spacer(),
                  IconButton(
                    onPressed: () {
                      context.read<AppState>().cart.remove(cartMenuItem);
                      // ignore: invalid_use_of_protected_member,invalid_use_of_visible_for_testing_member
                      context.read<AppState>().notifyListeners();
                    },
                    // label: Text(
                    //     '${cartMenuItem.quanity} x ${toPricingText(cartMenuItem.menuitem.basePrice)}'),
                    icon: Icon(Icons.remove_circle_outline_rounded),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  GlobalKey<NavigatorState> get newMethod => GlobalNav;
}

class BSCartMenuItem {
  final Menuitem menuitem;
  Map<String, dynamic> selectedOptions = {};
  int quanity = 1;
  BSCartMenuItem(this.menuitem);
}

class BSCart {
  List<BSCartMenuItem> items = [];
  // ignore: unused_field
  int _total = 0;

  remove(BSCartMenuItem cartMenuItem) {
    items.remove(cartMenuItem);
  }

  int get itemsTotal {
    // print('items.length::${items.length}');
    var __total = 0;
    for (var i = 0; i < items.length; i++) {
      var item = items[i];

      // for (var ii = 1; ii < item.quanity + 1; ii++) {
      //   print(ii);

      //   // _total = __total + __subtotal;
      // }
      __total = __total + (item.menuitem.basePrice * item.quanity);
    }

    return __total;
  }
}
