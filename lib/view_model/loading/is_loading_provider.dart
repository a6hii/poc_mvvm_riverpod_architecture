import 'package:poc_mvvm_riverpod_architecture/view_model/auth/auth_state_provider.dart';
import 'package:poc_mvvm_riverpod_architecture/view_model/todo/local_storage_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'is_loading_provider.g.dart';

@riverpod
bool isLoading(IsLoadingRef ref) {
  final authState = ref.watch(authStateProvider);
  final localStorageState = ref.watch(localStorageProvider);

  return authState.isLoading || localStorageState;
}
