import 'package:flutter/material.dart';
import 'package:flutter_remix/flutter_remix.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:losbetosapp/src/features/auth/auth_service.dart';
import 'package:losbetosapp/src/screens/profile.dart';

import 'package:losbetosapp/src/screens/signup.dart';

import 'login.dart';

class ScreenAccount extends StatefulWidget {
  const ScreenAccount({Key? key}) : super(key: key);

  @override
  State<ScreenAccount> createState() => _ScreenAccountState();
}

class _ScreenAccountState extends State<ScreenAccount> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(
    BuildContext context,
  ) {
    return Consumer(
      builder: (context, ref, child) {
        var auth = ref.watch(authControllerProvider);
        // print('auth.user?.isAnonymous::${auth.user?.isAnonymous}');
        if (auth.user == null) {
          return const Center(child: CircularProgressIndicator());
        } else if (auth.user!.isAnonymous == false) {
          return ScreenProfile(auth: auth);
        } else {
          return Scaffold(body: ScreenAccountPicker(auth: auth));
        }
      },
    );
  }
}

class ScreenAccountPicker extends StatelessWidget {
  final LBAuthNotifier auth;

  const ScreenAccountPicker({Key? key, required this.auth}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        margin: const EdgeInsets.all(16),
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
                    (states) => Colors.white70),
              ),
              icon: const Icon(FlutterRemix.mail_fill),
              onPressed: () => showDialog(
                context: context,
                builder: (context) => LoginScreenV2(
                  auth: auth,
                ),
              ),
              label: const Text('Email'),
            ),
            ElevatedButton.icon(
              style: ButtonStyle(
                backgroundColor:
                    MaterialStateProperty.resolveWith((states) => Colors.red),
              ),
              icon: const Icon(FlutterRemix.google_fill),
              onPressed: () => {},
              label: const Text('Google'),
            ),
            ElevatedButton.icon(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.resolveWith(
                    (states) => Colors.blueAccent),
              ),
              icon: const Icon(FlutterRemix.facebook_box_fill),
              onPressed: () => {},
              label: const Text('Facebook'),
            ),
          ],
        ),
      ),
    );
  }
}

class LoginScreenV2 extends StatelessWidget {
  final LBAuthNotifier auth;

  const LoginScreenV2({Key? key, required this.auth}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: 0,
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          // backgroundColor: Theme.of(context).secondaryHeaderColor,
          elevation: 0,
          bottom: const TabBar(
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
            constraints: BoxConstraints(maxHeight: 600),
            child: Padding(
              padding: const EdgeInsets.all(0.0),
              child: Padding(
                padding: const EdgeInsets.all(0.0),
                child: TabBarView(
                  children: [
                    Container(
                      margin: const EdgeInsets.all(16),
                      child: LoginScreen(
                        auth: auth,
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.all(16),
                      child: SignupScreen(
                        auth: auth,
                      ),
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
