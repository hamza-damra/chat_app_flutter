import 'package:flutter/material.dart';

import '../constant.dart';

class CustomSendButton extends StatelessWidget {
  CustomSendButton({super.key, required this.onPressed});
  VoidCallback? onPressed;
  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      padding: const EdgeInsets.all(8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)),
      height: 50,
      color: KPrimaryColor,
      onPressed: onPressed,
      child: const Icon(
        Icons.send,
        size: 20,
        color: Colors.white,
      ),
    );
  }
}
