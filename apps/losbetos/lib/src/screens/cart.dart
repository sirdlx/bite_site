import 'package:flutter/material.dart';
import 'package:flutter_remix/flutter_remix.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:losbetosapp/main.dart';
import 'package:losbetosapp/src/models/models.dart';
import 'package:losbetosapp/src/screens/layout.dart';
import 'package:losbetosapp/src/screens/menu_item.dart';
import 'package:losbetosapp/src/utilities/utilities.dart';
import 'package:miniplayer/miniplayer.dart';
import 'package:provider/src/provider.dart';

class ScreenCartView extends StatelessWidget {
  const ScreenCartView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var cart = settingsController.cart;
    return Consumer(builder: (context, ref, _) {
      return Scaffold(
        appBar: AppBar(
          elevation: 0,
          // backgroundColor: Colors.transparent,
          title: const Text('Current Order'),
          // leading: GestureDetector(
          //   // onTap: () => ref
          //   //     .read(miniPlayerControllerProvider)
          //   //     .state
          //   //     .animateToHeight(state: PanelState.MIN),

          //   onTap: () => settingsController.globalNavKey.currentState!.pop(),
          //   child: const Icon(FlutterRemix.close_circle_line),
          // ),
        ),
        bottomNavigationBar: cart.items.isNotEmpty
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
                          TextSpan(text: toPricingText(cart.itemsTotal)),
                        ],
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).pushNamed('/checkout');
                      },
                      child: const Text(
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
              child: FutureBuilder(
                  future: Future.delayed(Duration(milliseconds: 3000)),
                  builder: (context, snapshot) {
                    if (snapshot.hasData || cart.items.length > 0) {
                      return Card(
                        margin: const EdgeInsets.all(16),
                        child: ListView.separated(
                          shrinkWrap: true,
                          separatorBuilder: (context, index) => const Divider(
                            thickness: 1,
                          ),
                          itemBuilder: (context, index) => CartMenuItemTile(
                            cartMenuItem: cart.items[index],
                            onUpdateQuanity: (int quanity) {
                              print('quanity::$quanity');
                              cart.updateQuanity(index, quanity);
                            },
                          ),
                          itemCount: cart.items.length,
                        ),
                      );
                    }

                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Flexible(
                          child: Icon(
                            FlutterRemix.shopping_bag_2_line,
                            size: 72,
                          ),
                        ),
                        Flexible(
                          child: Text(
                            'No items in your basket.',
                            style: Theme.of(context).textTheme.headline5,
                          ),
                        )
                      ],
                    );
                  }),
            ),
          ],
        ),
      );
    });
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
}
