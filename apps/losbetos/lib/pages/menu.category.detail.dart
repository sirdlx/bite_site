import 'package:flutter/material.dart';
import 'package:losbetos/components/menuItemTile.dart';
import 'package:losbetos/models/menu02/_functions.dart';
import 'package:losbetos/models/models.dart';

class PageCategory extends StatefulWidget {
  final String id;
  const PageCategory({
    Key? key,
    required this.id,
  }) : super(key: key);

  @override
  _PageCategoryState createState() => _PageCategoryState();
}

class _PageCategoryState extends State<PageCategory> {
  @override
  Widget build(BuildContext context) {
    // final name = ModalRoute.of(context)!.settings.name;

    // // print('name::$name');
    // var uri = Uri.dataFromString(name as String);
    // // print(uri.pathSegments.last);

    // var id = uri.pathSegments.last;

    // var menuCatgeoriesItems = getMenuCategories;

    MenuCatagory? menuCategory = getMenuCategorySingle(widget.id);

    // print('widget.id::${menuCategory!.items.toString()}');

    // if (menuCategory == null) {
    //   return PageError(
    //     errorCode: 404.toString(),
    //     msg: 'Category number $id doesnt exist',
    //   );
    // }

    // List<Menuitem> items = [];

    // var menuItems = getMenuItems;

    // for (var i = 0; i < menuItems.length; i++) {
    //   Menuitem menuItem = menuItems[i];
    //   // print(menuItems[i].categoryId);
    //   if (menuItem.categoryId == menuCategory!.id) {
    //     items.add(menuItem);
    //   }
    // }

    return Scaffold(
      appBar: AppBar(
        title: Text(
          menuCategory!.title!,
          style: TextStyle(color: Colors.black87),
        ),
      ),
      body: menuCategory.items.length == 0
          ? Container(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'No Items in this Category',
                      style: Theme.of(context).textTheme.headline5,
                    ),
                  ],
                ),
              ),
            )
          : Container(
              child: Center(
                child: Container(
                  // color: Colors.amber,
                  padding: EdgeInsets.all(8),
                  constraints: BoxConstraints(
                    maxWidth: 600,
                    minWidth: 320,
                  ),
                  child: Card(
                    child: ListView(
                      shrinkWrap: true,
                      padding: EdgeInsets.all(0),
                      children: List.generate(
                        menuCategory.items.length,
                        (index) {
                          Menuitem item = menuCategory.items[index];
                          print(item.imageUrl);
                          return MenuItemTile(
                            menuItem: item,
                            // onTap: () => GlobalNav.currentState!.pushNamed(
                            //     '/catalog/${item.id}',
                            //     arguments: item),
                          );
                        },
                      ),
                    ),
                  ),
                ),
              ),
            ),
    );
  }
}
