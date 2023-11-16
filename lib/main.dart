import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:poc_mvvm_riverpod_architecture/view/common_components/loading/loading_screen.dart';
import 'package:poc_mvvm_riverpod_architecture/view/login/login_view.dart';
import 'package:poc_mvvm_riverpod_architecture/view/main/main_view.dart';
import 'package:poc_mvvm_riverpod_architecture/view_model/auth/is_logged_in_provider.dart';
import 'package:poc_mvvm_riverpod_architecture/view_model/loading/is_loading_provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Todo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: Consumer(
        builder: (context, ref, child) {
          // install the loading screen
          ref.listen<bool>(
            isLoadingProvider,
            (_, isLoading) {
              if (isLoading) {
                LoadingScreen.instance().show(
                  context: context,
                );
              } else {
                LoadingScreen.instance().hide();
              }
            },
          );
          final isLoggedIn = ref.watch(isLoggedInProvider);
          if (isLoggedIn) {
            return const MainView();
          } else {
            return const LoginView();
          }
        },
      ),
    );
  }
}
