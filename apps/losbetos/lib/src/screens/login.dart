import 'package:firebase_auth/firebase_auth.dart';
import 'package:flavor_auth/flavor_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:losbetosapp/src/features/auth/auth_controller.dart';
import 'package:losbetosapp/src/features/auth/auth_hookwidget.dart';
import 'package:losbetosapp/src/features/auth/auth_repo.dart';
import 'package:losbetosapp/src/features/auth/auth_service.dart';

class LoginScreen extends StatefulWidget {
  static const String id = 'login_screen';
  final LBAuthNotifier auth;
  const LoginScreen({
    Key? key,
    required this.auth,
  }) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();

  String? _password = "Rocky0813!";

  FlavorUser user = FlavorUser(email: 'sirwhite@dlxstudios.com');
  bool _busy = false;

  @override
  Widget build(BuildContext context) {
    _submit() async {
      if (_formKey.currentState!.validate()) {
        setState(() {
          _busy = true;
        });
        await Future.delayed(const Duration(seconds: 0));

        _formKey.currentState!.save();
        // Logging in the user w/ Firebase
        await widget.auth
            .logInWithEmailAndPassword(email: user.email!, password: _password!)
            .then((value) {
          Navigator.of(context).pop();
        }).onError((error, stackTrace) {
          // print('error::$error');
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text('$error')));
          setState(() {
            _busy = false;
          });
        });

        // app.signInUser();
      }
    }

    return Scaffold(
      body: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 10.0,
              ),
              child: TextFormField(
                enabled: !_busy,
                initialValue: user.email,
                decoration: const InputDecoration(labelText: 'Email'),
                validator: (input) {
                  return input == null || input.isEmpty || !input.contains('@')
                      ? 'Please enter a valid email'
                      : null;
                },
                onSaved: (input) => user = user.copyWith(email: input),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 10.0,
              ),
              child: TextFormField(
                enabled: !_busy,
                initialValue: _password,
                decoration: const InputDecoration(labelText: 'Password'),
                validator: (input) =>
                    input!.length < 6 ? 'Must be at least 6 characters' : null,
                onFieldSubmitted: (input) => _password = input,
                obscureText: true,
              ),
            ),
            const SizedBox(height: 20.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(
                  onPressed: !_busy ? _submit : null,
                  child: const Text(
                    'Forgot Password?',
                  ),
                ),
                ElevatedButton(
                  onPressed: !_busy ? _submit : null,
                  child: const Text(
                    'Login',
                  ),
                ),
              ],
            ),

            // SizedBox(height: 20.0),
            // ElevatedButton(
            //   onPressed: () => Navigator.pushNamed(context, SignupScreen.id),
            //   child: Text(
            //     'Sign up',
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
