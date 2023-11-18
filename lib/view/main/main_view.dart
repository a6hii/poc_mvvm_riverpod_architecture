import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:poc_mvvm_riverpod_architecture/view/home_tab_view/home_tab_view.dart';
import 'package:poc_mvvm_riverpod_architecture/view/user_profile/user_profile_view.dart';

class MainView extends ConsumerStatefulWidget {
  const MainView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _MainViewState();
}

class _MainViewState extends ConsumerState<MainView> {
  @override
  Widget build(BuildContext context) {
    return const DefaultTabController(
      length: 2,
      child: Scaffold(
        bottomNavigationBar: TabBar(
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
        body: TabBarView(
          children: [
            HomeTabView(),
            UserProfileView(),
          ],
        ),
      ),
    );
  }
}
