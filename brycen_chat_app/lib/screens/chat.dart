import 'package:brycen_chat_app/providers/chats_provider.dart';
import 'package:brycen_chat_app/screens/chat_screen_x.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Chat extends StatefulWidget {
  const Chat({super.key});

  @override
  State<Chat> createState() => _ChatState();
}

class _ChatState extends State<Chat> {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => ChatProvider(),
        ),
      ],
      child: MaterialApp(
        title: 'ChatBot',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
            scaffoldBackgroundColor: const Color(0xFF343541),
            appBarTheme: const AppBarTheme(
              color: Color(0xFF444654),
            )),
        home: const ChatScreen(),
      ),
    );
  }
}
