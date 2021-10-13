import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_remix/flutter_remix.dart';
import 'package:losbetosapp/components/textField.dart';
import 'package:losbetosapp/src/config/paths.dart';
import 'package:losbetosapp/src/features/auth/auth_hookwidget.dart';
import 'package:losbetosapp/src/features/auth/auth_repo.dart';
import 'package:provider/provider.dart';

class ScreenProfile extends StatelessWidget {
  const ScreenProfile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AuthHookWidget(
      builder: (BuildContext context, User? user, FirebaseAuthRepository auth) {
        var displayName = TextEditingController(
          text: user!.displayName,
        );

        var emailTextEditingController = TextEditingController(
          text: user.email ?? '',
        );

        var phoneTextEditingController = TextEditingController(
          text: user.phoneNumber ?? '',
        );

        // var phone = TextEditingController(
        //   text: user.displayName ?? '',
        // );

        String userDocPath = '${Paths.users}/${user.email}';

        List<LBTextField> _textFields = [
          LBTextField(
            labelText: 'Name',
            controller: displayName,
            onSaved: (dn) {
              FirebaseAuth.instance.currentUser!.updateDisplayName(dn).then(
                    (value) => FirebaseFirestore.instance
                        .doc('$userDocPath')
                        .update({'displayName': dn}).then(
                      (value) => ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Updated Display Name'))),
                    ),
                  );
            },
            onChanged: (String) {},
          ),
          LBTextField(
            labelText: 'Email',
            controller: emailTextEditingController,
            onChanged: (dn) =>
                FirebaseAuth.instance.currentUser!.updateEmail(dn),
          ),
          LBTextField(
            labelText: 'Phone Number',
            controller: TextEditingController(),
            onChanged: (dn) =>
                FirebaseFirestore.instance.doc(userDocPath).set({'phone': dn}),
          ),
        ];
        return SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Container(
              child: Card(
                child: Container(
                  padding: const EdgeInsets.all(16),
                  child: ListView(
                    shrinkWrap: true,
                    children: [
                      ProfileHeader(
                        title: 'Profile',
                      ),
                      Column(
                        children: [
                          ..._textFields,
                        ],
                      ),
                      SizedBox(
                        height: 24,
                      ),
                      Column(
                        children: [
                          ListTile(
                            onTap: () =>
                                Navigator.of(context).pushNamed('/orders'),
                            title: Text('Orders'),
                          ),
                          SizedBox(
                            height: 24,
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 24,
                      ),
                      ElevatedButton.icon(
                        onPressed: () {
                          auth.signOut();
                        },
                        icon: Icon(FlutterRemix.logout_box_line),
                        label: Text('Logout'),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
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
