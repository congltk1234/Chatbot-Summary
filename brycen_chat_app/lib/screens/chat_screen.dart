import 'package:brycen_chat_app/widgets/chat_message.dart';
import 'package:brycen_chat_app/widgets/new_message.dart';
import 'package:flutter/material.dart';

class ChatScreen extends StatefulWidget {
  static const id = 'chat_screen';

  const ChatScreen({super.key});
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ChatBot'),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.exit_to_app,
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
        ],
      ),
      body: const Column(
        children: [
          Expanded(child: ChatMessages()),
          NewMessage(),
        ],
      ),
      //  Center(
      //   child: ElevatedButton(
      //     // Within the SecondScreen widget
      //     onPressed: () {
      //       Navigator.pop(context);
      //     },
      //     child: const Text('Go back!'),
      //   ),
      // ),
    );
  }
}
