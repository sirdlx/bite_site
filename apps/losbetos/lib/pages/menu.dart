import 'package:flavor/layout/FlavorResponsiveView.dart';
import 'package:flavor/layout/adaptive.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:losbetos/components/categoryGrid.dart';
import 'package:losbetos/components/gridItem.dart';
import 'package:losbetos/components/menuItemTile.dart';
import 'package:losbetos/models/menu02/_functions.dart';
import 'package:losbetos/models/models.dart';
import 'package:losbetos/state.dart';
import 'package:losbetos/utilities.dart';

class PageMenu extends StatefulWidget {
  const PageMenu({Key? key}) : super(key: key);

  @override
  _PageSearchState createState() => _PageSearchState();
}

enum View_Mode {
  main,
  search,
  category,
}

class _PageSearchState extends State<PageMenu> {
  String _query = '';

  final TextEditingController _textController = TextEditingController();

  final _scrollController = ScrollController();

  String? selectedCategory;

  View_Mode get viewMode {
    if (_query.length > 0) {
      return View_Mode.search;
    }

    if (selectedCategory != null) {
      return View_Mode.category;
    }
    return View_Mode.main;
  }

  @override
  Widget build(BuildContext context) {
    // print(selectedCategory);
    return SafeArea(
      child: Scaffold(
        body: CustomScrollView(
          controller: _scrollController,
          // shrinkWrap: true,
          slivers: [
            buildSearchAppBar(context),

            viewMode == View_Mode.search
                ? buildSearchResults()
                : SliverToBoxAdapter(),
            // //
            // //
            // //
            // //
            viewMode == View_Mode.category
                ? FutureBuilder<MenuCatagory?>(
                    future: Future.delayed(Duration(milliseconds: 0)).then(
                        (value) => Future.value(
                            getMenuCategorySingle(selectedCategory!))),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.done) {
                        // print(snapshot.data!.items.length.toString());

                        if (snapshot.data!.items.length > 0) {
                          return buildMenuItemListCategory(
                              context, snapshot.data!);
                        }

                        if (snapshot.data!.items.length == 0) {
                          return SliverToBoxAdapter(
                            child: AspectRatio(
                              aspectRatio: 1,
                              child: Container(
                                // color: Colors.red,
                                child: Center(
                                  child: Text(
                                    ' No Items in this Category today',
                                    style:
                                        Theme.of(context).textTheme.headline5,
                                  ),
                                ),
                              ),
                            ),
                          );
                        }
                      }

                      return SliverToBoxAdapter(
                        child: AspectRatio(
                          aspectRatio: 1,
                          child: Container(
                            // color: Colors.red,
                            height: 500,
                            child: Center(
                              child: CircularProgressIndicator(),
                            ),
                          ),
                        ),
                      );
                    })
                : SliverToBoxAdapter(),
            //
            //
            // Popular Section
            viewMode == View_Mode.main
                ? buildSearchDefaultView(context)
                : SliverToBoxAdapter(),

            // // Category Grid Section

            viewMode == View_Mode.main
                ? CategoryGrid(scrollController: _scrollController)
                : SliverToBoxAdapter(),
          ],
        ),
      ),
    );
  }

  SliverPadding buildSearchDefaultView(BuildContext context) {
    return SliverPadding(
      padding: EdgeInsets.symmetric(horizontal: 4),
      sliver: SliverToBoxAdapter(
        child: FlavorResponsiveView(
          global: false,
          breakpoints: {
            DisplayType.s: AspectRatio(
              aspectRatio: kIsWeb ? 2 : 1.6,
              child: buildSection(context),
            ),
            DisplayType.m: AspectRatio(
              aspectRatio: 2.4,
              child: buildSection(context),
            ),
            DisplayType.l: AspectRatio(
              aspectRatio: 2.6,
              child: buildSection(context),
            ),
            DisplayType.xl: AspectRatio(
              aspectRatio: 4.6,
              child: buildSection(context),
            ),
          },
        ),
      ),
    );
  }

  Card buildSection(BuildContext context) {
    return Card(
      child: Container(
        padding: EdgeInsets.all(8),
        // color: Colors.amber,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ListTile(
              contentPadding: EdgeInsets.all(0),
              title: Text(
                'Popular',
                style: Theme.of(context).textTheme.headline5,
              ),
              subtitle: Text('The most commonly ordered items and dishes'),
              trailing: IconButton(
                onPressed: () {},
                icon: Icon(Icons.arrow_right_alt_outlined),
              ),
            ),
            Flexible(
              flex: 1,
              child: ListView(
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                children: getMenuItemsAll()
                    .map(
                      (e) => AspectRatio(
                        aspectRatio: 1.3,
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
                            onPressed: () => GlobalNav.currentState!.pushNamed(
                                '/menu/category/${e.categoryId}/item/${e.id}'),
                          ),
                        ),
                      ),
                    )
                    .toList()
                    .take(4)
                    .toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  FutureBuilder<dynamic> buildSearchResults() {
    return FutureBuilder(
      future: Future.delayed(Duration(milliseconds: 0)),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          // print('has data');

          return buildMenuItemListSearch(
              context,
              getMenuItemsAll().where((e) {
                if (e.title!.toLowerCase().contains(_query) ||
                    e.description!.toLowerCase().contains(_query)) {
                  return true;
                }
                return false;
              }).toList());
        }

        return SliverToBoxAdapter(
          child: Container(
            height: 500,
            child: Center(
              child: CircularProgressIndicator(),
            ),
          ),
        );
      },
    );
  }

  SliverPadding buildMenuItemListCategory(
      BuildContext context, MenuCatagory menuCatagory) {
    return SliverPadding(
      padding: const EdgeInsets.all(16.0),
      sliver: SliverToBoxAdapter(
        child: Card(
          child: Column(
            children: [
              AspectRatio(
                aspectRatio: 4,
                child: Container(
                  decoration: menuCatagory.imageUrl != null
                      ? BoxDecoration(
                          image: DecorationImage(
                            image: Image.asset(menuCatagory.imageUrl!).image,
                            fit: BoxFit.cover,
                            alignment: Alignment.center,
                          ),
                        )
                      : null,
                ),
              ),
              ...menuCatagory.items.map((e) => MenuItemTile(menuItem: e)),
            ],
          ),
        ),
      ),
    );
  }

  SliverPadding buildMenuItemListSearch(
      BuildContext context, List<Menuitem> menuItems) {
    Map<String, List> sections = {};

    // print('menuItems.length::${menuItems.length}');

    if (menuItems.length == 0) {
      return SliverPadding(
        padding: EdgeInsets.all(8),
        sliver: SliverToBoxAdapter(
          child: Container(
            child: Center(
              child: Text('no items from results : "$_query" '),
            ),
          ),
        ),
      );
    }

    for (var i = 0; i < menuItems.length; i++) {
      if (sections.containsKey(menuItems[i].categoryId)) {
        sections[menuItems[i].categoryId!.toLowerCase().toString()]!
            .add(menuItems[i]);
      } else {
        sections
            .putIfAbsent(
                menuItems[i].categoryId!.toLowerCase().toString(), () => [])
            .add(menuItems[i]);
      }
    }

    return SliverPadding(
      padding: const EdgeInsets.all(16.0),
      sliver: SliverToBoxAdapter(
        child: Card(
          child: ListView.builder(
            shrinkWrap: true,
            controller: _scrollController,
            itemBuilder: (context, index) {
              Menuitem item = menuItems[index];
              return MenuItemTile(menuItem: item);
            },
            itemCount: menuItems.length,
          ),
        ),
      ),
    );
  }

  SliverPadding buildSearchAppBar(BuildContext context) {
    return SliverPadding(
      padding: const EdgeInsets.all(8.0),
      sliver: SliverAppBar(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(8))),
        automaticallyImplyLeading: false,
        elevation: 2,
        floating: true,
        bottom:
            // viewMode == View_Mode.main || viewMode == View_Mode.category?
            AppBar(
          automaticallyImplyLeading: false,
          // backgroundColor: Colors.transparent,
          elevation: 0,
          title: viewMode == View_Mode.main || viewMode == View_Mode.category
              ? SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: getMenuCategories.map(
                      (e) {
                        // print(e.id);
                        // return Container();
                        return Container(
                          padding: EdgeInsets.all(4),
                          child: InputChip(
                            showCheckmark: false,
                            elevation: selectedCategory != null &&
                                    selectedCategory == e.id
                                ? 6.5
                                : 1,
                            selected: selectedCategory != null &&
                                selectedCategory == e.id,
                            onSelected: (value) => selectCategory(e.id, value),
                            selectedColor: Theme.of(context).accentColor,
                            label: Text(
                              e.title!,
                              style:
                                  Theme.of(context).textTheme.button!.copyWith(
                                        color: Colors.white,
                                      ),
                            ),
                            // onPressed: () {},
                          ),
                        );
                      },
                    ).toList(),
                  ),
                )
              : viewMode == View_Mode.search
                  ? Container()
                  : null,
        )
        // : null
        ,
        title: TextField(
          controller: _textController,
          // enabled: false,
          enableSuggestions: false,
          maxLines: 1,
          textAlignVertical: TextAlignVertical.bottom,
          autocorrect: true,

          decoration: InputDecoration(
            prefixIcon: Icon(Icons.search_rounded),
            hintText: 'Search',
            isDense: false,
            border: InputBorder.none,
          ),
          // onEditingComplete: () {
          //   setState(() {
          //     _query = _textController.text;
          //   });
          // },

          onChanged: (String value) async {
            setState(() {
              _query = _textController.text;
            });
          },
        ),
        actions: viewMode == View_Mode.search
            ? [
                IconButton(
                  onPressed: () {
                    _textController.text = '';
                    _query = '';
                    setState(() {});
                  },
                  icon: Icon(Icons.close),
                )
              ]
            : [],
      ),
    );
  }

  void selectCategory(String index, bool value) {
    if (value) {
      setState(() {
        selectedCategory = index;
      });
    } else {
      setState(() {
        selectedCategory = null;
      });
    }
  }
}
