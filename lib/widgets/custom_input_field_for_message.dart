import 'package:flutter/material.dart';

import '../constant.dart';

class CustomTextField extends StatelessWidget {
  final Function(String) onSubmitted;
  final TextEditingController controller;

  const CustomTextField({
    super.key,
    required this.onSubmitted,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      textAlign: TextAlign.left,
      onSubmitted: onSubmitted,
      controller: controller,
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.all(16),
        filled: true,
        fillColor: Colors.grey[200],
        hintText: 'Enter your message',
        hintStyle: const TextStyle(color: KPrimaryColor, fontSize: 14),
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: KPrimaryColor, width: 2),
          borderRadius: BorderRadius.circular(100),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: KPrimaryColor, width: 2),
          borderRadius: BorderRadius.circular(100),
        ),
      ),
    );
  }
}
