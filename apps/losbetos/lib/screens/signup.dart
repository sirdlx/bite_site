import 'package:flutter/material.dart';
import 'package:losbetos/services/auth.dart';
import 'package:losbetos/state/state.dart';
import 'package:provider/src/provider.dart';

class SignupScreen extends StatefulWidget {
  static final String id = 'signup_screen';

  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _formKey = GlobalKey<FormState>();
  String? _name = 'los betos admin',
      _email = "losbetosllc@gmail.com",
      _password = "Rocky0813!";
  bool _busy = false;

  @override
  Widget build(BuildContext context) {
    var app = context.read<AppState>();

    _submit() async {
      setState(() {
        _busy = true;
      });
      if (_formKey.currentState!.validate()) {
        _formKey.currentState!.save();
        // Logging in the user w/ Firebase
        await app.signUpUser(_name!, _email!, _password!).then((value) {
          if (value == false) {
            return;
          }
          Navigator.of(context).pop();
        }).onError((error, stackTrace) {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text('$error')));
          setState(() {
            _busy = false;
          });
          return Future.error(error!);
        });
        // AuthService.signUpUser(context, _name!, _email!, _password!);
      }
      // await Future.delayed(Duration(seconds: 5));

      setState(() {
        _busy = false;
      });
    }

    return Column(
      children: [
        _busy == true ? LinearProgressIndicator() : Container(),
        Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.symmetric(
                  vertical: 10.0,
                ),
                child: TextFormField(
                  enabled: !_busy == true,
                  initialValue: _name,
                  decoration: InputDecoration(labelText: 'Name'),
                  validator: (input) => input!.trim().isEmpty
                      ? 'Please enter a valid name'
                      : null,
                  onSaved: (input) => _name = input!,
                  autofocus: true,
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                  vertical: 10.0,
                ),
                child: TextFormField(
                  enabled: !_busy == true,
                  initialValue: _name,
                  decoration: InputDecoration(labelText: 'Phone Number'),
                  validator: (input) =>
                      false ? 'Please enter a valid phone number' : null,
                  onSaved: (input) => _name = input!,
                  autofocus: true,
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                  vertical: 10.0,
                ),
                child: TextFormField(
                  enabled: !_busy == true,
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
                  enabled: !_busy == true,
                  initialValue: _password,
                  decoration: InputDecoration(labelText: 'Password'),
                  validator: (input) => input!.length < 6
                      ? 'Must be at least 6 characters'
                      : null,
                  onSaved: (input) => _password = input!,
                  obscureText: true,
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                  vertical: 10.0,
                ),
                child: TextFormField(
                  enabled: !_busy == true,

                  initialValue: _password,
                  decoration: InputDecoration(labelText: 'Renter Password'),
                  validator: (input) {
                    print(_password);
                    return input == null || input != _password
                        ? 'Passwords do not match'
                        : null;
                  },
                  // onSaved: (input) => _password = input!,
                  obscureText: true,
                ),
              ),
              SizedBox(height: 20.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  // TextButton(
                  //   onPressed: () => Navigator.pop(context),
                  //   child: Text(
                  //     'Back to Login',
                  //   ),
                  // ),
                  ElevatedButton(
                    onPressed: _busy != true ? _submit : null,
                    child: Text(
                      'Sign Up',
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20.0),
            ],
          ),
        ),
      ],
    );
  }
}
