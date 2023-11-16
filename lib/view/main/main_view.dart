import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:poc_mvvm_riverpod_architecture/constants/strings.dart';
import 'package:poc_mvvm_riverpod_architecture/view/common_components/logout_dialog.dart';
import 'package:poc_mvvm_riverpod_architecture/view/home_view/home_view.dart';
import 'package:poc_mvvm_riverpod_architecture/view/user_profile/user_profile_view.dart';
import 'package:poc_mvvm_riverpod_architecture/view_model/alert_dialog_model.dart';
import 'package:poc_mvvm_riverpod_architecture/view_model/auth/auth_state_provider.dart';

class MainView extends ConsumerStatefulWidget {
  const MainView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _MainViewState();
}

class _MainViewState extends ConsumerState<MainView> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            Strings.appName,
          ),
          actions: [
            IconButton(
              onPressed: () async {
                final shouldLogOut =
                    await const LogoutDialog().present(context).then(
                          (value) => value ?? false,
                        );
                if (shouldLogOut) {
                  await ref.read(authStateProvider.notifier).logOut();
                }
              },
              icon: const Icon(
                Icons.logout,
              ),
            ),
          ],
          bottom: const TabBar(
            tabs: [
              Tab(
                icon: Icon(
                  Icons.home,
                ),
              ),
              Tab(
                icon: Icon(
                  Icons.person,
                ),
              ),
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            HomeView(),
            UserProfileView(),
          ],
        ),
      ),
    );
  }
}
