import 'package:brycen_chat_app/screens/chat_screen.dart';
import 'package:brycen_chat_app/screens/summarize_screen.dart';
import 'package:brycen_chat_app/values/share_keys.dart';
import 'package:brycen_chat_app/widgets/app_bar.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  static const id = 'home_screen';
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _keyController = TextEditingController();
  late SharedPreferences prefs;
  var key = '';

  @override
  void initState() {
    super.initState();
    initDefaultValue();
  }

  initDefaultValue() async {
    prefs = await SharedPreferences.getInstance();
    setState(() {
      key = prefs.getString(ShareKeys.APIkey) ?? '';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ConfigAppBar(
        title: key,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            'assets/images/logo.jpg',
            width: 300,
          ),

// Form(child: child),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40),
            child: Column(
              children: [
                TextFormField(
                  maxLength: 50,
                  textCapitalization: TextCapitalization.words,
                  decoration: const InputDecoration(
                    hintText: 'Your Name:',
                  ),
                ),
                TextFormField(
                  autofocus: true,
                  obscureText: true,
                  controller: _keyController,
                  decoration: InputDecoration(
                    labelText: 'API Key',
                    prefixIcon: Icon(Icons.key,
                        color: Theme.of(context).colorScheme.secondary),
                    hintText: "Insert your OpenAPI key...",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    suffixIcon: Container(
                      margin: const EdgeInsets.all(8),
                      child: IconButton(
                        // color: Theme.of(context).colorScheme.primary,
                        icon: const Icon(
                          Icons.send,
                        ),
                        color: Theme.of(context).colorScheme.primary,
                        onPressed: () async {
                          final newKey = _keyController.text;
                          await prefs.setString(
                              ShareKeys.APIkey, _keyController.text);
                          setState(() {
                            key = newKey;
                            _keyController.clear();
                          });
                        },
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () {
                    // Navigator.pushNamed(context, ChatScreen.id);
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
