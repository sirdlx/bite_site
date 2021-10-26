import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:losbetosapp/src/features/auth/auth_service.dart';

class AuthHookWidget extends StatelessWidget {
  final Widget Function(
    BuildContext context,
    LBAuthNotifier user,
  ) // FirebaseAuthRepository controller)
      builder;

  const AuthHookWidget({required this.builder, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) =>
          builder(context, ref.watch(authControllerProvider)),
    );
  }
}
