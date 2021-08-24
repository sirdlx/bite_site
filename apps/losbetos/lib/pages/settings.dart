import 'package:flutter/material.dart';
import 'package:losbetos/pages/account.dart';
import 'package:losbetos/state.dart';
import 'package:provider/provider.dart';

// Turned off
class PageSettings extends StatelessWidget {
  const PageSettings({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AppState app = context.watch<AppState>();

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Card(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: ListView(
              shrinkWrap: true,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 16.0, bottom: 16.0),
                  child: ProfileHeader(
                    title: 'Settings',
                  ),
                ),
                ListView(
                  shrinkWrap: true,
                  // itemExtent: 60,
                  children: [
                    ListTile(
                      title: Text('Dark mode'),
                      trailing: Switch(
                        value: app.useDark,
                        onChanged: (value) => app.useDark = !app.useDark,
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
  }
}
