import 'dart:collection' show MapView;

import 'package:flutter/foundation.dart' show immutable;
import 'package:poc_mvvm_riverpod_architecture/constants/firebase_field_name.dart';
import 'package:poc_mvvm_riverpod_architecture/type_def/userid.dart';

@immutable
class UserInfoPayload extends MapView<String, String> {
  UserInfoPayload({
    required UserId userId,
    required String? displayName,
    required String? email,
  }) : super(
          {
            FirebaseFieldName.userId: userId,
            FirebaseFieldName.displayName: displayName ?? '',
            FirebaseFieldName.email: email ?? '',
          },
        );
}
