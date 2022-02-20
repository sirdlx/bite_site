import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:losbetosapp/main.dart';
import 'package:losbetosapp/src/components/error.dart';
import 'package:losbetosapp/src/features/menu/_functions.dart';
import 'package:losbetosapp/src/features/menu_item/menu_item_model.dart';
import 'package:losbetosapp/src/themes/light.dart';
import 'package:losbetosapp/src/utilities/hero_image.dart';
import 'package:losbetosapp/src/utilities/utilities.dart';

AppBar detailsAppBar(menuItem) {
  bool showHero = menuItem != null && menuItem!.imageUrl != null;

  return AppBar(
    elevation: 0,
    backgroundColor: Colors.transparent,
    leading: IconButton(
      icon: const Icon(
        Icons.arrow_back,
        color: Colors.white,
      ),
      onPressed: () {
        appController.globalNavKey.currentState!.pop();
      },
    ),
    actions: <Widget>[
      IconButton(
        icon: SvgPicture.asset("assets/icons/share.svg"),
        onPressed: () {},
      ),
      IconButton(
        icon: SvgPicture.asset("assets/icons/more.svg"),
        onPressed: () {},
      ),
    ],
  );
}

class LBScreenMenuItem extends StatefulWidget {
  final String id;
  const LBScreenMenuItem({
    Key? key,
    required this.id,
  }) : super(key: key);

  @override
  _LBScreenMenuItemState createState() => _LBScreenMenuItemState();
}

class _LBScreenMenuItemState extends State<LBScreenMenuItem> {
  Menuitem? menuItem;
  late CartMenuItem cartMenuItem;
  @override
  void initState() {
    menuItem = getMenuItemsSingle(widget.id);
    cartMenuItem = CartMenuItem(menuItem: menuItem!);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (menuItem == null) {
      return ErrorView(
        // errorCode: 404.toString(),
        message: 'Menu item ${widget.id} doesnt exist',
        // title: 'Missing Menu Item',
        // type: 'fire',
      );
    }

    bool showHero = menuItem != null && menuItem!.imageUrl != null;

    return Scaffold(
      backgroundColor: lbThemeLight.primaryColor,
      // appBar: detailsAppBar(menuItem),
      // body: DetailsBody(
      //   menuItem: menuItem!,
      // ),
      bottomNavigationBar: OrderButton(
        onTap: () {
          appController.cart.addToCart(cartMenuItem);
          appController.globalNavKey.currentState!.pop();
          final snackBar = SnackBar(
            content:
                Text('${cartMenuItem.menuItem.title} was added to your cart!'),
            duration: const Duration(milliseconds: 3200),
            action: SnackBarAction(
              label: 'View Cart',
              onPressed: () {},
            ),
          );

          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        },
        price: menuItem!.basePrice * cartMenuItem.quanity,
      ),

      body: Stack(
        children: [
          showHero
              ? SizedBox(
                  height: 300,
                  child: HeroImage(
                    key: ValueKey(menuItem!.imageUrl),
                    image: Image.asset(
                      menuItem!.imageUrl!,
                      fit: BoxFit.cover,
                    ).image,
                  ),
                )
              : Container(),
          Align(
            alignment: Alignment.bottomCenter,
            child: SizedBox(
              height: MediaQuery.of(context).size.height - 250,
              child: DetailsBody(
                menuItem: menuItem!,
              ),
            ),
          ),
          Align(alignment: Alignment.topCenter, child: detailsAppBar(menuItem)),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              padding: const EdgeInsets.all(12),
              constraints: const BoxConstraints(
                maxWidth: 320,
                minWidth: 100,
              ),
              child: buildQuanityButtons(context),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildQuanityButtons(BuildContext context) {
    return SizedBox(
      // width: 320,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextButton(
            // style: buttonQStyle(context),
            onPressed: () {
              if (cartMenuItem.quanity == 1) {
                return;
              }
              setState(() {
                cartMenuItem.quanity--;
              });
            },
            child: const Icon(
              Icons.arrow_downward_rounded,
              size: 16,
            ),
          ),
          const SizedBox(
            width: 10,
          ),
          Container(
            child: Text(
              '${cartMenuItem.quanity}',
              style: Theme.of(context).textTheme.headline6,
            ),
          ),
          const SizedBox(
            width: 10,
          ),
          TextButton(
            // style: buttonQStyle(context),
            onPressed: () {
              setState(() {
                cartMenuItem.quanity += 1;
              });
            },
            child: const Icon(
              Icons.arrow_upward_rounded,
              size: 16,
            ),
          ),
        ],
      ),
    );
  }
}

ButtonStyle buttonQStyle(BuildContext context) {
  return ButtonStyle(
      padding: MaterialStateProperty.resolveWith(
        (states) => const EdgeInsets.all(8),
      ),
      minimumSize: MaterialStateProperty.resolveWith(
        (states) => const Size(24, 30),
      ),
      backgroundColor: MaterialStateProperty.resolveWith(
          (states) => Theme.of(context).primaryColor));
}

class DetailsBody extends StatelessWidget {
  final Menuitem menuItem;

  const DetailsBody({Key? key, required this.menuItem}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // ItemImage(
        //   imgSrc: "assets/images/burger.png",
        // ),

        Expanded(
          child: ItemInfo(
            menuItem: menuItem,
          ),
        ),
      ],
    );
  }
}

class ItemInfo extends StatelessWidget {
  final Menuitem menuItem;

  const ItemInfo({
    Key? key,
    required this.menuItem,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      width: double.infinity,
      decoration: BoxDecoration(
        // color: Colors.white,
        color: Theme.of(context).cardColor,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // shopeName(name: "MacDonalds"),
          TitlePriceRating(
            name: menuItem.title,
            numOfReviews: 24,
            rating: 4,
            price: menuItem.basePrice,
            // onRatingChanged: (value) {},
          ),
          menuItem.description != null
              ? Text(
                  menuItem.description!,
                  style: const TextStyle(
                    height: 1.5,
                  ),
                )
              : Container(),
          const SizedBox(height: 10),
        ],
      ),
    );
  }

  Row shopeName({String? name}) {
    return Row(
      children: <Widget>[
        Icon(
          Icons.location_on,
          color: lbThemeLight.secondaryHeaderColor,
        ),
        SizedBox(width: 10),
        name != null ? Text(name) : Container(),
      ],
    );
  }
}

class TitlePriceRating extends StatelessWidget {
  final int price;
  final int numOfReviews;
  final double? rating;
  final String? name;
  // final RatingChangeCallback onRatingChanged;
  const TitlePriceRating({
    Key? key,
    this.price = 0,
    this.numOfReviews = 0,
    this.rating,
    this.name,
    // this.onRatingChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: Row(
        children: <Widget>[
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  name ?? '',
                  style: Theme.of(context).textTheme.headline6,
                ),
                SizedBox(height: 10),
                Row(
                  children: <Widget>[
                    // SmoothStarRating(
                    //   borderColor: lbThemeLight.primaryColor,
                    //   rating: rating,
                    //   onRatingChanged: onRatingChanged,
                    // ),
                    SizedBox(width: 10),
                    Text("$numOfReviews reviews"),
                  ],
                ),
              ],
            ),
          ),
          priceTag(context, price: price),
        ],
      ),
    );
  }

  ClipPath priceTag(BuildContext context, {int price = 0}) {
    return ClipPath(
      clipper: PricerCliper(),
      child: Container(
        alignment: Alignment.topCenter,
        padding: const EdgeInsets.symmetric(vertical: 15),
        height: 66,
        width: 65,
        color: lbThemeLight.primaryColor,
        child: Text(
          toPricingText(price),
          style: Theme.of(context)
              .textTheme
              .headline6!
              .copyWith(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}

class PricerCliper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    double ignoreHeight = 20;
    path.lineTo(0, size.height - ignoreHeight);
    path.lineTo(size.width / 2, size.height);
    path.lineTo(size.width, size.height - ignoreHeight);
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }
}

class OrderButton extends StatelessWidget {
  final int? price;

  final String? text;

  OrderButton({
    Key? key,
    this.price,
    required this.onTap,
    this.text,
  }) : super(key: key);

  // final Size size;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: lbThemeLight.primaryColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  Icons.add_shopping_cart_rounded,
                  size: 16,
                ),
                const SizedBox(
                  width: 4,
                ),
                Text(
                  price != null
                      ? toPricingText(price!)
                      : text != null
                          ? text!
                          : '',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ItemImage extends StatelessWidget {
  final String imgSrc;
  const ItemImage({
    Key? key,
    required this.imgSrc,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Image.asset(
      imgSrc,
      height: size.height * 0.25,
      width: double.infinity,
      // it cover the 25% of total height
      fit: BoxFit.fill,
    );
  }
}
