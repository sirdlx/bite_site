import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_remix/flutter_remix.dart';
import 'package:losbetos/components/textField.dart';
import 'package:losbetos/state/state.dart';
import 'package:provider/provider.dart';

class ScreenProfile extends StatelessWidget {
  const ScreenProfile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var app = context.read<AppState>();

    var displayName = TextEditingController(
      text: app.user!.displayName ?? '',
    );

    var emailTextEditingController = TextEditingController(
      text: app.user!.email ?? '',
    );

    var phoneTextEditingController = TextEditingController(
      text: app.user!.phoneNumber ?? '',
    );

    // var phone = TextEditingController(
    //   text: app.user!.displayName ?? '',
    // );

    String userDocPath = 'users/${app.user!.email}';

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
        onChanged: (dn) => FirebaseAuth.instance.currentUser!.updateEmail(dn),
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
                        onTap: () => Navigator.of(context).pushNamed('/orders'),
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
                      app.logoutUser();
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
