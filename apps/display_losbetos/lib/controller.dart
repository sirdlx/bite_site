import 'package:display_losbetos/main.dart';
import 'package:display_losbetos/menu_items.dart';
import 'package:flutter/material.dart';

class ControllerApp extends StatefulWidget {
  const ControllerApp({Key? key}) : super(key: key);

  @override
  _ControllerAppState createState() => _ControllerAppState();
}

class _ControllerAppState extends State<ControllerApp> {
  @override
  void initState() {
    init();
    super.initState();
  }

  void init() {
    pubsub.subscribe(channel: 'display');
  }

  int? selected;

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

          return Scaffold(
            // backgroundColor: Colors.greenAccent.shade200,
            // backgroundColor: Colors.black,
            appBar: AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0,
              title: const Text('Controller'),
            ),
            body: ListView(
              children: List.generate(
                displayItems.length,
                (index) => ListTile(
                  onTap: () {
                    commands.publish('display', index.toString());
                  },
                  selected: selected == index,
                  // leading: Container(
                  //   color: Colors.red,
                  // ),
                  title: Text(
                    '${displayItems[index].title}',
                    // style: Theme.of(context).textTheme.headline1!,
                  ),
                  // trailing: Container(
                  //   color: Colors.red,
                  // ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
