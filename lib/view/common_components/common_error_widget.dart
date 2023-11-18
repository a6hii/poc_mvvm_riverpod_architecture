import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CommonErrorWidget extends ConsumerWidget {
  final VoidCallback onPressed;
  const CommonErrorWidget({
    super.key,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Center(
        child: Padding(
      padding: EdgeInsets.only(
        top: MediaQuery.sizeOf(context).height * 0.4,
      ),
      child: Column(
        children: [
          const Text("Something happened. Please try again"),
          ElevatedButton(
            onPressed: onPressed,
            child: const Text('Refresh'),
          ),
        ],
      ),
    ));
  }
}
