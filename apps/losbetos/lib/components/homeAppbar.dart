import 'package:flutter/material.dart';
import 'package:losbetos/state.dart';

PreferredSizeWidget homeAppBar(BuildContext context) => AppBar(
      // backgroundColor: Colors.transparent,
      elevation: 0,
      actions: [
        IconButton(
          onPressed: () {
            GlobalNav.currentState!.pushNamed('/login');
          },
          icon: Icon(Icons.person),
        ),
      ],
    );
