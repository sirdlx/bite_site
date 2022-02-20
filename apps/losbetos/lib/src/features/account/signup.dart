import 'package:flavor_auth/flavor_auth.dart';
import 'package:flutter/material.dart';
import 'package:losbetosapp/src/features/auth/auth_controller.dart';

class SignupScreen extends StatefulWidget {
  static const String id = 'signup_screen';
  final LBAuthNotifier auth;

  const SignupScreen({Key? key, required this.auth}) : super(key: key);

  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _formKey = GlobalKey<FormState>();
  String _password = "Rocky0813!";
  bool _busy = false;

  FlavorUser user =
      FlavorUser(displayName: 'sir white', email: 'sirwhite@dlxstudios.com');

  @override
  Widget build(BuildContext context) {
    _submit() async {
      setState(() {
        _busy = true;
      });
      await Future.delayed(const Duration(seconds: 1));

      if (_formKey.currentState!.validate()) {
        _formKey.currentState!.save();
        // Logging in the user w/ Firebase
        await widget.auth
            .signUpWithEmailAndPassword(
          displayName: user.displayName!,
          email: user.email!,
          password: _password,
        )
            .then((value) {
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
        _busy == true ? const LinearProgressIndicator() : Container(),
        Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 10.0,
                ),
                child: TextFormField(
                  enabled: !_busy == true,
                  initialValue: user.displayName,
                  decoration: const InputDecoration(labelText: 'Name'),
                  validator: (input) => input!.trim().isEmpty
                      ? 'Please enter a valid name'
                      : null,
                  onSaved: (input) => user = user.copyWith(
                      displayName: input,
                      phoneNumber: user.phoneNumber,
                      email: user.email),
                  autofocus: true,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 10.0,
                ),
                child: TextFormField(
                  enabled: !_busy == true,
                  initialValue: user.phoneNumber,
                  decoration: const InputDecoration(labelText: 'Phone Number'),
                  validator: (input) => input == null
                      ? 'Please enter a valid phone number'
                      : null,
                  onSaved: (input) => user = user.copyWith(
                    phoneNumber: input,
                  ),
                  autofocus: true,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 10.0,
                ),
                child: TextFormField(
                  enabled: !_busy == true,
                  initialValue: user.email,
                  decoration: const InputDecoration(labelText: 'Email'),
                  validator: (input) {
                    return input == null ||
                            input.isEmpty ||
                            !input.contains('@')
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
                  enabled: !_busy == true,
                  initialValue: _password,
                  decoration: const InputDecoration(labelText: 'Password'),
                  validator: (input) => input!.length < 6
                      ? 'Must be at least 6 characters'
                      : null,
                  onSaved: (input) => _password = input!,
                  obscureText: true,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 10.0,
                ),
                child: TextFormField(
                  enabled: !_busy == true,

                  initialValue: _password,
                  decoration:
                      const InputDecoration(labelText: 'Renter Password'),
                  validator: (input) {
                    // ignore: avoid_print
                    print(_password);
                    return input == null || input != _password
                        ? 'Passwords do not match'
                        : null;
                  },
                  // onSaved: (input) => _password = input!,
                  obscureText: true,
                ),
              ),
              const SizedBox(height: 20.0),
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
                    child: const Text(
                      'Sign Up',
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20.0),
            ],
          ),
        ),
      ],
    );
  }
}
