import 'package:flutter/material.dart';
import 'package:losbetos/models/models.dart';
import 'package:losbetos/pages/menu.item.detail.dart';
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
    // print('app.cart.items.length::${app.cart.items.length}');
    return Scaffold(
      // appBar: AppBar(
      //   automaticallyImplyLeading: false,
      //   title: Text('Cart'),
      // ),
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
                      onUpdateQuanity: (int quanity) {
                        print('quanity::$quanity');
                        app.updateQuanity(index, quanity);
                      },
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
                      size: 80,
                    ),
                    Text(
                      'No items in your cart.',
                      style: Theme.of(context).textTheme.headline6,
                    )
                  ],
                ),
              );
            }),
      ),
    );
  }
}

class CartMenuItemTile extends StatefulWidget {
  final BSCartMenuItem cartMenuItem;
  final void Function(int quanity)? onUpdateQuanity;
  const CartMenuItemTile({
    Key? key,
    required this.cartMenuItem,
    this.onUpdateQuanity,
  }) : super(key: key);

  @override
  _CartMenuItemTileState createState() => _CartMenuItemTileState();
}

class _CartMenuItemTileState extends State<CartMenuItemTile> {
  @override
  Widget build(BuildContext context) {
    // print('menuItem.imageUrl::${menuItem.imageUrl}');
    // ignore: unused_local_variable
    Widget leading = Container();

    return ListTile(
      // isThreeLine: true,
      leading: widget.cartMenuItem.menuitem.imageUrl != null
          ? AspectRatio(
              aspectRatio: 1,
              child:
                  // HeroImage(
                  //   image:
                  Image.asset(
                widget.cartMenuItem.menuitem.imageUrl!,
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
      title: widget.cartMenuItem.menuitem.title != null
          ? Text(widget.cartMenuItem.menuitem.title!)
          : null,
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          widget.cartMenuItem.menuitem.description != null
              ? Text(
                  widget.cartMenuItem.selectedOptions.length.toString(),
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
            // Text(
            //     '${widget.cartMenuItem.quanity} x ${toPricingText(widget.cartMenuItem.menuitem.basePrice * widget.cartMenuItem.quanity)}'),
            Text(
                '${toPricingText(widget.cartMenuItem.menuitem.basePrice * widget.cartMenuItem.quanity)}'),
            Flexible(
              // edit and remove
              // child: Row(
              //   children: [
              //     IconButton(
              //       onPressed: () {
              //         newMethod.currentState!.pushNamed('/');
              //       },
              //       // label: Text(
              //       //     '${cartMenuItem.quanity} x ${toPricingText(cartMenuItem.menuitem.basePrice)}'),
              //       icon: Icon(Icons.edit_rounded),
              //     ),
              //     Spacer(),
              //     IconButton(
              //       onPressed: () {
              //         context.read<AppState>().cart.remove(cartMenuItem);
              //         // ignore: invalid_use_of_protected_member,invalid_use_of_visible_for_testing_member
              //         context.read<AppState>().notifyListeners();
              //       },
              //       // label: Text(
              //       //     '${cartMenuItem.quanity} x ${toPricingText(cartMenuItem.menuitem.basePrice)}'),
              //       icon: Icon(Icons.remove_circle_outline_rounded),
              //     ),
              //   ],
              // ),

              child: Row(
                // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton(
                    style: buttonQStyle(),
                    // onPressed: () {
                    //   if (widget.cartMenuItem.quanity == 1) {
                    //     return;
                    //   }
                    //   setState(() {
                    //     widget.cartMenuItem.quanity--;
                    //   });
                    // },

                    onPressed: () {
                      if (widget.cartMenuItem.quanity == 1) {
                        return;
                      }
                      widget.onUpdateQuanity != null
                          ? widget
                              .onUpdateQuanity!(widget.cartMenuItem.quanity - 1)
                          : null;
                    },
                    child: Icon(
                      widget.cartMenuItem.quanity == 1
                          ? Icons.delete
                          : Icons.arrow_downward_rounded,
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Container(
                    child: Text(
                      '${widget.cartMenuItem.quanity}',
                      style: Theme.of(context).textTheme.bodyText2,
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  ElevatedButton(
                    style: buttonQStyle(),
                    // onPressed: () {
                    //   setState(() {
                    //     widget.cartMenuItem.quanity++;
                    //   });
                    // },
                    onPressed: () => widget.onUpdateQuanity != null
                        ? widget
                            .onUpdateQuanity!(widget.cartMenuItem.quanity + 1)
                        : null,
                    child: Icon(
                      Icons.arrow_upward_rounded,
                    ),
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
  Map selectedOptions = {};
  int quanity = 1;
  //
  BSCartMenuItem(this.menuitem);
  //

  //
  Map toMap() {
    // return super.toString();
    Map _map = {
      'selectedOptions': selectedOptions,
      'quanity': quanity,
      'menuitem': menuitem.toMap(),
    };
    return _map;
  }
}

class BSCart {
  BSCart({this.items = const []});
  final List<BSCartMenuItem> items;
  // ignore: unused_field
  int _total = 0;

  remove(BSCartMenuItem cartMenuItem) {
    items.remove(cartMenuItem);
  }

  add(BSCartMenuItem cartMenuItem) {
    items.add(cartMenuItem);
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

  static BSCart? fromMap(Map _map) {
    // return BSCart()..items;
  }

  Map toMap() {
    Map _map = {};

    for (var i = 0; i < items.length; i++) {
      _map.putIfAbsent(i, () => items[i].toMap());
    }

    return _map;
  }

  List toList() {
    List _list = [];

    for (var i = 0; i < items.length; i++) {
      _list.add(items[i].toMap());
    }

    return _list;
  }

  static BSCart fromList(List fromList) {
    List<BSCartMenuItem> items = [];
    for (var i = 0; i < fromList.length; i++) {
      var _item = fromList[i] as Map;
      // _list.add();
      // print(_item);
      BSCartMenuItem _bs = BSCartMenuItem(Menuitem.fromMap(_item['menuitem']));
      // print('_bs.menuitem.title');
      // print(_bs.menuitem.title);
      _bs.selectedOptions =
          _item.containsKey('selectedOptions') ? _item['selectedOptions'] : {};
      _bs.quanity = _item['quanity'];
      items.add(_bs);
    }
    return BSCart(items: items);
  }
}
