import 'package:flavor_client/components/page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:losbetosapp/src/components/hero_image.dart';
import 'package:losbetosapp/main.dart';
import 'package:losbetosapp/src/models/menu/_functions.dart';
import 'package:losbetosapp/src/models/models.dart';
import 'package:losbetosapp/src/utilities/utilities.dart';
import 'package:provider/provider.dart' as Provider;

class ScreenMenuItem extends StatefulWidget {
  final String id;
  const ScreenMenuItem({
    Key? key,
    required this.id,
  }) : super(key: key);

  @override
  _ScreenMenuItemState createState() => _ScreenMenuItemState();
}

class _ScreenMenuItemState extends State<ScreenMenuItem> {
  Menuitem? menuItem;
  BSCartMenuItem? cartMenuItem;
  @override
  void initState() {
    menuItem = getMenuItemsSingle(widget.id);
    cartMenuItem = BSCartMenuItem(menuItem!);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (menuItem == null) {
      return PageError(
        errorCode: 404.toString(),
        msg: 'Menu item ${widget.id} doesnt exist',
        title: 'Missing Menu Item',
      );
    }

    return Consumer(builder: (context, watch, _) {
      return Scaffold(
        body: Stack(
          fit: StackFit.expand,
          children: [
            CustomScrollView(
              slivers: [
                SliverAppBar(
                  title: menuItem!.imageUrl == null
                      ? ListTile(
                          title: Text(menuItem!.title.toString()),
                          subtitle: menuItem!.description != null
                              ? Text(menuItem!.description.toString())
                              : null,
                        )
                      : null,
                  // backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                  // leading: IconButton(
                  //     onPressed: () => GlobalNav.currentState!.pushNamed('/'),
                  //     icon: Icon(Icons.arrow_back_ios_new)),
                  flexibleSpace: menuItem!.imageUrl != null
                      ? HeroImage(
                          key: ValueKey(menuItem!.imageUrl),
                          image: Image.asset(
                            menuItem!.imageUrl!,
                            fit: BoxFit.cover,
                          ).image,
                        )
                      : null,
                  expandedHeight: menuItem!.imageUrl != null ? 300 : 0,
                  bottom: menuItem!.imageUrl != null
                      ? AppBar(
                          // elevation: 2,
                          automaticallyImplyLeading: false,
                          title: ListTile(
                            title: Text(menuItem!.title.toString()),
                            subtitle: Text(menuItem!.description.toString()),
                          ),
                        )
                      : null,
                ),
                SliverToBoxAdapter(),
              ],
            ),
            Align(
              alignment: Alignment.bottomCenter,
              widthFactor: 1,
              child: Container(
                margin: EdgeInsets.only(bottom: 32),
                child: Card(
                  elevation: 2,
                  child: Container(
                    padding: EdgeInsets.all(12),
                    constraints: BoxConstraints(
                      maxWidth: 280,
                      minWidth: 100,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Flexible(child: buildQuanityButtons(context)),
                        Container(
                          margin: const EdgeInsets.all(2),
                          child: ElevatedButton(
                            onPressed: () {
                              settingsController.cart.addToCart(cartMenuItem!);
                              settingsController.globalNavKey.currentState!
                                  .pop();
                              final snackBar = SnackBar(
                                content: Text(
                                    '${cartMenuItem!.menuitem.title} was added to your cart!'),
                                duration: Duration(milliseconds: 3200),
                                action: SnackBarAction(
                                  label: 'View Cart',
                                  onPressed: () {},
                                ),
                              );

                              ScaffoldMessenger.of(context)
                                  .showSnackBar(snackBar);
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                // mainAxisAlignment:
                                //     MainAxisAlignment.spaceAround,
                                children: [
                                  Icon(
                                    Icons.add_shopping_cart_rounded,
                                    size: 16,
                                  ),
                                  SizedBox(
                                    width: 4,
                                  ),
                                  Text(
                                    '${toPricingText(menuItem!.basePrice * cartMenuItem!.quanity)}',
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      );
    });
  }

  Widget buildQuanityButtons(BuildContext context) {
    return Container(
      child: Row(
        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          ElevatedButton(
            style: buttonQStyle(),
            onPressed: () {
              if (cartMenuItem!.quanity == 1) {
                return;
              }
              setState(() {
                cartMenuItem!.quanity--;
              });
            },
            child: Icon(
              Icons.arrow_downward_rounded,
              size: 16,
            ),
          ),
          SizedBox(
            width: 10,
          ),
          Container(
            child: Text(
              '${cartMenuItem!.quanity}',
              style: Theme.of(context).textTheme.headline6,
            ),
          ),
          SizedBox(
            width: 10,
          ),
          ElevatedButton(
            style: buttonQStyle(),
            onPressed: () {
              setState(() {
                cartMenuItem!.quanity++;
              });
            },
            child: Icon(
              Icons.arrow_upward_rounded,
              size: 16,
            ),
          ),
        ],
      ),
    );
  }
}

ButtonStyle buttonQStyle() {
  return ButtonStyle(
      padding: MaterialStateProperty.resolveWith(
        (states) => EdgeInsets.all(8),
      ),
      minimumSize: MaterialStateProperty.resolveWith((states) => Size(24, 30)));
}
