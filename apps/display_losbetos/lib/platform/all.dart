import 'package:display_losbetos/main.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

launchAll() async {
  runApp(WebApp());
}

class WebApp extends StatefulWidget {
  const WebApp({Key? key}) : super(key: key);

  @override
  _WebAppState createState() => _WebAppState();
}

class _WebAppState extends State<WebApp> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: init(),
      builder: (context, snapshot) {
        print(snapshot.connectionState);
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const MaterialApp(
            debugShowCheckedModeBanner: false,
            home: Scaffold(
              body: Center(
                child: Text('loading...'),
              ),
            ),
          );
        }
        if (snapshot.error != null) {
          var msg = snapshot.error;

          print(snapshot.error);
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            home: Scaffold(
              body: Center(
                child: Column(
                  children: [
                    Text(msg.toString()),
                    ElevatedButton(
                      onPressed: () {},
                      child: const Text('Close'),
                    ),

                    // Text(msg.toString()),
                  ],
                ),
              ),
            ),
          );
        }

        return const MyApp();
      },
    );
  }
}
