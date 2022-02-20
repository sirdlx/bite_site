import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({
    Key? key,
  }) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Displays',
          style: Theme.of(context).textTheme.headline2,
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: 300,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                const SizedBox(
                  width: 32,
                ),
                AspectRatio(
                  aspectRatio: 1,
                  child: MaterialButton(
                    height: 200,
                    minWidth: 200,
                    onPressed: () {
                      Navigator.of(context).restorablePushNamed('/display');
                    },
                    child: Text('Speacials Menu'),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ListTile(
              title: Text(
                'Display',
                style: Theme.of(context).textTheme.headline4,
              ),
              onTap: () {
                Navigator.of(context).restorablePushNamed('/display');
              },
            ),
            ListTile(
              title: Text(
                'Controller',
                style: Theme.of(context).textTheme.headline4,
              ),
              onTap: () {
                Navigator.of(context).restorablePushNamed('/controller');
              },
            )
          ],
        ),
      ),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: _incrementCounter,
      //   tooltip: 'Increment',
      //   child: const Icon(Icons.add),
      // ),
    );
  }
}
