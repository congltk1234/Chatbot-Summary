import 'package:brycen_chat_app/screens/chat_screen.dart';
import 'package:brycen_chat_app/screens/summarize_screen.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  static const id = 'home_screen';
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('First Screen'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 30, horizontal: 40),
            child: TextField(
              autofocus: true,
              obscureText: true,
              decoration: InputDecoration(labelText: 'API Key'),
            ),
          ),
          Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, ChatScreen.id);
                  },
                  child: const Text('Chatbot'),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, SummarizeScreen.id);
                  },
                  child: const Text('Summary'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
