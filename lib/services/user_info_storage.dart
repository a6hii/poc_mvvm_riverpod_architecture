import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:poc_mvvm_riverpod_architecture/constants/firebase_collection_name.dart';
import 'package:poc_mvvm_riverpod_architecture/constants/firebase_field_name.dart';
import 'package:poc_mvvm_riverpod_architecture/model/user/user_info_payload.dart';
import 'package:poc_mvvm_riverpod_architecture/type_def/userid.dart';

@immutable
class UserInfoStorage {
  const UserInfoStorage();
  Future<bool> saveUserInfo({
    required UserId userId,
    required String displayName,
    required String? email,
  }) async {
    try {
      // first check if we have this user's info from before
      final userInfo = await FirebaseFirestore.instance
          .collection(
            FirebaseCollectionName.users,
          )
          .where(
            FirebaseFieldName.userId,
            isEqualTo: userId,
          )
          .limit(1)
          .get();

      if (userInfo.docs.isNotEmpty) {
        // we already have this user's profile, save the new data instead
        await userInfo.docs.first.reference.update({
          FirebaseFieldName.displayName: displayName,
          FirebaseFieldName.email: email ?? '',
        });
        return true;
      }

      final payload = UserInfoPayload(
        userId: userId,
        displayName: displayName,
        email: email,
      );
      await FirebaseFirestore.instance
          .collection(
            FirebaseCollectionName.users,
          )
          .add(payload);
      return true;
    } catch (_) {
      return false;
    }
  }
}
