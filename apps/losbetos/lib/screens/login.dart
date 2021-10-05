import 'package:flutter/material.dart';
import 'package:losbetos/state/state.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  static final String id = 'login_screen';

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  String? _email = "losbetosllc@gmail.com", _password = "Rocky0813!";

  @override
  Widget build(BuildContext context) {
    var app = context.read<AppState>();

    _submit() {
      if (_formKey.currentState!.validate()) {
        _formKey.currentState!.save();
        // Logging in the user w/ Firebase
        app.login(_email!, _password!).then((value) {
          if (value == false) {
            return;
          }

          Navigator.of(context).pop();
        }).onError((error, stackTrace) {
          // print('error::$error');
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text('$error')));
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
                initialValue: _password,
                decoration: InputDecoration(labelText: 'Password'),
                validator: (input) =>
                    input!.length < 6 ? 'Must be at least 6 characters' : null,
                onSaved: (input) => _password = input!,
                obscureText: true,
              ),
            ),
            SizedBox(height: 20.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(
                  onPressed: _submit,
                  child: Text(
                    'Forgot Password?',
                  ),
                ),
                ElevatedButton(
                  onPressed: _submit,
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
  }
}
