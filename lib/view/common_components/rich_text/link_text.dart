import 'package:flutter/foundation.dart' show immutable, VoidCallback;
import 'package:poc_mvvm_riverpod_architecture/view/common_components/rich_text/base_text.dart';

@immutable
class LinkText extends BaseText {
  final VoidCallback onTapped;
  const LinkText({
    required super.text,
    required this.onTapped,
    super.style,
  });
}
