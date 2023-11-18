import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:poc_mvvm_riverpod_architecture/view/common_components/dialogs/logout_dialog.dart';
import 'package:poc_mvvm_riverpod_architecture/view_model/alert_dialog_model.dart';
import 'package:poc_mvvm_riverpod_architecture/view_model/auth/auth_state_provider.dart';
import 'package:poc_mvvm_riverpod_architecture/view_model/user_info/user_id_provider.dart';
import 'package:poc_mvvm_riverpod_architecture/view_model/user_info/user_info_model_provider.dart';

class UserProfileView extends StatelessWidget {
  const UserProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
      ),
      body: Consumer(builder: (context, ref, _) {
        final userInfo =
            ref.watch(userInfoModelProvider(ref.watch(userIdProvider) ?? ''));
        return userInfo.when(
          data: (data) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Center(
                  child: Text(
                    "UserName:",
                    style: TextStyle(fontSize: 16),
                  ),
                ),
                Text(
                  data.displayName,
                  style: const TextStyle(fontSize: 16),
                ),
                const SizedBox(
                  height: 30,
                ),
                const Text(
                  "Email:",
                  style: TextStyle(fontSize: 16),
                ),
                Text(
                  "${data.email}",
                  style: const TextStyle(fontSize: 16),
                ),
                const SizedBox(
                  height: 130,
                ),
                ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateColor.resolveWith(
                          (states) => Colors.red[500]!),
                    ),
                    onPressed: () async {
                      final shouldLogOut =
                          await const LogoutDialog().present(context).then(
                                (value) => value ?? false,
                              );
                      if (shouldLogOut) {
                        await ref.read(authStateProvider.notifier).logOut();
                      }
                    },
                    child: const Text("Logout",
                        style: TextStyle(color: Colors.white))),
              ],
            );
          },
          error: (error, st) {
            return const Center(child: Text("error"));
          },
          loading: () => const Center(
            child: CircularProgressIndicator(),
          ),
        );
      }),
    );
  }
}
