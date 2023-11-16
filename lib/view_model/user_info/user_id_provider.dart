import 'package:poc_mvvm_riverpod_architecture/type_def/userid.dart';
import 'package:poc_mvvm_riverpod_architecture/view_model/auth/auth_state_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'user_id_provider.g.dart';

@riverpod
UserId? userId(UserIdRef ref) => ref
    .watch(
      authStateProvider,
    )
    .userId;
