import 'package:brycen_chat_app/screens/chat_screen.dart';
import 'package:brycen_chat_app/screens/home_screen.dart';
import 'package:brycen_chat_app/screens/summarize_screen.dart';
import 'package:brycen_chat_app/themes.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Intern Chatbot',
      theme: configThemes,
      initialRoute: HomeScreen.id,
      routes: {
        HomeScreen.id: (_) => const HomeScreen(),
        ChatScreen.id: (_) => const ChatScreen(),
        SummarizeScreen.id: (_) => const SummarizeScreen(),
      },
    );
  }
}
