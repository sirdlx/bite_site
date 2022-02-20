import 'dart:async';
import 'dart:io';

import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:display_losbetos/config.dart';
import 'package:display_losbetos/home.dart';
import 'package:display_losbetos/platform/all.dart';
import 'package:flavor_dartis/flavor_dartis.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_acrylic/flutter_acrylic.dart';

import 'package:display_losbetos/controller.dart';
import 'package:display_losbetos/display.dart';

late final PubSub pubsub;

late final Client client;

late final Commands commands;
// ignore: prefer_typing_uninitialized_variables
late final win;

var redisPath = 'redis://${Env.redisHost}:${Env.redisPort}';
Future<bool> init() async {
  client = await Client.connect(redisPath);
  pubsub = await PubSub.connect<String, String>(redisPath);
  commands = client.asCommands<String, String>();
  return true;
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // await windowManager.ensureInitialized();

  if (kIsWeb) {
    // await launchWindows();
    await launchAll();
  }

  // windowManager.waitUntilReadyToShow().then((_) async {
  //   // Set to frameless window
  //   // await windowManager.setAsFrameless();
  //   await windowManager.setSize(const Size(600, 600));
  //   await windowManager.setPosition(Offset.zero);
  //   windowManager.show();
  // });
}

Future<void> launchWindows() async {
  await Window.initialize();
  Color color =
      Platform.isWindows ? const Color(0x00222222) : Colors.transparent;

  Window.setEffect(
    effect: WindowEffect.mica,
    color: color,
    dark: true,
  );

  doWhenWindowReady(() {
    win = appWindow;

    // final initialSize = Size(600, 450);
    // win.minSize = initialSize;
    // win.size = initialSize;
    // win.alignment = Alignment.center;
    win.title = "DisplayApp";
    win.show();
  });

  runApp(
    FutureBuilder(
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
                      onPressed: () {
                        exit(0);
                      },
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
    ),
  );
}

class AddScrollBehavior extends ScrollBehavior {
  // Override behavior methods and getters like dragDevices
  @override
  Set<PointerDeviceKind> get dragDevices => {
        PointerDeviceKind.touch,
        PointerDeviceKind.mouse,
      };
}

final backgroundStartColor = Colors.greenAccent.shade700;
final backgroundEndColor = Colors.black.withOpacity(.35);

class AppShell extends StatefulWidget {
  final Widget? child;

  const AppShell({
    Key? key,
    required this.child,
  }) : super(key: key);

  @override
  State<AppShell> createState() => _AppShellState();
}

class _AppShellState extends State<AppShell> {
  bool fullscreenMode = false;

  onKey(RawKeyEvent key) {
    print(key is RawKeyUpEvent);
    // print(mode);

    if (key.physicalKey == PhysicalKeyboardKey.escape && key is RawKeyUpEvent) {
      toggleFullscreen();
    }
    // return true;
  }

  toggleFullscreen() async {
    // print(fullscreenMode);

    setState(() {
      // windowManager.setFullScreen(!mode);
      fullscreenMode == false
          ? Window.enterFullscreen()
          : Window.exitFullscreen();
      fullscreenMode = !fullscreenMode;
    });
  }

  @override
  Widget build(BuildContext context) {
    return RawKeyboardListener(
      focusNode: FocusNode(),
      autofocus: true,
      onKey: (value) => onKey(value),
      child: Material(
        child: Container(
          decoration: BoxDecoration(
              // gradient: fullscreenMode == false
              //     ? LinearGradient(
              //         begin: Alignment.topCenter,
              //         end: Alignment.bottomCenter,
              //         colors: [backgroundStartColor, backgroundEndColor],
              //         stops: const [0.0, 1.0],
              //       )
              //     : null,
              // color: Theme.of(context).canvasColor,
              // color: Color(0x000b091a),
              ),
          child: Column(
            children: [
              // WindowTitleBarBox(
              //   child: Row(
              //     children: [
              //       Expanded(child: MoveWindow()),
              //       WindowButtons(toggleFullscreen: toggleFullscreen),
              //     ],
              //   ),
              // ),
              WindowTitleBarBox(
                child: Row(
                  children: [
                    Expanded(child: MoveWindow()),
                    WindowButtons(toggleFullscreen: toggleFullscreen),
                  ],
                ),
              ),
              widget.child != null
                  ? Expanded(child: widget.child!)
                  : Container(),
            ],
          ),
        ),
      ),
    );
  }
}

final buttonColors = WindowButtonColors(
  iconNormal: Colors.white,
  mouseOver: Colors.greenAccent.shade400,
  mouseDown: Colors.greenAccent.shade400,
  iconMouseOver: Colors.white,
  iconMouseDown: Colors.black38,
);

final closeButtonColors = WindowButtonColors(
  mouseOver: const Color(0xFFD32F2F),
  mouseDown: const Color(0xFFB71C1C),
  iconNormal: Colors.white,
  iconMouseOver: Colors.white,
);

class WindowButtons extends StatelessWidget {
  void Function()? toggleFullscreen;
  WindowButtons({
    Key? key,
    this.toggleFullscreen,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        MaterialButton(
            minWidth: 0,
            onPressed: toggleFullscreen,
            child: const Center(
                child: Icon(
              Icons.fullscreen_outlined,
            ))),

        // MaterialButton(
        //     minWidth: 0,
        //     onPressed: () {},
        //     child: const Center(
        //         child: Icon(
        //       Icons.minimize_rounded,
        //     ))),

        // MaterialButton(
        //     minWidth: 0,
        //     onPressed: toggleFullscreen,
        //     child: const Center(
        //         child: Icon(
        //       Icons.maximize_outlined,
        //     ))),

        // MaterialButton(
        //     minWidth: 0,
        //     onPressed: toggleFullscreen,
        //     child: const Center(
        //         child: Icon(
        //       Icons.close_rounded,
        //     ))),
        MinimizeWindowButton(colors: buttonColors),
        MaximizeWindowButton(colors: buttonColors),
        CloseWindowButton(colors: closeButtonColors),
      ],
    );
  }
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      themeMode: ThemeMode.dark,
      title: 'Display - LosBetos',
      debugShowCheckedModeBanner: false,
      scrollBehavior: AddScrollBehavior(),
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      darkTheme: ThemeData.dark().copyWith(
        primaryColor: Colors.greenAccent.shade700,
        scaffoldBackgroundColor: Colors.transparent,
        cardColor: Colors.transparent,
        canvasColor: Colors.black,
      ),
      home: const MyHomePage(),
      builder: (context, child) => AppShell(child: child),
      routes: {
        "/display": (c) => const DisplayApp(),
        "/controller": (c) => const ControllerApp(),
      },
    );
  }
}
