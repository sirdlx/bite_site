import 'package:flutter/material.dart';
import 'package:losbetosapp/src/features/menu_item/menu_item_model.dart';
import 'package:losbetosapp/src/utilities/hero_image.dart';
import 'package:losbetosapp/src/utilities/utilities.dart';

class MenuItemTile extends StatelessWidget {
  final Menuitem menuItem;
  final void Function()? onTap;
  const MenuItemTile({
    Key? key,
    required this.menuItem,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // print('menuItem.imageUrl::${menuItem.imageUrl}');
    // ignore: unused_local_variable
    Widget leading = Container();

    return ListTile(
      leading: menuItem.imageUrl != null
          ? AspectRatio(
              aspectRatio: 2.2,
              child: HeroImage(
                image: Image.asset(
                  menuItem.imageUrl!,
                  fit: BoxFit.cover,
                ).image,
              ),
            )
          : AspectRatio(
              aspectRatio: 1,
              child: Container(),
            ),
      title: Text(menuItem.title!),
      subtitle: menuItem.description != null
          ? Text(
              menuItem.description!,
              // style: Theme.of(context).textTheme.caption!.copyWith(
              //       color: Colors.white70,
              //     ),
            )
          : null,
      onTap: onTap,
      trailing: Text(toPricingText(menuItem.basePrice)),
    );
  }
}
