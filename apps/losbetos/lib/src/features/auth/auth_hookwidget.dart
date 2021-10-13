import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:losbetosapp/src/features/auth/auth_controller.dart';
import 'package:losbetosapp/src/features/auth/auth_repo.dart';

class AuthHookWidget extends ConsumerWidget {
  const AuthHookWidget({Key? key, required this.builder}) : super(key: key);
  final Widget Function(
          BuildContext context, User? user, FirebaseAuthRepository controller)
      builder;

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final user = watch(authControllerProvider);
    // final controller = context.read(authControllerProvider.notifier);
    final controller = watch(firebaseAuthRepositoryProvider);
    return builder(context, user, controller);
  }
}
