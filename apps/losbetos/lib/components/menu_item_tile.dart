import 'package:flutter/material.dart';
import 'package:losbetosapp/components/hero_image.dart';
import 'package:losbetosapp/models/models.dart';
import 'package:losbetosapp/utilities/utilities.dart';

class MenuItemTile extends StatelessWidget {
  final Menuitem menuItem;
  const MenuItemTile({
    Key? key,
    required this.menuItem,
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
      // onTap: () {
      //   GlobalNav.currentState!.pushNamed(
      //       '/menu/category/${menuItem.categoryId}/item/${menuItem.id}');
      // },
      trailing: Text(toPricingText(menuItem.basePrice)),
    );
  }
}
