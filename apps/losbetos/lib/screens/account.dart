import 'package:flutter/material.dart';
import 'package:flutter_remix/flutter_remix.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:losbetos/screens/profile.dart';
import 'package:losbetos/screens/signup.dart';
import 'package:losbetos/state/state.dart';
import 'package:provider/provider.dart' as Provider;

import 'login.dart';

class ScreenAccount extends StatefulWidget {
  @override
  _ScreenAccountState createState() => _ScreenAccountState();
}

class _ScreenAccountState extends State<ScreenAccount> {
  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, watch, _) {
      var app = context.watch<AppState>();

      return GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus!.unfocus(),
        child: Scaffold(
            body: Stack(
          fit: StackFit.expand,
          children: [
            app.user != null ? ScreenProfile() : ScreenAccountPicker(),
          ],
        )),
      );
    });
  }
}

class ScreenAccountPicker extends StatelessWidget {
  const ScreenAccountPicker({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, watch, _) {
      var app = context.watch<AppState>();

      return SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.all(16),
          height: 260,
          width: 300,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                'Choose your account',
                style: Theme.of(context).textTheme.headline6,
              ),
              ElevatedButton.icon(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.resolveWith(
                      (states) => Colors.green),
                ),
                icon: Icon(FlutterRemix.mail_fill),
                onPressed: () => showDialog(
                  context: context,
                  builder: (context) => LoginScreenV2(),
                ),
                label: Text('Email'),
              ),
              ElevatedButton.icon(
                style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.resolveWith((states) => Colors.red),
                ),
                icon: Icon(FlutterRemix.google_fill),
                onPressed: () => showDialog(
                  context: context,
                  builder: (context) => LoginScreenV2(),
                ),
                label: Text('Google'),
              ),
              ElevatedButton.icon(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.resolveWith(
                      (states) => Colors.blueAccent),
                ),
                icon: Icon(FlutterRemix.facebook_box_fill),
                onPressed: () => showDialog(
                  context: context,
                  builder: (context) => LoginScreenV2(),
                ),
                label: Container(
                  child: Text('Facebook'),
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}

class LoginScreenV2 extends StatelessWidget {
  const LoginScreenV2({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: 0,
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          // backgroundColor: Theme.of(context).secondaryHeaderColor,
          elevation: 0,
          bottom: TabBar(
            tabs: [
              Tab(
                // icon: Icon(Icons.directions_car),
                text: 'Login',
              ),
              Tab(
                // icon: Icon(Icons.directions_transit),
                text: 'Sign Up',
              ),
            ],
          ),
        ),
        body: SingleChildScrollView(
          child: Container(
            constraints: BoxConstraints(maxHeight: 500),
            child: Padding(
              padding: const EdgeInsets.all(0.0),
              child: Padding(
                padding: const EdgeInsets.all(0.0),
                child: TabBarView(
                  children: [
                    Container(
                      margin: EdgeInsets.all(16),
                      child: LoginScreen(),
                    ),
                    Container(
                      margin: EdgeInsets.all(16),
                      child: SignupScreen(),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
