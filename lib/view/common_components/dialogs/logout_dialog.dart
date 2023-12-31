import 'package:flutter/foundation.dart' show immutable;
import 'package:poc_mvvm_riverpod_architecture/constants/strings.dart';
import 'package:poc_mvvm_riverpod_architecture/view_model/alert_dialog_model.dart';

@immutable
class LogoutDialog extends AlertDialogModel<bool> {
  const LogoutDialog()
      : super(
          title: Strings.logOut,
          message: Strings.areYouSureThatYouWantToLogOutOfTheApp,
          buttons: const {
            Strings.cancel: false,
            Strings.logOut: true,
          },
        );
}
