import 'package:flutter/material.dart';

class FlavorOnboardingV3 extends StatefulWidget {
  final String? gApiKey;
  final bool? isLoggedIn;
  final Future Function(String email, String password)? onEmailLogin;
  final Future<Object?> Function(
      String email, String password, String passwordReEnter)? onEmailSignup;
  const FlavorOnboardingV3(
      {Key? key,
      this.gApiKey,
      this.isLoggedIn,
      this.onEmailLogin,
      this.onEmailSignup})
      : super(key: key);

  @override
  _FlavorOnboardingV3State createState() => _FlavorOnboardingV3State();
}

class _FlavorOnboardingV3State extends State<FlavorOnboardingV3> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
