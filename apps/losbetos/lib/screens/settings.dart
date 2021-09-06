import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:losbetos/screens/account.dart';
import 'package:losbetos/state/state.dart';
import 'package:provider/provider.dart' as Provider;

// Turned off
class ScreenSettings extends StatelessWidget {
  const ScreenSettings({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, watch, _) {
      var app = context.watch<AppState>();
      return Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(6.0),
          child: Material(
            elevation: 1,
            color: Theme.of(context).cardColor,
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
    });
  }
}
