import 'package:flutter/material.dart';
import 'package:losbetos/models/models.dart';
import 'package:losbetos/screens/layout.dart';
import 'package:losbetos/screens/menu_item.dart';
import 'package:losbetos/state/state.dart';
import 'package:losbetos/utilities/utilities.dart';
import 'package:miniplayer/miniplayer.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ScreenCartView extends StatelessWidget {
  final AppState app;
  const ScreenCartView({
    Key? key,
    required this.app,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // print('app.cart.items.length::${app.cart.items.length}');
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: Text('Cart'),
        actions: []
          ..add(
            GestureDetector(
              onTap: () => context
                  .read(miniPlayerControllerProvider)
                  .state
                  .animateToHeight(state: PanelState.MIN),
              child: Icon(Icons.arrow_drop_down_circle),
            ),
          )
          ..add(SizedBox(
            width: 16,
          )),
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
      body: CustomScrollView(
        slivers: [
          SliverFillRemaining(
            child: Container(
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

                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Flexible(
                          child: Icon(
                            Icons.shopping_cart_outlined,
                            size: 80,
                          ),
                        ),
                        Flexible(
                          child: Text(
                            'No items in your cart.',
                            style: Theme.of(context).textTheme.headline6,
                          ),
                        )
                      ],
                    );
                  }),
            ),
          ),
        ],
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
            Text(
                '${toPricingText(widget.cartMenuItem.menuitem.basePrice * widget.cartMenuItem.quanity)}'),
            Flexible(
              child: Row(
                children: [
                  ElevatedButton(
                    style: buttonQStyle(),
                    onPressed: () {
                      if (widget.cartMenuItem.quanity == 1) {
                        return;
                      }
                      widget.onUpdateQuanity != null
                          ? widget
                              .onUpdateQuanity!(widget.cartMenuItem.quanity - 1)
                          // ignore: unnecessary_statements
                          : () {};
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
