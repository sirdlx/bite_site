import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:losbetosapp/main.dart';
import 'package:losbetosapp/src/screens/profile.dart';
import 'package:provider/provider.dart' as Provider;

// Turned off
class ScreenSettings extends StatelessWidget {
  const ScreenSettings({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, watch, _) {
      var app = settingsController;
      return Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Card(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: ListView(
                shrinkWrap: true,
                children: [
                  ProfileHeader(
                    title: 'Settings',
                  ),
                  ListView(
                    shrinkWrap: true,
                    // itemExtent: 60,
                    children: [
                      ListTile(
                        title: Text('Dark mode'),
                        trailing: CupertinoSwitch(
                          activeColor:
                              Theme.of(context).toggleButtonsTheme.color,
                          value: app.themeMode == ThemeMode.light,
                          onChanged: (value) => app.updateThemeMode(
                              app.themeMode == ThemeMode.light
                                  ? ThemeMode.dark
                                  : ThemeMode.light),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    });
  }
}
