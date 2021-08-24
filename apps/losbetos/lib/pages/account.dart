import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flavor_auth/flavor_auth.dart';
import 'package:flavor_client/pages/onboarding/onboarding_v3.dart';
import 'package:flavor_client/repository/firestore.dart';
import 'package:flutter/material.dart';
import 'package:losbetos/state.dart';
import 'package:provider/provider.dart';

class PageAccount extends StatefulWidget {
  const PageAccount({Key? key}) : super(key: key);

  @override
  _PageAccountState createState() => _PageAccountState();
}

class _PageAccountState extends State<PageAccount> {
  @override
  Widget build(BuildContext context) {
    var app = context.watch<AppState>();

    return Scaffold(
      body: app.user != null
          ? buildProfile(app)
          : Center(
              child: Container(
                margin: EdgeInsets.only(bottom: 16),
                child: OutlinedButton.icon(
                  icon: Icon(Icons.login),
                  label: Text('Sign in'),
                  onPressed: () => showDialog(
                    context: context,
                    builder: (context) =>
                        Scaffold(appBar: AppBar(), body: PageLogin()),
                  ),
                ),
              ),
            ),
    );
  }

  Widget buildProfile(AppState app) {
    var displayName = TextEditingController(
      text: app.user!.displayName ?? '',
    );

    var email = TextEditingController(
      text: app.user!.displayName ?? '',
    );

    var phone = TextEditingController(
      text: app.user!.displayName ?? '',
    );

    String userDocPath = 'users/${app.user!.email}';
    return SingleChildScrollView(
      child: Container(
        margin: EdgeInsets.all(16),
        child: Center(
          child: Card(
            child: Container(
              padding: EdgeInsets.all(16),
              constraints: BoxConstraints(
                minWidth: 320,
                maxWidth: 600,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Personal info
                  app.user != null
                      ? Padding(
                          padding:
                              const EdgeInsets.only(top: 0.0, bottom: 16.0),
                          child: ProfileHeader(
                            title: 'Personal Info',
                          ),
                        )
                      : Container(),

                  app.user != null
                      ? ListView(
                          shrinkWrap: true,
                          itemExtent: 60,
                          children: [
                            AccountTextFeild(
                              labelText: 'Name',
                              controller: displayName,
                              onChanged: (dn) {
                                FirebaseAuth.instance.currentUser!
                                    .updateDisplayName(dn);
                              },
                            ),
                            AccountTextFeild(
                              labelText: 'Email',
                              controller: TextEditingController(),
                              onChanged: (dn) => FirebaseAuth
                                  .instance.currentUser!
                                  .updateEmail(dn),
                            ),
                            AccountTextFeild(
                              labelText: 'Phone',
                              controller: TextEditingController(),
                              onChanged: (dn) => FlavorFirestoreRepository()
                                  .firestore
                                  .doc(userDocPath)
                                  .set({'phone': dn}),
                            ),
                          ],
                        )
                      : Container(),

                  OutlinedButton.icon(
                    icon: Icon(Icons.exit_to_app),
                    label: Text('Logout'),
                    onPressed: () => app.logoutUser(),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class ProfileHeader extends StatelessWidget {
  final String title;

  const ProfileHeader({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      // color: Colors.red,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Flexible(
            child: Text(
              '$title',
              style: Theme.of(context)
                  .textTheme
                  .headline6!
                  .copyWith(fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }
}

class AccountTextFeild extends StatelessWidget {
  final String? labelText;
  final TextEditingController? controller;

  final void Function(String)? onChanged;
  const AccountTextFeild({
    Key? key,
    this.labelText,
    this.controller,
    required this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      cursorRadius: Radius.circular(16.0),
      cursorWidth: 1.0,
      keyboardType: TextInputType.emailAddress,
      // textInputAction: TextInputAction.continueAction,
      decoration: InputDecoration(
        labelText: labelText,
        isDense: true,
      ),
      onChanged: onChanged,
    );
  }
}

class PageLogin extends StatelessWidget {
  const PageLogin({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var app = context.read<AppState>();
    return FlavorOnboardingV3(
      gApiKey: 'AIzaSyDaGm_f6SvznyHIQnPHk7s4V2UygStMb6g',
      isLoggedIn: app.user != null,
      onEmailLogin: (email, password) => FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password)
          .then(
        (value) {
          print('hee');
          return app.user = FlavorUser(
            displayName: value.user!.displayName,
            email: value.user!.email,
            emailVerified: value.user!.emailVerified,
            localId: value.user!.uid,
            photoUrl: value.user!.photoURL,
          );
        },
      ).then((value) => GlobalNav.currentState!.pop()),
      // .then((value) => GlobalNav.currentState!.popAndPushNamed('/')),
      // onEmailLogin: (email, password) {
      //   print('$email, $password');
      //   return Future.value();
      // },
      onEmailSignup: (email, password, passwordReEnter) => FirebaseAuth.instance
          .createUserWithEmailAndPassword(
        email: email,
        password: password,
      )
          .then((value) {
        print(value);
        return app.user = FlavorUser(
          displayName: value.user!.displayName,
          email: value.user!.email,
          emailVerified: value.user!.emailVerified,
          localId: value.user!.uid,
          photoUrl: value.user!.photoURL,
        );
      }).then((value) => GlobalNav.currentState!.popAndPushNamed('/')),
    );
  }
}
