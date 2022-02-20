import 'package:flavor_ui/flavor_ui.dart' as fui;
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_remix/flutter_remix.dart';

import 'package:losbetosapp/main.dart';
import 'package:losbetosapp/src/features/menu/_functions.dart';
import 'package:losbetosapp/src/features/menu_category/grid_item.dart';
import 'package:losbetosapp/src/features/menu_category/menu_category_view.dart';
import 'package:losbetosapp/src/features/menu_item/menu_item_model.dart';
import 'package:losbetosapp/src/features/menu_item/menu_item_tile.dart';
import 'package:losbetosapp/src/themes/light.dart';
import 'package:losbetosapp/src/utilities/utilities.dart';

enum View_Mode {
  main,
  search,
  category,
}

class LBScreenMenu extends StatefulWidget {
  const LBScreenMenu({Key? key}) : super(key: key);

  @override
  State<LBScreenMenu> createState() => _LBScreenMenuState();
}

class _LBScreenMenuState extends State<LBScreenMenu> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => myFocusNode.hasFocus ? myFocusNode.unfocus() : null,
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size(0, 130),
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children: [
                SearchBox(
                  controller: _searchTextController,
                  onChanged: (value) {
                    print('value::$value');
                    setState(() {
                      _query = value;
                      // _query = _searchTextController.text;
                    });
                  },
                ),
                const SizedBox(
                  height: 12,
                ),
                CategoryList(
                  selected: selectedCategory,
                  onPressed: (mi) {
                    if (selectedCategory?.id == mi.id) {
                      setState(() {
                        selectedCategory = null;
                      });
                    } else {
                      setState(() {
                        selectedCategory = mi;
                      });
                    }
                  },
                ),
              ],
            ),
          ),
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(8),
          controller: _scrollController,
          child: viewMode == View_Mode.search
              ? buildSearchResults()
              : viewMode == View_Mode.category
                  ? ScreenCategory(
                      id: selectedCategory!.id,
                    )
                  : Column(
                      children: const [
                        LBPopularSection(),
                        LBPopularSection(),
                        LBPopularSection(),
                        LBPopularSection(),
                        LBPopularSection(),
                        LBPopularSection(),
                      ],
                    ),
        ),
      ),
    );
  }

  FutureBuilder<dynamic> buildSearchResults() {
    return FutureBuilder<List<Menuitem>>(
      future: Future.delayed(const Duration(milliseconds: 200))
          .then((value) => getMenuItemsAll.where((element) {
                if (element.title!.contains(_query!) ||
                    element.description!.contains(_query!)) {
                  return true;
                }
                return false;
              }).toList()),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done &&
            snapshot.hasData) {
          print('has data::${snapshot.data}');

          return LBSearchResultsView(
            menuItems: snapshot.data!,
          );
        }

        return Container(
          height: 500,
          child: const Center(
            child: CircularProgressIndicator(),
          ),
        );
      },
    );
  }

  MenuCatagory? selectedCategory;

  late FocusNode myFocusNode;

  late ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    myFocusNode = FocusNode();
    _scrollController = ScrollController();
  }

  @override
  void dispose() {
    // Clean up the focus node when the Form is disposed.
    myFocusNode.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  String? _query;

  final TextEditingController _searchTextController = TextEditingController();

  View_Mode get viewMode {
    if (_query != null && _query!.isNotEmpty) {
      return View_Mode.search;
    }

    if (selectedCategory != null) {
      return View_Mode.category;
    }
    return View_Mode.main;
  }
}

class SearchBox extends StatelessWidget {
  const SearchBox({
    Key? key,
    this.onChanged,
    this.controller,
  }) : super(key: key);
  final void Function(String value)? onChanged;
  final TextEditingController? controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      // height: 60,
      // margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      // padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
            color: Theme.of(context).shadowColor.withOpacity(.07), width: .5),
      ),
      clipBehavior: Clip.antiAlias,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(
            width: 16,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: GestureDetector(
              onTap: () => FocusManager.instance.rootScope.requestFocus(),
              child: const Icon(
                FlutterRemix.search_line,
                size: 16,
              ),
              // child: SvgPicture.asset("assets/icons/search.svg"),
            ),
          ),
          const SizedBox(
            width: 4,
          ),
          Expanded(
            child: TextField(
              onChanged: onChanged,
              controller: controller,
              decoration: InputDecoration(
                border: InputBorder.none,
                // icon: GestureDetector(
                //   onTap: () => FocusManager.instance.rootScope.requestFocus(),
                //   child: SvgPicture.asset("assets/icons/search.svg"),
                // ),

                hintText: "Search",
                // hintStyle: TextStyle(color: Theme.of(context).primaryColor),
                suffix: GestureDetector(
                  onTap: () {
                    controller?.text = '';
                    // _query = '';
                  },
                  child: Icon(
                    Icons.close,
                    color: lbThemeLight.primaryColor,
                    size: 16,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class CategoryList extends StatelessWidget {
  final MenuCatagory? selected;
  const CategoryList({
    Key? key,
    this.selected,
    this.onPressed,
  }) : super(key: key);

  final void Function(MenuCatagory item)? onPressed;
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: getMenuCategories.map((item) {
          return CategoryItem(
            title: item.title!,
            isActive: item.id == selected?.id,
            press: onPressed != null ? () => onPressed!(item) : null,
          );
        }).toList(),
      ),
    );
  }
}

class CategoryItem extends StatelessWidget {
  final String title;
  final bool isActive;
  final void Function()? press;
  const CategoryItem({
    Key? key,
    required this.title,
    this.isActive = false,
    this.press,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: press,
      child: Card(
        color: isActive ? lbThemeLight.primaryColor : null,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
          child: Column(
            children: <Widget>[
              Text(
                title,
                // style: isActive
                //     ? const TextStyle(
                //         // fontWeight: FontWeight.bold,
                //         // color: lbThemeLight.primaryColor,
                //         )
                //     : const TextStyle(
                //         // fontSize: 12,
                //         ),
              ),
              // Container(
              //   margin: const EdgeInsets.symmetric(vertical: 5),
              //   height: 3,
              //   width: 116,
              //   decoration: isActive
              //       ? BoxDecoration(
              //           color: lbThemeLight.primaryColor,
              //           borderRadius: BorderRadius.circular(10),
              //         )
              //       : null,
              // ),
            ],
          ),
        ),
      ),
    );
  }
}

class ItemList extends StatelessWidget {
  const ItemList({
    Key? key,
    this.menuItems,
  }) : super(key: key);

  final List<Menuitem>? menuItems;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: <Widget>[
          ItemCard(
            // svgSrc: "assets/icons/burger_beer.svg",
            title: "Burger & Beer",
            shopName: "MacDonald's",
            // press: () {},
          ),
          ItemCard(
            // svgSrc: "assets/icons/chinese_noodles.svg",
            title: "Chinese & Noodles",
            shopName: "Wendys",
            // press: () {},
          ),
          ItemCard(
            // svgSrc: "assets/icons/burger_beer.svg",
            title: "Burger & Beer",
            shopName: "MacDonald's",
            // press: () {},
          ),
          ItemCard(
            // svgSrc: "assets/icons/burger_beer.svg",
            title: "Burger & Beer",
            shopName: "MacDonald's",
            // press: () {},
          ),
          ItemCard(
            // svgSrc: "assets/icons/burger_beer.svg",
            title: "Burger & Beer",
            shopName: "MacDonald's",
            // press: () {},
          ),
          ItemCard(
            // svgSrc: "assets/icons/burger_beer.svg",
            title: "Burger & Beer",
            shopName: "MacDonald's",
            // press: () {},
          ),
          ItemCard(
            // svgSrc: "assets/icons/burger_beer.svg",
            title: "Burger & Beer",
            shopName: "MacDonald's",
            // press: () {},
          )
        ],
      ),
    );
  }
}

class ItemCard extends StatelessWidget {
  final String? title, shopName;
  final void Function()? onPressed;
  final ImageProvider? image;

  const ItemCard({
    Key? key,
    this.title,
    this.shopName,
    this.image,
    this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // This size provide you the total height and width of the screen
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: const EdgeInsets.all(4),
      child: Card(
        child: Material(
          // color: Colors.transparent,
          child: InkWell(
            onTap: onPressed,
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: <Widget>[
                  Container(
                    margin: const EdgeInsets.only(bottom: 15),
                    padding: const EdgeInsets.all(25),
                    decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor.withOpacity(0.13),
                      shape: BoxShape.circle,
                    ),
                    // child: SvgPicture.asset(
                    //   svgSrc,
                    //   width: size.width * 0.18,
                    //   // size.width * 0.18 means it use 18% of total width
                    // ),
                  ),
                  title != null ? Text(title!) : Container(),
                  title != null ? const SizedBox(height: 10) : Container(),
                  const Text(
                    'shopName',
                    style: TextStyle(fontSize: 12),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class LBSearchResultsView extends StatelessWidget {
  const LBSearchResultsView({Key? key, required this.menuItems})
      : super(key: key);
  final List<Menuitem> menuItems;
  @override
  Widget build(BuildContext context) {
    if (menuItems == null) {
      return Container();
    }

    return Container(
      constraints: const BoxConstraints(
        // maxWidth: 360,
        minWidth: 320,
      ),
      child: Card(
        elevation: 2,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        clipBehavior: Clip.antiAlias,
        child: ListView(
            shrinkWrap: true,
            padding: const EdgeInsets.all(0),
            children: menuItems.map((item) {
              return MenuItemTile(
                menuItem: item,
                onTap: () => appController.globalNavKey.currentState!
                    .restorablePushNamed(
                  '/menu/category/${item.categoryId}/item/${item.id}',
                ),
              );
            }).toList()),
      ),
    );
    // return Card(
    //   child: Column(
    //     // children: menuItems
    //     //     .map(
    //     //       (e) => ItemCard(
    //     //         // svgSrc: "assets/icons/burger_beer.svg",
    //     //         title: "Burger & Beer",
    //     //         shopName: "MacDonald's",
    //     //         // press: () {},
    //     //       ),
    //     //     )
    //     //     .toList(),

    //     children: menuItems
    //         .map(
    //           (e) => SizedBox(
    //             height: 100,
    //             child: BiteGridItem(
    //               title: e.title,
    //               subtitle: toPricingText(e.basePrice),
    //               image: e.imageUrl != null
    //                   ? Image.asset(
    //                       e.imageUrl!,
    //                       fit: BoxFit.cover,
    //                     ).image
    //                   : null,
    //               onPressed: () => appController.globalNavKey.currentState!
    //                   .pushNamed('/menu/category/${e.categoryId}/item/${e.id}'),
    //             ),
    //           ),
    //         )
    //         .toList(),
    //   ),
    // );
  }
}

// getMenuItemsAll().where((e) {
//                 if (e.title!.toLowerCase().contains(_query) ||
//                     e.description!.toLowerCase().contains(_query)) {
//                   return true;
//                 }
//                 return false;
//               }).toList()

//               List<Menuitem> menuItems
//     if (menuItems.length == 0) {
//       return Container(
//         child: Center(
//           child: Text('no items from results : "$_query" '),
//         ),
//       );
//     }

//     for (var i = 0; i < menuItems.length; i++) {
//       if (sections.containsKey(menuItems[i].categoryId)) {
//         sections[menuItems[i].categoryId!.toLowerCase().toString()]!
//             .add(menuItems[i]);
//       } else {
//         sections
//             .putIfAbsent(
//                 menuItems[i].categoryId!.toLowerCase().toString(), () => [])
//             .add(menuItems[i]);
//       }
//     }

class LBPopularSection extends StatelessWidget {
  const LBPopularSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return fui.ResponsiveView(
      global: false,
      breakpoints: {
        fui.DisplayType.s: AspectRatio(
          aspectRatio: 1.1,
          child: buildBody(context),
        ),
        fui.DisplayType.m: AspectRatio(
          aspectRatio: 1.7,
          child: buildBody(context),
        ),
        fui.DisplayType.l: AspectRatio(
          aspectRatio: 2.5,
          child: buildBody(context),
        ),
        fui.DisplayType.xl: AspectRatio(
          aspectRatio: 6,
          child: buildBody(context),
        ),
      },
    );
  }

  Card buildBody(BuildContext context) {
    return Card(
      // color: Theme.of(context).scaffoldBackgroundColor,
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Padding(
        padding: const EdgeInsets.only(top: 4.0, bottom: 8, left: 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ListTile(
              contentPadding: const EdgeInsets.symmetric(horizontal: 8),
              title: Text(
                'Popular',
                style: Theme.of(context).textTheme.headline5,
              ),
              subtitle:
                  const Text('The most commonly ordered items and dishes'),
              trailing: IconButton(
                onPressed: () {},
                icon: const Icon(FlutterRemix.arrow_right_circle_line),
              ),
            ),
            Flexible(
              flex: 1,
              child: ListView(
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                children: getMenuItemsAll
                    .map(
                      (e) => AspectRatio(
                        aspectRatio: 1,
                        child: Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: BiteGridItem(
                            title: e.title,
                            subtitle: toPricingText(e.basePrice),
                            image: e.imageUrl != null
                                ? Image.asset(
                                    e.imageUrl!,
                                    fit: BoxFit.cover,
                                  ).image
                                : null,
                            onPressed: () => appController
                                .globalNavKey.currentState!
                                .pushNamed(
                                    '/menu/category/${e.categoryId}/item/${e.id}'),
                          ),
                        ),
                      ),
                    )
                    .toList()
                    .getRange(5, 20)
                    .take(6)
                    .toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
