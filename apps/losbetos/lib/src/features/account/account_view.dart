import 'package:flutter/material.dart';
import 'package:flutter_remix/flutter_remix.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:losbetosapp/src/components/card_section.dart';
import 'package:losbetosapp/src/features/auth/auth_controller.dart';
import 'package:losbetosapp/src/features/account/profile.dart';

import 'package:losbetosapp/src/features/account/signup.dart';

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
          return ScreenAccountPicker(auth: auth);
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
    return Scaffold(
      body: Container(
        child: Center(
          child: SizedBox(
            width: 300,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CardSection(
                    headerText: 'Choose your account',
                    children: [
                      ListTile(
                        tileColor: Colors.white70,
                        leading: const Icon(FlutterRemix.mail_fill),
                        onTap: () => showDialog(
                          context: context,
                          builder: (context) => LoginScreenV2(
                            auth: auth,
                          ),
                        ),
                        title: const Text('Email'),
                      ),
                      ListTile(
                        tileColor: Colors.red,
                        leading: const Icon(FlutterRemix.google_fill),
                        onTap: () => showDialog(
                          context: context,
                          builder: (context) => LoginScreenV2(
                            auth: auth,
                          ),
                        ),
                        title: const Text('Google'),
                      ),
                      ListTile(
                        tileColor: Colors.blueAccent,
                        leading: const Icon(FlutterRemix.facebook_box_fill),
                        onTap: () => showDialog(
                          context: context,
                          builder: (context) => LoginScreenV2(
                            auth: auth,
                          ),
                        ),
                        title: const Text('Facebook'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
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
