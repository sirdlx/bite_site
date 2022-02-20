import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flavor_auth/flavor_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_remix/flutter_remix.dart';
import 'package:losbetosapp/src/components/card_section.dart';

import 'package:losbetosapp/src/config/paths.dart';
import 'package:losbetosapp/src/features/auth/auth_controller.dart';
import 'package:losbetosapp/src/utilities/text_field.dart';

class ScreenProfile extends StatelessWidget {
  final LBAuthNotifier auth;
  const ScreenProfile({Key? key, required this.auth}) : super(key: key);

  String userDocPath(FlavorUser user) => '${Paths.users}/${user.email}';

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
      stream:
          FirebaseFirestore.instance.doc(userDocPath(auth.user!)).snapshots(),
      builder: (context, snapshot) {
        // print(snapshot.data?.data());

        if (snapshot.data == null) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        var user = FlavorUser.fromMap(snapshot.data!.data()!);

        return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            actions: [
              Row(
                children: [
                  Text('Logout'),
                  IconButton(
                    onPressed: () {
                      auth.repo.signOut();
                    },
                    icon: const Icon(
                      FlutterRemix.logout_box_line,
                      size: 14,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                width: 20,
              ),
            ],
          ),
          body: SingleChildScrollView(
            controller: ScrollController(),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  buildProfileSection(
                      context, user, auth.repo.getCurrentUser()!),
                  buildOrderSection(context, user, {}),
                  // buildLogoutButton(),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  CardSection buildOrderSection(
    BuildContext context,
    FlavorUser user,
    Map<String, dynamic> orders,
  ) {
    return CardSection(
      headerTrailing: IconButton(
        onPressed: () => Navigator.of(context).pushNamed('/orders'),
        icon: const Icon(FlutterRemix.arrow_right_circle_line),
      ),
      headerText: 'Orders',
      children: <Widget>[
        ListTile(
          onTap: () => Navigator.of(context).pushNamed('/orders/1'),
          title: const Text('Order 1'),
          subtitle: const Text('Order 1'),
        ),
        ListTile(
          tileColor: Colors.red,
          onTap: () => Navigator.of(context).pushNamed('/orders/2'),
          title: const Text('Orders 2'),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Text('\$19.99'),
              Text('October 5th, 2021'),
              Text('October 5th, 2021'),
            ],
          ),
          isThreeLine: true,
        ),
      ],
    );
  }

  CardSection buildProfileSection(
      BuildContext context, FlavorUser fuser, User user) {
    var displayNameTextEditingController = TextEditingController(
      text: fuser.displayName,
    );

    var emailTextEditingController = TextEditingController(
      text: user.email ?? '',
    );
    // ignore: unused_local_variable
    var phoneTextEditingController = TextEditingController(
      text: fuser.phoneNumber ?? '',
    );

    List<Widget> _textFields = [
      ListTile(
        title: LBTextField(
          labelText: 'Name',
          controller: displayNameTextEditingController,
          // initialValue: auth.user?.displayName,

          onFieldSubmitted: (dn) async {
            await auth.repo
                .getCurrentUser()!
                .updateDisplayName(dn)
                .then((value) => print('updated name'));
            await FirebaseFirestore.instance
                .doc(userDocPath(fuser))
                .update({'display_name': dn});
            ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Updated Display Name')));
          },
        ),
      ),
      ListTile(
        title: LBTextField(
          labelText: 'Email',
          controller: emailTextEditingController,
          onFieldSubmitted: (dn) async {
            await auth.repo.getCurrentUser()!.updateEmail(dn);
            await FirebaseFirestore.instance
                .doc(userDocPath(fuser))
                .update({'email': dn});
          },
        ),
      ),
      ListTile(
        title: LBTextField(
          labelText: 'Phone Number',
          controller: phoneTextEditingController,
          onFieldSubmitted: (dn) async {
            await FirebaseFirestore.instance
                .doc(userDocPath(fuser))
                .update({'phone_number': dn});
            // await FirebaseAuth.instance.currentUser?.updatePhoneNumber(PhoneAuthCredential);
          },
        ),
      ),
    ];

    return CardSection(
      headerText: 'Profile',
      children: <Widget>[
        Form(
          child: Column(
            children: [
              ..._textFields,
            ],
          ),
        ),
      ],
    );
  }

  ElevatedButton buildLogoutButton() {
    return ElevatedButton.icon(
      onPressed: () {
        auth.repo.signOut();
      },
      icon: const Icon(
        FlutterRemix.logout_box_line,
        size: 14,
      ),
      label: const Text('Logout'),
    );
  }
}
