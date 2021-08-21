import 'package:flutter/material.dart';
import 'package:losbetos/state.dart';
import 'package:provider/provider.dart';

class PageSettings extends StatelessWidget {
  const PageSettings({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AppState app = context.watch<AppState>();

    return Scaffold(
      body: ListView(
        children: [
          ListTile(
            title: Text('Use dark mode'),
            trailing: Switch(
              value: app.useDark,
              onChanged: (value) => app.useDark = !app.useDark,
            ),
          ),
          ListTile(
            title: Text('Use dark mode'),
            trailing: Switch(
              value: app.useDark,
              onChanged: (value) => app.useDark = !app.useDark,
            ),
          ),
          ListTile(
            title: Text('Use dark mode'),
            trailing: Switch(
              value: !app.useDark,
              onChanged: (value) => app.useDark = !app.useDark,
            ),
          ),
          ListTile(
            title: Text('Use dark mode'),
            trailing: Switch(
              value: !app.useDark,
              onChanged: (value) => app.useDark = !app.useDark,
            ),
          ),
        ],
      ),
    );
  }
}
