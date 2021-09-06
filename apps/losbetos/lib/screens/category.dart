import 'package:flutter/material.dart';
import 'package:losbetos/components/menuItemTile.dart';
import 'package:losbetos/models/menu/_functions.dart';
import 'package:losbetos/models/models.dart';

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
                          // print(item.imageUrl);
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
