import 'package:flutter/material.dart';
import 'package:losbetosapp/components/grid_item.dart';
import 'package:losbetosapp/models/menu/_functions.dart';

class CategoryGrid extends StatelessWidget {
  final ScrollController? scrollController;

  const CategoryGrid({
    Key? key,
    this.scrollController,
    // this.crossAxisCount = 2,
    // this.childAspectRatio = 16 / 9,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Card(
        child: Container(
          padding: const EdgeInsets.all(8),
          child: Column(
            children: [
              ListTile(
                contentPadding: const EdgeInsets.all(0),
                title: Text(
                  'Categories',
                  style: Theme.of(context).textTheme.headline5,
                ),
                // trailing: IconButton(
                //   onPressed: () {},
                //   icon: Icon(Icons.arrow_right_alt_outlined),
                // ),
              ),
              // FlavorResponsiveView(
              //   breakpoints: {
              //     DisplayType.s: buildGrid(),
              //     DisplayType.m: buildGrid(crossAxisCount: 3),
              //     DisplayType.l: buildGrid(crossAxisCount: 4),
              //     DisplayType.xl: buildGrid(crossAxisCount: 6),
              //   },
              // ),
              buildGrid(),
            ],
          ),
        ),
      ),
    );
  }

  GridView buildGrid(
      {final int crossAxisCount = 2, final double childAspectRatio = 16 / 9}) {
    return GridView(
      padding: const EdgeInsets.all(0),
      controller: scrollController,
      shrinkWrap: true,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: crossAxisCount,
        crossAxisSpacing: 8,
        mainAxisSpacing: 8,
        childAspectRatio: childAspectRatio,
      ),
      children: getMenuCategories
          .map(
            (e) => BiteGridItem(
              title: e.title,
              image: e.imageUrl != null
                  ? Image.asset(
                      e.imageUrl!,
                      fit: BoxFit.cover,
                    ).image
                  : null,
              // onPressed: () => GlobalNav.currentState!.pushNamed(
              //   '/menu/category/${e.id}',
              //   arguments: e,
              // ),
            ),
          )
          .toList(),
    );
  }
}
