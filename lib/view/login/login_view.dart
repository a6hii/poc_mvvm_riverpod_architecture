import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lottie/lottie.dart';
import 'package:poc_mvvm_riverpod_architecture/constants/strings.dart';
import 'package:poc_mvvm_riverpod_architecture/view/login/google_button.dart';
import 'package:poc_mvvm_riverpod_architecture/view_model/auth/auth_state_provider.dart';

class LoginView extends ConsumerWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 140),
              child: Text(
                Strings.welcomePleaseLogIn,
                style: Theme.of(context).textTheme.displaySmall,
              ),
            ),
            Lottie.asset('assets/lottie/login_lottie.json'),
            GoogleButton(
              onPressed: ref.read(authStateProvider.notifier).loginWithGoogle,
            ),
          ],
        ),
      ),
    );
  }
}
