import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:losbetosapp/main.dart';
import 'package:losbetosapp/src/components/card_section.dart';

// Turned off
class ScreenSettings extends StatelessWidget {
  const ScreenSettings({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              CardSection(
                children: [
                  CheckboxListTile(
                    title: const Text('System'),
                    // activeColor: Theme.of(context).toggleButtonsTheme.color,
                    value: settingsController.themeMode == ThemeMode.system,
                    onChanged: (value) =>
                        settingsController.updateThemeMode(ThemeMode.system),
                  ),
                  CheckboxListTile(
                    title: const Text('Light'),
                    // activeColor: Theme.of(context).toggleButtonsTheme.color,
                    value: settingsController.themeMode == ThemeMode.light,
                    onChanged: (value) =>
                        settingsController.updateThemeMode(ThemeMode.light),
                  ),
                  CheckboxListTile(
                    title: const Text('Dark'),
                    // activeColor: Theme.of(context).toggleButtonsTheme.color,
                    value: settingsController.themeMode == ThemeMode.dark,
                    onChanged: (value) =>
                        settingsController.updateThemeMode(ThemeMode.dark),
                  ),
                ],
                headerText: 'Theme',
              ),
            ],
          ),
        ),
      ),
      // appBar: AppBar(
      //   title: const Text('Settings'),
      // ),
      // body: Padding(
      //   padding: const EdgeInsets.all(24.0),
      //   child: CardSection(
      //     headerText: '',
      //     headerTrailing: Container(),
      //     children: [
      //
      //     ],
      //   ),
      // ),
    );
  }
}
