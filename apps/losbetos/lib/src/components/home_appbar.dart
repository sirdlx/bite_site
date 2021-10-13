import 'package:flutter/material.dart';
import 'package:losbetosapp/main.dart';

PreferredSizeWidget homeAppBar(BuildContext context) => AppBar(
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
