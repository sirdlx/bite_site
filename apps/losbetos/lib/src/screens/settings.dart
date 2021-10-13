import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:losbetosapp/main.dart';
import 'package:losbetosapp/src/screens/profile.dart';

// Turned off
class ScreenSettings extends StatelessWidget {
  const ScreenSettings({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, watch, _) {
      var app = settingsController;
      return Scaffold(
        appBar: AppBar(
          title: const Text('Settings'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Card(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: ListView(
                shrinkWrap: true,
                children: [
                  const ProfileHeader(
                    title: 'Theme',
                  ),
                  ListView(
                    shrinkWrap: true,
                    // itemExtent: 60,
                    children: [
                      CheckboxListTile(
                        title: const Text('System'),
                        // activeColor: Theme.of(context).toggleButtonsTheme.color,
                        value: app.themeMode == ThemeMode.system,
                        onChanged: (value) =>
                            app.updateThemeMode(ThemeMode.system),
                      ),
                      CheckboxListTile(
                        title: const Text('Light'),
                        // activeColor: Theme.of(context).toggleButtonsTheme.color,
                        value: app.themeMode == ThemeMode.light,
                        onChanged: (value) =>
                            app.updateThemeMode(ThemeMode.light),
                      ),
                      CheckboxListTile(
                        title: const Text('Dark'),
                        // activeColor: Theme.of(context).toggleButtonsTheme.color,
                        value: app.themeMode == ThemeMode.dark,
                        onChanged: (value) =>
                            app.updateThemeMode(ThemeMode.dark),
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
