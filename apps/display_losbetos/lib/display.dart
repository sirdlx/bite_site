import 'package:display_losbetos/main.dart';
import 'package:display_losbetos/menu/_functions.dart';
import 'package:display_losbetos/menu_items.dart';
import 'package:flavor_dartis/flavor_dartis.dart';
import 'package:flutter/material.dart';

class DisplayApp extends StatefulWidget {
  const DisplayApp({Key? key}) : super(key: key);

  @override
  _DisplayAppState createState() => _DisplayAppState();
}

class _DisplayAppState extends State<DisplayApp> {
  @override
  void initState() {
    init();
    super.initState();
  }

  void init() {
    pubsub.subscribe(channel: 'display');
  }

  int selected = 1;

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    if (pubsub == null) {
      print('null');
    }

    return SafeArea(
      child: StreamBuilder(
          stream: pubsub.stream,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Scaffold(
                backgroundColor: Colors.black,
                body: Center(
                  child: FittedBox(
                    fit: BoxFit.fitHeight,
                    child: Text('Loading...',
                        style: Theme.of(context).textTheme.headline1!),
                  ),
                ),
              );
            }

            print(snapshot.data);
            if (snapshot.data is MessageEvent) {
              var message = snapshot.data as MessageEvent;
              selected = int.parse(message.message);
            }

            return Scaffold(
              // backgroundColor: Colors.greenAccent.shade200,
              // backgroundColor: Colors.black,
              body: Stack(
                fit: StackFit.expand,
                children: [
                  Center(
                    child: AspectRatio(
                      aspectRatio: 16 / 9,
                      child: Card(
                        color: Colors.transparent,
                        elevation: 0,
                        clipBehavior: Clip.antiAliasWithSaveLayer,
                        child: Row(
                          children: [
                            Flexible(
                              flex: 1,
                              child: Card(
                                elevation: 0,
                                clipBehavior: Clip.antiAliasWithSaveLayer,
                                child: Padding(
                                  padding: const EdgeInsets.all(16.0),
                                  child: Row(
                                    children: [
                                      SlotSpecialCurrent(selected: selected),
                                      SlotSpecialList(selected: selected),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            Flexible(
                              flex: 1,
                              child: LayoutBuilder(
                                builder: (context, size) {
                                  var columnsLen = 3;
                                  var rowSize = size.maxWidth / columnsLen;

                                  return Card(
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Row(
                                        children: List.generate(
                                          columnsLen,
                                          (index) => Expanded(
                                            child: Container(
                                              margin:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 8),
                                              padding: const EdgeInsets.all(0),
                                              constraints:
                                                  const BoxConstraints.expand(),
                                              // color: Colors.amber,
                                              child: Wrap(
                                                alignment: WrapAlignment.start,
                                                runAlignment:
                                                    WrapAlignment.start,
                                                children: [
                                                  FittedBox(
                                                    fit: BoxFit.fitHeight,
                                                    child: Text(
                                                      '${getMenuCategories[index].title}',
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .headline4!,
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: 16,
                                                    width: size.maxWidth,
                                                  ),
                                                  ...List.generate(
                                                    getMenuCategories[1]
                                                        .items
                                                        .length,
                                                    (index) {
                                                      return Container(
                                                        margin: const EdgeInsets
                                                            .symmetric(
                                                          vertical: 0,
                                                        ),
                                                        child: Card(
                                                          elevation: 0,
                                                          clipBehavior: Clip
                                                              .antiAliasWithSaveLayer,
                                                          shape: RoundedRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          12)),
                                                          child: Container(
                                                            color: index % 2 ==
                                                                    0
                                                                ? Colors.white
                                                                    .withOpacity(
                                                                    .035,
                                                                  )
                                                                : Colors
                                                                    .transparent,
                                                            width:
                                                                double.infinity,
                                                            child: Column(
                                                              children: [
                                                                getMenuCategories[1]
                                                                            .items[index]
                                                                            .imageUrl ==
                                                                        null
                                                                    ? Container()
                                                                    : AspectRatio(
                                                                        child:
                                                                            Container(
                                                                          color:
                                                                              Colors.red,
                                                                          // child: Image
                                                                          //     .asset(
                                                                          //   getMenuCategories[
                                                                          //           1]
                                                                          //       .items[
                                                                          //           index]
                                                                          //       .imageUrl!,
                                                                          // ),
                                                                          child:
                                                                              Image.asset(
                                                                            getMenuCategories[1].items[index].imageUrl!,
                                                                            fit:
                                                                                BoxFit.fitWidth,
                                                                          ),
                                                                        ),
                                                                        aspectRatio:
                                                                            3,
                                                                      ),
                                                                Padding(
                                                                  padding:
                                                                      const EdgeInsets
                                                                          .symmetric(
                                                                    horizontal:
                                                                        12,
                                                                    vertical:
                                                                        12,
                                                                  ),
                                                                  child: Row(
                                                                    children: [
                                                                      Expanded(
                                                                        child:
                                                                            Column(
                                                                          mainAxisAlignment:
                                                                              MainAxisAlignment.start,
                                                                          crossAxisAlignment:
                                                                              CrossAxisAlignment.start,
                                                                          children: [
                                                                            Text('${getMenuCategories[1].items[index].title}'),
                                                                            Text(
                                                                              '${getMenuCategories[1].items[index].description}',
                                                                              style: Theme.of(context).textTheme.caption,
                                                                            )
                                                                          ],
                                                                        ),
                                                                      ),
                                                                      Flexible(
                                                                        flex: 0,
                                                                        child:
                                                                            Container(
                                                                          // color: Colors.red,
                                                                          child:
                                                                              Text(
                                                                            '\$19.99',
                                                                            style:
                                                                                Theme.of(context).textTheme.caption,
                                                                          ),
                                                                        ),
                                                                      )
                                                                    ],
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        ),
                                                      );
                                                    },
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          }),
    );
  }
}

class SlotSpecialList extends StatelessWidget {
  const SlotSpecialList({
    Key? key,
    required this.selected,
  }) : super(key: key);

  final int selected;

  @override
  Widget build(BuildContext context) {
    return Flexible(
      flex: 1,
      child: LayoutBuilder(builder: (context, size) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: List.generate(
            displayItems.length,
            (index) => DisplayMenuItemTile(
              // selected: selected == index,
              size: size,
              leading: FittedBox(
                fit: BoxFit.fitHeight,
                child: Text(
                  '#${index + 1}',
                  style: Theme.of(context).textTheme.headline4!,
                ),
              ),
              title: FittedBox(
                fit: BoxFit.fitHeight,
                child: Text(
                  '${displayItems[index].title}',
                  style: Theme.of(context).textTheme.headline4!,
                ),
              ),
              trailing: FittedBox(
                fit: BoxFit.fitHeight,
                child: Text(
                  '\$${displayItems[index].basePrice}',
                  style: Theme.of(context).textTheme.headline4!,
                ),
              ),
            ),
          ),
        );
      }),
    );
  }
}

class SlotSpecialCurrent extends StatelessWidget {
  const SlotSpecialCurrent({
    Key? key,
    required this.selected,
  }) : super(key: key);

  final int selected;

  @override
  Widget build(BuildContext context) {
    return Flexible(
      flex: 1,
      child: Container(
        // color: Colors.white.withOpacity(.2),
        color: Colors.transparent,

        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: Image.asset(
                        displayItems[selected].imageUrl!,
                      ).image,
                    ),
                  ),
                ),
              ),
              Flexible(
                child: Container(
                  // color: Colors.white.withOpacity(.2),
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      FittedBox(
                        fit: BoxFit.fitHeight,
                        child: Text('${displayItems[selected].title}',
                            style: Theme.of(context).textTheme.headline1!),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          FittedBox(
                            fit: BoxFit.fitHeight,
                            child: Text(
                                '\$${displayItems[selected].basePrice.toString()}',
                                style: Theme.of(context).textTheme.headline3!),
                          ),
                          Text(
                            '\$${displayItems[selected].basePrice.toString()}',
                            style:
                                Theme.of(context).textTheme.headline4!.copyWith(
                                      fontSize: 30,
                                      decoration: TextDecoration.lineThrough,
                                    ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 32,
              )
            ],
          ),
        ),
      ),
    );
  }
}

class DisplayMenuItemTile extends StatelessWidget {
  final BoxConstraints size;
  const DisplayMenuItemTile({
    Key? key,
    this.selected = false,
    required this.size,
    this.title,
    this.leading,
    this.trailing,
  }) : super(key: key);

  final bool selected;

  final Widget? title;
  final Widget? leading;
  final Widget? trailing;

  @override
  Widget build(BuildContext context) {
    return Container(
      // margin: EdgeInsets.all(8),
      // padding: const EdgeInsets.all(8),
      height: size.maxHeight / displayItems.length,
      width: size.maxWidth,
      color: selected ? Colors.greenAccent.shade400.withOpacity(1) : null,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            flex: 1,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                // color: Colors.amber,
                child: leading,
              ),
            ),
          ),
          Expanded(
            flex: 4,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: title,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              // color: Colors.red,
              child: trailing,
            ),
          ),
        ],
      ),
    );
  }
}
