import 'package:flavor_client/components/page.dart';
import 'package:flutter/material.dart';
import 'package:losbetos/components/heroImage.dart';
import 'package:losbetos/models/menu02/_functions.dart';
import 'package:losbetos/models/models.dart';
import 'package:losbetos/pages/cart.dart';
import 'package:losbetos/state.dart';
import 'package:losbetos/utilities.dart';
import 'package:provider/provider.dart';

class PageMenuItem extends StatefulWidget {
  final String id;
  const PageMenuItem({
    Key? key,
    required this.id,
  }) : super(key: key);

  @override
  _PageMenuItemState createState() => _PageMenuItemState();
}

class _PageMenuItemState extends State<PageMenuItem> {
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
    var app = context.read<AppState>();

    if (menuItem == null) {
      return PageError(
        errorCode: 404.toString(),
        msg: 'Menu item ${widget.id} doesnt exist',
        title: 'Missing Menu Item',
      );
    }

    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          CustomScrollView(
            slivers: [
              SliverAppBar(
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
                expandedHeight: 300,
                bottom: AppBar(
                  automaticallyImplyLeading: false,
                  title: ListTile(
                    title: Text(menuItem!.title.toString()),
                    subtitle: Text(menuItem!.description.toString()),
                  ),
                ),
              ),
            ],
          ),
          Align(
            alignment: Alignment.bottomCenter,
            widthFactor: 1,
            child: Container(
              margin: EdgeInsets.all(24),
              child: Card(
                child: Container(
                  padding: EdgeInsets.all(24),
                  constraints: BoxConstraints(
                    maxWidth: 260,
                    minWidth: 100,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Flexible(child: buildQuanityButtons(context)),
                      // Spacer(),
                      SizedBox(
                        width: 32,
                      ),
                      Flexible(
                        flex: 1,
                        child: FloatingActionButton.extended(
                          onPressed: () {
                            app.addToCart(cartMenuItem!);
                            GlobalNav.currentState!.pop();
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
                          label: Row(
                            children: [
                              Icon(
                                Icons.add_shopping_cart_rounded,
                                color: Colors.white,
                              ),
                              SizedBox(
                                width: 4,
                              ),
                              Text(
                                '${toPricingText(menuItem!.basePrice * cartMenuItem!.quanity)}',
                                style: Theme.of(context)
                                    .textTheme
                                    .headline6!
                                    .copyWith(color: Colors.white),
                              ),
                            ],
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
  }

  Widget buildQuanityButtons(BuildContext context) {
    return Container(
      constraints: BoxConstraints(
        maxWidth: 160,
        minWidth: 100,
      ),
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
        (states) => EdgeInsets.all(4),
      ),
      minimumSize: MaterialStateProperty.resolveWith((states) => Size(16, 30)));
}
