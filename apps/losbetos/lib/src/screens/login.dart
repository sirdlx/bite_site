import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:losbetosapp/src/features/auth/auth_controller.dart';
import 'package:losbetosapp/src/features/auth/auth_hookwidget.dart';
import 'package:losbetosapp/src/features/auth/auth_repo.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  static final String id = 'login_screen';

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  String? _email = "losbetosllc@gmail.com", _password = "Rocky0813!";
  bool _busy = false;

  @override
  Widget build(BuildContext context) {
    return AuthHookWidget(
      builder: (BuildContext context, User? user, FirebaseAuthRepository auth) {
        _submit() async {
          if (_formKey.currentState!.validate()) {
            setState(() {
              _busy = true;
            });
            await Future.delayed(Duration(seconds: 1));

            _formKey.currentState!.save();
            // Logging in the user w/ Firebase
            await auth.logInWithEmailAndPassword(
                email: _email!, password: _password!);
            // await user.(_email!, _password!).then((value) {
            //   if (value == false) {
            //     return;
            //   }

            //   Navigator.of(context).pop();
            // }).onError((error, stackTrace) {
            //   // print('error::$error');
            //   ScaffoldMessenger.of(context)
            //       .showSnackBar(SnackBar(content: Text('$error')));
            // });

            setState(() {
              _busy = false;
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
                  padding: EdgeInsets.symmetric(
                    vertical: 10.0,
                  ),
                  child: TextFormField(
                    enabled: !_busy,
                    initialValue: _email,
                    decoration: InputDecoration(labelText: 'Email'),
                    validator: (input) {
                      return input == null ||
                              input.length < 1 ||
                              !input.contains('@')
                          ? 'Please enter a valid email'
                          : null;
                    },
                    onSaved: (input) => _email = input!,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: 10.0,
                  ),
                  child: TextFormField(
                    enabled: !_busy,
                    initialValue: _password,
                    decoration: InputDecoration(labelText: 'Password'),
                    validator: (input) => input!.length < 6
                        ? 'Must be at least 6 characters'
                        : null,
                    onSaved: (input) => _password = input!,
                    obscureText: true,
                  ),
                ),
                SizedBox(height: 20.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextButton(
                      onPressed: !_busy ? _submit : null,
                      child: Text(
                        'Forgot Password?',
                      ),
                    ),
                    ElevatedButton(
                      onPressed: !_busy ? _submit : null,
                      child: Text(
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
      },
    );
  }
}
