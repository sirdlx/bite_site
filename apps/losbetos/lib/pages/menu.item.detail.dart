import 'package:flutter/material.dart';
import 'package:losbetos/components/heroImage.dart';
import 'package:losbetos/models/menu1/menu.functions.dart';
import 'package:losbetos/models/models.dart';
import 'package:losbetos/state.dart';
import 'package:losbetos/utilities.dart';

class PageMenuItem extends StatelessWidget {
  final String id;
  const PageMenuItem({
    Key? key,
    required this.id,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // final name = ModalRoute.of(context)!.settings.name;

    // // print('name::$name');
    // var uri = Uri.dataFromString(name as String);
    // // print(uri.pathSegments.last);

    // var id = uri.pathSegments.last;
    // print(uri.pathSegments.length);

    var items = getMenuItems;

    Menuitem? menuItem;

    for (var i = 0; i < items.length; i++) {
      if (items[i].id == id) {
        menuItem = items[i];
      }
    }

    if (menuItem != null) {
      return Scaffold(
        body: CustomScrollView(
          slivers: [
            SliverAppBar(
              // leading: IconButton(
              //     onPressed: () => GlobalNav.currentState!.pushNamed('/'),
              //     icon: Icon(Icons.arrow_back_ios_new)),
              flexibleSpace: menuItem.imageUrl != null
                  ? HeroImage(
                      key: ValueKey(menuItem.imageUrl),
                      image: Image.asset(
                        menuItem.imageUrl!,
                        fit: BoxFit.cover,
                      ).image,
                    )
                  : null,
              expandedHeight: 300,
              bottom: AppBar(
                automaticallyImplyLeading: false,
                title: ListTile(
                  title: Text(menuItem.title.toString()),
                  subtitle: Text(menuItem.description.toString()),
                ),
              ),
            ),
          ],
        ),
      );
    }

    // GlobalNav.currentState!.pushNamedAndRemoveUntil('/', (route) => false);

    return Scaffold(
      body: ListView(
        children: List.generate(
          getMenuItems.length,
          (index) {
            Menuitem item = items[index];
            return ListTile(
              onTap: () => GlobalNav.currentState!
                  .pushNamed('/catalog/${item.id}', arguments: item),
              leading: item.imageUrl != null
                  ? Hero(
                      tag: ValueKey(item),
                      // child: Image.asset(
                      //   item.imageUrl,
                      //   fit: BoxFit.cover,
                      // ),
                      child: item.imageUrl != null
                          ? Image.asset(
                              item.imageUrl!,
                              fit: BoxFit.cover,
                            )
                          : Container(),
                    )
                  : null,
              title: Text(item.title!.toString()),
              subtitle: Text(item.description!.toString()),
              trailing: Text(toPricingText(item.basePrice)),
            );
          },
        ),
      ),
    );
  }
}
