import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_chat_app/screens/splash_screen.dart';
import 'package:flutter/material.dart';

import '../constant.dart';
import '../models/message.dart';
import '../widgets/custom_input_field_for_message.dart';
import '../widgets/custom_messege.dart';
import '../widgets/custom_send_button.dart'; // Ensure this is the correct path

class ChatPage extends StatefulWidget {
  static const String id = 'chat';

  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final TextEditingController _messageController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  CollectionReference referenceMessages =
      FirebaseFirestore.instance.collection('messages');
  String? sender;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {
        sender = ModalRoute.of(context)?.settings.arguments as String?;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: referenceMessages.orderBy('time', descending: true).snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          List<Message> messages = snapshot.data!.docs
              .map((doc) => Message(
                    message: doc['message'] as String? ?? 'Null Message',
                    sender: doc['sender'] as String? ?? 'Unknown Sender',
                  ))
              .toList();

          return Scaffold(
            appBar: AppBar(
              backgroundColor: KPrimaryColor.withOpacity(0.5),
              title: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircleAvatar(
                    backgroundImage: AssetImage('assets/images/scholar.png'),
                    radius: 20,
                  ),
                  SizedBox(width: 10),
                  Text(
                    'Scholar Chat',
                    style: TextStyle(fontSize: 24, color: Colors.white),
                  ),
                ],
              ),
            ),
            body: Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    reverse: true,
                    controller: _scrollController,
                    itemCount: messages.length,
                    itemBuilder: (context, index) {
                      return messages[index].sender == sender
                          ? CustomMessage(message: messages[index])
                          : CustomMessageForFriend(message: messages[index]);
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: CustomTextField(
                          controller: _messageController,
                          onSubmitted: (value) {},
                        ),
                      ),
                      const SizedBox(width: 10),
                      CustomSendButton(
                        onPressed: () {
                          if (_messageController.text.isNotEmpty) {
                            referenceMessages.add({
                              'message': _messageController.text,
                              'sender': sender,
                              'time': DateTime.now(),
                            });
                            _messageController.clear();
                            _scrollController.animateTo(
                              0,
                              duration: const Duration(milliseconds: 300),
                              curve: Curves.easeIn,
                            );
                          }
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        } else {
          return SplashScreen();
        }
      },
    );
  }

  @override
  void dispose() {
    _messageController.dispose();
    _scrollController.dispose();
    super.dispose();
  }
}
