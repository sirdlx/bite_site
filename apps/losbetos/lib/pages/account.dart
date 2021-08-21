import 'package:flavor_auth/flavor_auth.dart';
import 'package:flavor_client/components/list.dart';
import 'package:flavor_client/components/refactor_components.dart';
import 'package:flavor_client/components/tiles.dart';
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
    var app = context.read<AppState>();

    return Scaffold(
      body: buildProfile(app),
    );
  }

  SingleChildScrollView buildProfile(AppState app) {
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

                  Padding(
                    padding: const EdgeInsets.only(top: 0.0, bottom: 16.0),
                    child: ProfileHeader(
                      title: 'Personal Info',
                    ),
                  ),

                  ListView(
                    shrinkWrap: true,
                    itemExtent: 60,
                    children: [
                      AccountTextFeild(
                        labelText: 'Name',
                        controller: TextEditingController(),
                      ),
                      AccountTextFeild(
                        labelText: 'Email',
                        controller: TextEditingController(),
                      ),
                      AccountTextFeild(
                        labelText: 'Phone',
                        controller: TextEditingController(),
                      ),
                    ],
                  ),

                  Padding(
                    padding: const EdgeInsets.only(top: 16.0, bottom: 16.0),
                    child: ProfileHeader(
                      title: 'Settings',
                    ),
                  ),

                  ListView(
                    shrinkWrap: true,
                    itemExtent: 60,
                    children: [
                      ListTile(
                        title: Text('Use dark mode'),
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
  const AccountTextFeild({
    Key? key,
    this.labelText,
    this.controller,
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
    );
  }
}
