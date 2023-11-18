import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:poc_mvvm_riverpod_architecture/constants/strings.dart';

class GoogleButton extends StatelessWidget {
  final VoidCallback onPressed;
  const GoogleButton({
    Key? key,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 44.0,
      child: ElevatedButton(
        onPressed: onPressed,
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FaIcon(
              FontAwesomeIcons.google,
              color: Color(0xFFFF8B42),
            ),
            SizedBox(
              width: 10.0,
            ),
            Text(
              Strings.google,
              style: TextStyle(color: Colors.white),
            )
          ],
        ),
      ),
    );
  }
}
