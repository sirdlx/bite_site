import 'package:display_losbetos/menu/_functions.dart';
import 'package:display_losbetos/menu_item_model.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

enum View_Mode {
  main,
  search,
  category,
}

// Column(
//               children: [
//                 SearchBox(
//                   controller: _searchTextController,
//                   onChanged: (value) {
//                     print('value::$value');
//                     setState(() {
//                       _query = value;
//                       // _query = _searchTextController.text;
//                     });
//                   },
//                 ),
//                 const SizedBox(
//                   height: 12,
//                 ),
//                 CategoryList(
//                   selected: selectedCategory,
//                   onPressed: (mi) {
//                     if (selectedCategory?.id == mi.id) {
//                       setState(() {
//                         selectedCategory = null;
//                       });
//                     } else {
//                       setState(() {
//                         selectedCategory = mi;
//                       });
//                     }
//                   },
//                 ),
//               ],
//             ),

// LBPopular

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
                Icons.search,
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
        // child: ListView(
        //     shrinkWrap: true,
        //     padding: const EdgeInsets.all(0),
        //     children: menuItems.map((item) {
        //       return MenuItemTile(
        //         menuItem: item,
        //         onTap: () => appController.globalNavKey.currentState!
        //             .restorablePushNamed(
        //           '/menu/category/${item.categoryId}/item/${item.id}',
        //         ),
        //       );
        //     }).toList()),
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
            subtitle: const Text('The most commonly ordered items and dishes'),
            trailing: IconButton(
              onPressed: () {},
              icon: const Icon(Icons.arrow_right_alt_rounded),
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
                          // subtitle: toPricingText(e.basePrice),
                          image: e.imageUrl != null
                              ? Image.asset(
                                  e.imageUrl!,
                                  fit: BoxFit.cover,
                                ).image
                              : null,
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

class BiteGridItem extends StatelessWidget {
  final String? subtitle;

  final String? title;

  final ImageProvider? image;

  final void Function()? onPressed;

  final Key? heroKey;

  const BiteGridItem({
    Key? key,
    this.subtitle,
    this.title,
    this.image,
    this.onPressed,
    this.heroKey,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // print('image::$image ');

    if (image == null) {
      return buildBody(context);
    }

    return buildBody(
        context,
        Padding(
          padding: const EdgeInsets.all(.3),
          // child: HeroImage(image: image!),
        ));
  }

  Widget buildBody(BuildContext context, [Widget? child]) {
    return Card(
      clipBehavior: Clip.antiAlias,
      // style: ButtonStyle(
      //   // elevation: MaterialStateProperty.resolveWith((states) => 1),
      //   backgroundColor: MaterialStateProperty.all(
      //     Colors.transparent,
      //   ),
      //   padding: MaterialStateProperty.resolveWith(
      //     (states) => EdgeInsets.all(0),
      //   ),
      // ),
      // onPressed: onPressed,
      child: GestureDetector(
        onTap: onPressed,
        child: GridTile(
          child: child ??
              Container(
                height: double.infinity,
                width: double.infinity,
              ),
          // header: Container(
          //   padding: EdgeInsets.all(8),
          //   // height: 16,
          //   // color: Colors.amber,
          //   child: title != null ? Text(title!) : null,
          // ),
          footer: Material(
            // color: child != null
            //     ? Theme.of(context).canvasColor.withOpacity(.3)
            //     :
            color: Colors.transparent,
            child: Container(
              padding: const EdgeInsets.all(0),
              // child: Column(
              //   mainAxisAlignment: MainAxisAlignment.start,
              //   crossAxisAlignment: CrossAxisAlignment.start,
              //   children: [
              //     Container(
              //       child: title != null
              //           ? Text(
              //               title!,
              //               maxLines: 2,
              //               overflow: TextOverflow.ellipsis,
              //             )
              //           : null,
              //     ),
              //     Row(
              //       children: [
              //         Container(
              //           child: subtitle != null
              //               ? Text(
              //                   subtitle!,
              //                   style: Theme.of(context).textTheme.caption,
              //                 )
              //               : null,
              //         ),
              //       ],
              //     ),
              //   ],
              // ),
              child: ListTile(
                tileColor: Theme.of(context).canvasColor.withOpacity(.3),
                // contentPadding: EdgeInsets.all(0),
                subtitle: subtitle != null ? Text(subtitle!) : null,
                title: title != null
                    ? Text(
                        title!,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      )
                    : null,
              ),
            ),
            // child: ListTile(
            //   // tileColor:
            //   //     // Theme.of(context).brightness == Brightness.light
            //   //     // ?
            //   //     Colors.white
            //   // // : null
            //   // ,
            //   contentPadding: EdgeInsets.all(4),
            //   subtitle: subtitle != null ? Text(subtitle!) : null,
            //   title: title != null ? Text(title!) : null,

            //   // leading: IconButton(
            //   //   onPressed: () {},
            //   //   icon: Icon(
            //   //     Icons.add_shopping_cart_outlined,
            //   //   ),
            //   // ),
            // ),
          ),
          // child: Hero(
          //   tag: ValueKey(image.hashCode),
          //   // child: Container(
          //   //   decoration: BoxDecoration(
          //   //     image: image != null
          //   //         ? DecorationImage(image: image!, fit: BoxFit.cover)
          //   //         : null,
          //   //   ),
          //   // ),
          //   child: image != null
          //       ? Image(image: image!, fit: BoxFit.cover)
          //       : Container(),
          // ),
          // child: Container(
          //   color: Colors.amber,
          //   child: image != null
          //       ?
          //       // Hero(
          //       //     tag: ValueKey(image.hashCode),
          //       //     child:

          //       Image(
          //           image: image!,
          //           // fit: BoxFit.cover,
          //         )
          //       // ,
          //       // )
          //       : Container(),
          // ),
          // child: image != null
          //     ? HeroImage(
          //         image: image!,
          //       )
          //     // : Container(
          //     //     decoration: BoxDecoration(
          //     //       image: DecorationImage(
          //     //         image: image!,
          //     //         fit: BoxFit.cover,
          //     //       ),
          //     //     ),
          //     //   )
          //     : Container(),
        ),
      ),
    );
  }
}
