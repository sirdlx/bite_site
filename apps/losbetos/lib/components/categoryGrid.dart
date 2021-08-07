import 'package:flutter/material.dart';
import 'package:losbetos/components/gridItem.dart';
import 'package:losbetos/models/menu02/_functions.dart';
import 'package:losbetos/state.dart';

class CategoryGrid extends StatelessWidget {
  final ScrollController _scrollController;

  const CategoryGrid({
    Key? key,
    required ScrollController scrollController,
  })  : _scrollController = scrollController,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: EdgeInsets.symmetric(horizontal: 16),
      sliver: SliverToBoxAdapter(
        child: Column(
          children: [
            ListTile(
              contentPadding: EdgeInsets.all(0),
              title: Text(
                'Categories',
                style: Theme.of(context).textTheme.headline5,
              ),
              trailing: IconButton(
                onPressed: () {},
                icon: Icon(Icons.arrow_right_alt_outlined),
              ),
            ),
            GridView(
              controller: _scrollController,
              shrinkWrap: true,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                childAspectRatio: 16 / 9,
              ),
              children: getMenuCategories
                  .map(
                    (e) => Container(
                      // height: 10,
                      // color: Colors.amber,
                      // padding: EdgeInsets.all(0),
                      child: BiteGridItem(
                        title: e.title,
                        image: e.imageUrl != null
                            ? Image.asset(
                                e.imageUrl!,
                                fit: BoxFit.cover,
                              ).image
                            : null,
                        onPressed: () => GlobalNav.currentState!.pushNamed(
                          '/menu/category/${e.id}',
                          arguments: e,
                        ),
                      ),
                    ),
                  )
                  .toList(),
            )
          ],
        ),
      ),
    );
  }
}
