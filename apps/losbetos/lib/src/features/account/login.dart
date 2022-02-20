import 'package:firebase_auth/firebase_auth.dart';
import 'package:flavor_auth/flavor_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:losbetosapp/src/features/auth/auth_controller.dart';
import 'package:losbetosapp/src/features/auth/auth_hookwidget.dart';
import 'package:losbetosapp/src/features/auth/auth_repo.dart';
import 'package:losbetosapp/src/features/auth/auth_controller.dart';

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





// import 'dart:developer';

// import 'package:bitsdojo_window/bitsdojo_window.dart';
// import 'package:display/src/layout.dart';
// import 'package:flavor_auth/flavor_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_neumorphic/flutter_neumorphic.dart';
// import 'package:flutter_unicons/flutter_unicons.dart';

// class ScreenLogin extends StatefulWidget {
//   const ScreenLogin({Key? key, required this.auth, required this.child})
//       : super(key: key);

//   final AuthController auth;
//   final Widget child;

//   @override
//   State<ScreenLogin> createState() => _ScreenLoginState();
// }

// class _ScreenLoginState extends State<ScreenLogin> {
//   final _formKey = GlobalKey<FormState>();

//   String _email = "";
//   String _password = "";
//   // ignore: unused_field
//   String _passwordReenter = "";

//   bool _busy = false;

//   // ignore: non_constant_identifier_names
//   bool signup_view = false;
//   bool show_pass = false;

//   final TextEditingController _emailController =
//       TextEditingController(text: 'sirwhite@dlxstudios.com');
//   final TextEditingController _passwordController =
//       TextEditingController(text: 'dlxOne');
//   final TextEditingController _passwordReenterController =
//       TextEditingController();

//   _submit() async {
//     if (_formKey.currentState!.validate()) {
//       setState(() {
//         _busy = true;
//       });
//       await Future.delayed(const Duration(seconds: 0));

//       _formKey.currentState!.save();
//       // Logging in the user w/ Firebase
//       try {
//         await widget.auth
//             .logInWithEmailAndPassword(email: _email, password: _password);
//       } catch (e) {
//         ScaffoldMessenger.of(context).showSnackBar(SnackBar(
//           content: Text('$e'),
//         ));
//       }
//       //     .onError((error, stackTrace) {
//       //   // ignore: avoid_print
//       //   print('error::${jsonDecode(error.toString()).runtimeType}');
//       //   var jsonError = jsonDecode(error.toString());
//       //   ScaffoldMessenger.of(context).showSnackBar(SnackBar(
//       //     content: Text('${jsonError['error']['message']}'),
//       //   ));
//       setState(() {
//         _busy = false;
//       });
//       // });

//       // app.signInUser();
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     var user = widget.auth.user;

//     if (user != null) {
//       return Container(
//         // color: Colors.deepPurple,
//         child: widget.child,
//       );
//     }
//     return Container(
//       decoration: BoxDecoration(
//         gradient: LinearGradient(
//           colors: [
//             Colors.purpleAccent.withOpacity(.1),
//             Colors.greenAccent,
//           ],
//         ),
//         color: Colors.white,
//       ),
//       child: AppLayout(
//         color: NeumorphicTheme.of(context)?.current?.baseColor,
//         child: Scaffold(
//           appBar: NeumorphicAppBar(
//             // color: NeumorphicTheme.of(context)?.current?.baseColor,
//             color: Colors.transparent,

//             title: Text(
//               'DLX Display',
//               style: Theme.of(context).textTheme.headline3,
//             ),

//             // title: NeumorphicText(
//             //   'DLX Display',
//             //   // style: const NeumorphicStyle(color: Colors.red),
//             //   textStyle: NeumorphicTextStyle(
//             //     fontSize: 36,
//             //     fontWeight: FontWeight.w700,
//             //   ),
//             // ),
//             centerTitle: true,
//             // color: Colors.red,
//           ),
//           body: Stack(
//             fit: StackFit.expand,
//             children: [
//               Positioned(
//                 child: MoveWindow(),
//               ),
//               SingleChildScrollView(
//                 child: Padding(
//                   padding: const EdgeInsets.only(
//                     left: 48.0,
//                     right: 48.0,
//                     // top: 32.0,
//                     // bottom: 24,
//                   ),
//                   child: Center(child: buildForm()),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   Widget buildForm() {
//     return ConstrainedBox(
//       constraints: const BoxConstraints(
//         maxWidth: 480,
//         minWidth: 320,
//       ),
//       child: Form(
//         key: _formKey,
//         child: Column(
//           // mainAxisSize: MainAxisSize.min,
//           // mainAxisAlignment: MainAxisAlignment.center,
//           // crossAxisAlignment: CrossAxisAlignment.start,
//           children: <Widget>[
//             Padding(
//               padding: const EdgeInsets.symmetric(
//                 vertical: 0.0,
//               ),
//               child: buildEmailField(),
//             ),
//             Padding(
//               padding: const EdgeInsets.symmetric(
//                 vertical: 10.0,
//               ),
//               child: buildPasswordField(),
//             ),
//             const SizedBox(height: 10.0),
//             ExpansionTile(
//               onExpansionChanged: (value) => setState(() {
//                 signup_view = value;
//               }),
//               trailing: SizedBox(
//                 width: 26,
//                 height: 26,
//                 child: Unicon(
//                   Unicons.uniArrowDown,
//                   // size: 2,
//                 ),
//               ),
//               title: const Text('Create Account'),
//               children: [
//                 Padding(
//                   padding: const EdgeInsets.symmetric(
//                     vertical: 10.0,
//                   ),
//                   child: buildPasswordReenterField(),
//                 ),
//                 const SizedBox(height: 60.0),
//               ],
//             ),
//             const SizedBox(height: 40.0),

//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 NeumorphicButton(
//                   onPressed: !_busy ? _submit : null,
//                   child: const Text(
//                     'Forgot Password?',
//                   ),
//                 ),
//                 NeumorphicButton(
//                   style: NeumorphicStyle(
//                     color: NeumorphicTheme.of(context)!.current!.accentColor,
//                   ),
//                   onPressed: !_busy ? _submit : null,
//                   child: Text(
//                     !signup_view ? 'Login' : 'Create',
//                   ),
//                 ),
//               ],
//             ),

//             // SizedBox(height: 60.0),
//             // ElevatedButton(
//             //   onPressed: () => Navigator.pushNamed(context, SignupScreen.id),
//             //   child: Text(
//             //     'Sign up',
//             //   ),
//             // ),
//           ],
//         ),
//       ),
//     );
//   }

//   TextFormField buildPasswordReenterField() {
//     return TextFormField(
//       controller: _passwordReenterController,
//       enabled: !_busy == true,
//       decoration: InputDecoration(
//         labelText: 'Renter Password',
//         prefixIcon: SizedBox(
//           width: 0,
//           height: 0,
//           child: Unicon(
//             Unicons.uniKeyholeCircle,
//             // size: 22,
//           ),
//         ),
//       ),
//       validator: (input) {
//         // ignore: avoid_print
//         if (input!.isEmpty) {
//           return 'Please re-enter the password';
//         }

//         if (input != _password) {
//           return 'Passwords do not match';
//         }
//       },
//       onSaved: (input) => setState(() => _passwordReenter = input!),
//       obscureText: true,
//     );
//   }

//   TextFormField buildPasswordField() {
//     return TextFormField(
//       controller: _passwordController,
//       enabled: !_busy,
//       decoration: InputDecoration(
//           labelText: 'Password',
//           prefixIcon: SizedBox(
//             width: 0,
//             height: 0,
//             child: Unicon(
//               Unicons.uniKeyholeCircle,
//               // size: 22,
//             ),
//           ),
//           suffixIcon: IconButton(
//               splashRadius: 20,
//               onPressed: () {
//                 setState(() {
//                   show_pass = !show_pass;
//                 });
//               },
//               icon: Unicon(
//                 Unicons.uniEye,
//                 // size: 22,
//               ))),
//       validator: (input) =>
//           input!.length < 6 ? 'Must be at least 6 characters' : null,
//       onSaved: (input) => setState(() => _password = input!),
//       obscureText: !show_pass,
//     );
//   }

//   TextFormField buildEmailField() {
//     return TextFormField(
//       controller: _emailController,
//       enabled: !_busy,
//       decoration: InputDecoration(
//         labelText: 'Email',
//         prefixIcon: SizedBox(
//           width: 0,
//           height: 0,
//           child: Unicon(
//             Unicons.uniFastMailAlt,
//             // size: 22,
//           ),
//         ),
//       ),
//       validator: (input) {
//         return input == null || input.isEmpty || !input.contains('@')
//             ? 'Please enter a valid email'
//             : null;
//       },
//       onSaved: (input) => setState(() => _email = input!),
//     );
//   }
// }

