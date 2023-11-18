import 'package:flutter/foundation.dart' show immutable;
import 'package:poc_mvvm_riverpod_architecture/constants/strings.dart';
import 'package:poc_mvvm_riverpod_architecture/view_model/alert_dialog_model.dart';

@immutable
class DeleteDialog extends AlertDialogModel<bool> {
  const DeleteDialog()
      : super(
          title: Strings.deleteConfirmation,
          message: Strings.deleteConfirmation,
          buttons: const {
            Strings.cancel: false,
            Strings.yes: true,
          },
        );
}
