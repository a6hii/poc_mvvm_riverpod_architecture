import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:poc_mvvm_riverpod_architecture/constants/app_colors.dart';
import 'package:poc_mvvm_riverpod_architecture/constants/strings.dart';
import 'package:poc_mvvm_riverpod_architecture/view/login/divider_with_margins.dart';
import 'package:poc_mvvm_riverpod_architecture/view/login/facebook_button.dart';
import 'package:poc_mvvm_riverpod_architecture/view/login/google_button.dart';
import 'package:poc_mvvm_riverpod_architecture/view/login/login_view_signup_links.dart';
import 'package:poc_mvvm_riverpod_architecture/view_model/auth/auth_state_provider.dart';

class LoginView extends ConsumerWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          Strings.appName,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(
                height: 40,
              ),
              // header text
              Text(
                Strings.welcomeToAppName,
                style: Theme.of(context).textTheme.displaySmall,
              ),
              const DividerWithMargins(),
              Text(
                Strings.logIntoYourAccount,
                style: Theme.of(context)
                    .textTheme
                    .subtitle1
                    ?.copyWith(height: 1.5),
              ),
              const SizedBox(
                height: 20,
              ),
              // TextButton(
              //   style: TextButton.styleFrom(
              //     backgroundColor: AppColors.loginButtonColor,
              //     foregroundColor: AppColors.loginButtonTextColor,
              //   ),
              //   onPressed:
              //       ref.read(authStateProvider.notifier).loginWithFacebook,
              //   child: const FacebookButton(),
              // ),
              // const SizedBox(
              //   height: 20,
              // ),
              TextButton(
                style: TextButton.styleFrom(
                  backgroundColor: AppColors.loginButtonColor,
                  foregroundColor: AppColors.loginButtonTextColor,
                ),
                onPressed: ref.read(authStateProvider.notifier).loginWithGoogle,
                child: const GoogleButton(),
              ),
              const DividerWithMargins(),
              const LoginViewSignupLinks(),
            ],
          ),
        ),
      ),
    );
  }
}
