import 'package:flutter/material.dart';
import 'package:flutter_remix/flutter_remix.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:losbetosapp/main.dart';
import 'package:losbetosapp/src/screens/settings.dart';
import 'package:losbetosapp/src/themes/light.dart';

PreferredSizeWidget homeAppBarOLD(BuildContext context) => AppBar(
      // backgroundColor: Colors.transparent,
      elevation: 0,
      actions: [
        IconButton(
          onPressed: () {
            settingsController.globalNavKey.currentState!.pushNamed('/login');
          },
          icon: const Icon(Icons.person),
        ),
      ],
    );

AppBar homeAppBar(BuildContext context) {
  return AppBar(
    backgroundColor: Colors.transparent,
    elevation: 0,
    leading: IconButton(
      icon: SvgPicture.asset("assets/icons/menu.svg"),
      onPressed: () {
        settingsController.homeScaffoldKey.currentState!.openDrawer();
      },
    ),
    title: Row(
      children: [
        const Icon(
          FlutterRemix.cactus_fill,
          color: Colors.greenAccent,
        ),
        RichText(
          text: TextSpan(
            style: Theme.of(context)
                .textTheme
                .headline6!
                .copyWith(fontWeight: FontWeight.bold),
            children: [
              const TextSpan(
                text: "Los",
              ),
              TextSpan(
                text: "Betos",
                style: TextStyle(color: lbThemeLight.primaryColor),
              ),
            ],
          ),
        ),
      ],
    ),
    actions: <Widget>[
      IconButton(
        color: Colors.grey,
        icon: const Icon(
          FlutterRemix.settings_2_line,
        ),
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) => Scaffold(
              body: const ScreenSettings(),
              appBar: AppBar(),
            ),
          );
        },
      ),
      const SizedBox(
        width: 12,
      )
    ],
  );
}
