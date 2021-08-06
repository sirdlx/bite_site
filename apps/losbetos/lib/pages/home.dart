import 'package:flutter/material.dart';
import 'package:losbetos/components/gridItem.dart';

final ScrollController _sc = ScrollController();
final Key homeScaffoldKey = ValueKey('scaffold');

class BiteSiteHomeBody extends StatelessWidget {
  const BiteSiteHomeBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: homeScaffoldKey,
      body: Container(
        child: SingleChildScrollView(
          controller: _sc,
          child: ListView.builder(
            padding: EdgeInsets.all(16),
            controller: _sc,
            shrinkWrap: true,
            itemCount: 3,
            itemBuilder: (context, index) {
              if (index == 0) {
                return AspectRatio(
                  aspectRatio: 1,
                  child: Container(
                    // height: 200,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ListTile(
                          contentPadding: EdgeInsets.all(0),
                          title: Text(
                            'Popular',
                            style: Theme.of(context).textTheme.headline5,
                          ),
                          trailing: IconButton(
                            onPressed: () {},
                            icon: Icon(Icons.arrow_right_alt_outlined),
                          ),
                        ),
                        Flexible(
                          flex: 1,
                          child: ListView(
                            shrinkWrap: true,
                            controller: _sc,
                            scrollDirection: Axis.horizontal,
                            children: [],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }
              if (index == 1) {
                return GridView.builder(
                  shrinkWrap: true,
                  itemCount: 4,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 8,
                    mainAxisSpacing: 8,
                  ),
                  itemBuilder: (context, index) {
                    return BiteGridItem();
                  },
                );
              }
              return Container(
                height: 300,
                margin: EdgeInsets.all(8),
                child: Material(
                  elevation: 8,
                  color: Colors.orangeAccent,
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
