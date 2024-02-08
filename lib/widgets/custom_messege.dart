import 'package:flutter/material.dart';

import '../constant.dart';
import '../models/message.dart';

class CustomMessage extends StatelessWidget {
  const CustomMessage({super.key, required this.message});
  final Message message;
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.only(left: 10, right: 70, top: 10, bottom: 10),
        padding: const EdgeInsets.all(16),
        decoration: const BoxDecoration(
          color: KPrimaryColor,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
              bottomRight: Radius.circular(20)),
        ),
        child: Text(
          message.message ?? '',
          style: const TextStyle(fontSize: 14, color: Colors.white),
          textAlign: TextAlign.left,
        ),
      ),
    );
  }
}

class CustomMessageForFriend extends StatelessWidget {
  const CustomMessageForFriend({super.key, required this.message});
  final Message message;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end, // Align to the end of the row
      children: [
        Container(
          constraints: BoxConstraints(
              maxWidth:
                  MediaQuery.of(context).size.width * 0.8), // Limit the width
          margin:
              const EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 10),
          padding: const EdgeInsets.all(16),
          decoration: const BoxDecoration(
            color: KPrimaryColor,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
              bottomLeft: Radius.circular(20),
            ),
          ),
          child: Text(
            message.message ?? '',
            style: const TextStyle(fontSize: 14, color: Colors.white),
            textAlign: TextAlign.left,
          ),
        ),
      ],
    );
  }
}
