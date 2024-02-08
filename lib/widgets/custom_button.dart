import 'package:flutter/material.dart';

import '../constant.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({super.key, required this.text, required this.onPressed});
  final String text;
  final Function() onPressed;
  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      padding: const EdgeInsets.all(8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
      height: 50,
      color: Colors.white,
      minWidth: double.infinity,
      onPressed: onPressed,
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 16,
          color: KPrimaryColor,
        ),
      ),
    );
  }
}
