import 'package:flutter/material.dart';
import 'package:losbetosapp/main.dart';
import 'package:losbetosapp/src/features/menu/_functions.dart';
import 'package:losbetosapp/src/features/menu_item/menu_item_model.dart';
import 'package:losbetosapp/src/features/menu_item/menu_item_tile.dart';

class ScreenCategory extends StatefulWidget {
  final String id;
  const ScreenCategory({
    Key? key,
    required this.id,
  }) : super(key: key);

  @override
  _ScreenCategoryState createState() => _ScreenCategoryState();
}

class _ScreenCategoryState extends State<ScreenCategory> {
  @override
  Widget build(BuildContext context) {
    MenuCatagory? menuCategory = getMenuCategorySingle(widget.id);
    return menuCategory!.items.isEmpty
        ? Center(
            child: Text(
              'No Items in this Category',
              style: Theme.of(context).textTheme.headline5,
            ),
          )
        : Container(
            // color: Colors.amber,
            padding: const EdgeInsets.all(8),
            constraints: const BoxConstraints(
              // maxWidth: 360,
              minWidth: 320,
            ),
            child: Card(
              elevation: 2,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),
              clipBehavior: Clip.antiAlias,
              child: ListView(
                shrinkWrap: true,
                // padding: EdgeInsets.all(0),
                children: List.generate(
                  menuCategory.items.length,
                  (index) {
                    Menuitem item = menuCategory.items[index];
                    // print(item.imageUrl);
                    return MenuItemTile(
                      menuItem: item,
                      onTap: () =>
                          appController.globalNavKey.currentState!.pushNamed(
                        '/menu/category/${item.categoryId}/item/${item.id}',
                        arguments: item,
                      ),
                    );
                  },
                ),
              ),
            ),
          );
  }
}
