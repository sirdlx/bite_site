import 'package:flavor_ui/flavor_ui.dart';
import 'package:flutter/material.dart' as m;
import 'package:flutter/widgets.dart';
import 'package:losbetosapp/main.dart';
import 'package:losbetosapp/src/components/card.dart';
import 'package:losbetosapp/src/features/cart/cart_controller.dart';
import 'package:losbetosapp/src/features/menu_item/menu_item_model.dart';
import 'package:losbetosapp/src/utilities/utilities.dart';

class ScreenCartView extends StatelessWidget {
  const ScreenCartView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var cart = appController.cart;
    return AnimatedBuilder(
        animation: cart,
        builder: (context, snapshot) {
          return m.Scaffold(
            appBar: m.AppBar(
              elevation: 0,
              // backgroundColor: Colors.transparent,
              title: const Text('Current Order'),
              // leading: GestureDetector(
              //   // onTap: () => ref
              //   //     .read(miniPlayerControllerProvider)
              //   //     .state
              //   //     .animateToHeight(state: PanelState.MIN),

              //   onTap: () => appController.globalNavKey.currentState!.pop(),
              //   child: const Icon(FlutterRemix.close_circle_line),
              // ),
            ),
            bottomNavigationBar: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  RichText(
                    text: TextSpan(
                      text: 'Total : ',
                      style: m.Theme.of(context).textTheme.headline6,
                      children: [
                        cart.cart.items != null
                            ? TextSpan(text: toPricingText(cart.total))
                            : const TextSpan(text: '\$0.00'),
                      ],
                    ),
                  ),
                  m.ElevatedButton(
                    onPressed:
                        cart.cart.items != null && cart.cart.items!.isNotEmpty
                            ? () {
                                Navigator.of(context).pushNamed('/checkout');
                              }
                            : null,
                    child: const Text(
                      'Checkout',
                      // style: Theme.of(context).textTheme.headline5,
                    ),
                  ),
                ],
              ),
            ),
            body: m.SingleChildScrollView(
              controller: m.ScrollController(),
              child: m.Padding(
                padding: const EdgeInsets.all(16.0),
                child: m.Column(
                  children: cart.cart.items!
                      // .map((e) => LBCard(
                      //       child: CartMenuItemTile(
                      //         cartController: cart,
                      //         cartMenuItem: e,
                      //         onUpdateQuanity: (int quanity) {
                      //           cart.updateQuanity(e, quanity);
                      //         },
                      //       ),
                      //     ))
                      .map((e) => m.Container(
                            // color: m.Colors.amber,
                            child: LBCard(
                              child: m.Padding(
                                padding: const EdgeInsets.all(0.0),
                                child: m.Column(
                                  crossAxisAlignment:
                                      m.CrossAxisAlignment.start,
                                  children: [
                                    m.GridTileBar(
                                      title: m.Text(e.menuItem.title!),
                                      trailing: m.IconButton(
                                          onPressed: () {},
                                          icon: m.Icon(m.Icons.edit)),
                                    ),
                                    m.Padding(
                                      padding: m.EdgeInsets.all(16),
                                      child: m.Column(
                                        children: [
                                          ...?selectedOptionsToWidget(e),
                                        ],
                                      ),
                                    ),
                                    m.Padding(
                                      padding: const m.EdgeInsets.all(16),
                                      child: Row(
                                        children: [
                                          GestureDetector(
                                            // style: buttonQStyle(),
                                            onTap: () {
                                              if (e.quanity == 1) {
                                                m.showDialog(
                                                  context: context,
                                                  builder: (context) {
                                                    return m.AlertDialog(
                                                      content: m.Text(
                                                          'Are you sure you want to remove this item?'),
                                                      actions: [
                                                        m.TextButton(
                                                          onPressed: () {
                                                            m.Navigator.of(
                                                                    context)
                                                                .pop();
                                                          },
                                                          child:
                                                              m.Text('Cancel'),
                                                        ),
                                                        m.ElevatedButton(
                                                          onPressed: () {
                                                            cart.removeFromCart(
                                                              e,
                                                            );
                                                            m.Navigator.of(
                                                                    context)
                                                                .pop();
                                                          },
                                                          child:
                                                              m.Text('Remove'),
                                                        )
                                                      ],
                                                    );
                                                  },
                                                  useRootNavigator: true,
                                                );
                                                return;
                                              }
                                              cart.updateQuanity(
                                                  e, e.quanity - 1);
                                            },
                                            child: Icon(
                                              e.quanity == 1
                                                  ? m.Icons.close
                                                  : m.Icons
                                                      .arrow_downward_rounded,
                                              size: 14,
                                            ),
                                          ),
                                          const SizedBox(
                                            width: 10,
                                          ),
                                          Container(
                                            child: Text(
                                              '${e.quanity}',
                                              // style: Theme.of(context).textTheme.bodyText2,
                                            ),
                                          ),
                                          const SizedBox(
                                            width: 10,
                                          ),
                                          GestureDetector(
                                            // style: buttonQStyle(),
                                            // onPressed: () {
                                            //   setState(() {
                                            //     widget.cartMenuItem.quanity++;
                                            //   });
                                            // },
                                            onTap: () {
                                              cart.updateQuanity(
                                                  e, e.quanity + 1);
                                            },
                                            child: const Icon(
                                              m.Icons.arrow_upward_rounded,
                                              size: 14,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ))
                      .toList(),
                ),
              ),
            ),
          );
        });
  }

  List<Widget>? selectedOptionsToWidget(CartMenuItem e) {
    if (e.selectedOptions == null) {
      return [];
    }
    return e.selectedOptions!.map((e) => const m.Text('data')).toList();
  }
}

class CartMenuItemTile extends StatefulWidget {
  final CartMenuItem cartMenuItem;
  final void Function(int quanity)? onUpdateQuanity;
  final CartController cartController;
  const CartMenuItemTile({
    Key? key,
    required this.cartMenuItem,
    this.onUpdateQuanity,
    required this.cartController,
  }) : super(key: key);

  @override
  _CartMenuItemTileState createState() => _CartMenuItemTileState();
}

class _CartMenuItemTileState extends State<CartMenuItemTile> {
  @override
  Widget build(BuildContext context) {
    return CardTile(
      containerTileLayout: CardTileLayout.seperated,
      // color: m.Colors.amber,
      header: ListTile(
        leading: AspectRatio(
          aspectRatio: 1,
          child: widget.cartMenuItem.menuItem.imageUrl != null
              ? Image.asset(
                  widget.cartMenuItem.menuItem.imageUrl!,
                  fit: BoxFit.cover,
                )
              : null,
        ),
        title: widget.cartMenuItem.menuItem.title != null
            ? Text(widget.cartMenuItem.menuItem.title!)
            : null,
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            widget.cartMenuItem.menuItem.description != null
                ? Text(
                    widget.cartMenuItem.menuItem.description.toString(),
                    style: m.Theme.of(context).textTheme.caption!,
                  )
                : Container(),
          ],
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: m.MainAxisAlignment.start,
        children: [
          m.Padding(
            padding: m.EdgeInsets.all(20),
            child: m.Column(
              children: [
                Text(
                  'widget.cartMenuItem.menuItem.description.toString',
                ),
                Text(
                  'widget.cartMenuItem.menuItem.description.toString',
                ),
                Text(
                  'widget.cartMenuItem.menuItem.description.toString',
                ),
                Text(
                  'widget.cartMenuItem.menuItem.description.toString',
                ),
              ],
            ),
          )
        ],
      ),
      footer: m.Padding(
        padding: const m.EdgeInsets.all(16),
        child: Row(
          children: [
            GestureDetector(
              // style: buttonQStyle(),
              onTap: () {
                if (widget.cartMenuItem.quanity == 1) {
                  return;
                }
                widget.onUpdateQuanity != null
                    ? widget.onUpdateQuanity!(widget.cartMenuItem.quanity - 1)
                    // ignore: unnecessary_statements
                    : () {};
              },
              child: Icon(
                widget.cartMenuItem.quanity == 1
                    ? m.Icons.delete
                    : m.Icons.arrow_downward_rounded,
              ),
            ),
            SizedBox(
              width: 10,
            ),
            Container(
              child: Text(
                '${widget.cartMenuItem.quanity}',
                // style: Theme.of(context).textTheme.bodyText2,
              ),
            ),
            SizedBox(
              width: 10,
            ),
            GestureDetector(
              // style: buttonQStyle(),
              // onPressed: () {
              //   setState(() {
              //     widget.cartMenuItem.quanity++;
              //   });
              // },
              onTap: () => widget.onUpdateQuanity != null
                  ? widget.onUpdateQuanity!(widget.cartMenuItem.quanity + 1)
                  : null,
              child: Icon(
                m.Icons.arrow_upward_rounded,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _CartMenuItemTileState2 extends State<CartMenuItemTile> {
  @override
  Widget build(BuildContext context) {
    // print('menuItem.imageUrl::${menuItem.imageUrl}');
    // ignore: unused_local_variable
    Widget leading = Container();

    return ListTile(
      // isThreeLine: true,
      leading: widget.cartMenuItem.menuItem.imageUrl != null
          ? AspectRatio(
              aspectRatio: 1,
              child:
                  // HeroImage(
                  //   image:
                  Image.asset(
                widget.cartMenuItem.menuItem.imageUrl!,
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
      title: widget.cartMenuItem.menuItem.title != null
          ? Text(widget.cartMenuItem.menuItem.title!)
          : null,
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          widget.cartMenuItem.menuItem.description != null
              ? Text(
                  widget.cartMenuItem.menuItem.description.toString(),
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
              toPricingText(
                widget.cartMenuItem.menuItem.basePrice *
                    widget.cartMenuItem.quanity,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
