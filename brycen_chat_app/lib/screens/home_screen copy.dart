import 'package:brycen_chat_app/screens/chat_screen.dart';
import 'package:brycen_chat_app/screens/summarize_screen.dart';
import 'package:brycen_chat_app/values/share_keys.dart';
import 'package:brycen_chat_app/widgets/app_bar.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  static const id = 'home_screen_test';
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // controllers for form text controllers
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _enteredAPIKey = TextEditingController();
  final TextEditingController _enteredUsername = TextEditingController();

  late SharedPreferences prefs;
  var _initAPIKey = '';
  var _initUsername = '';
  bool _isValid = false;
  bool _isLoading = false;
  bool passwordVisible = true;

  bool? _isAPI;
  String? errorText;

  Future<bool> checkApiKey(String apiKey) async {
    final response = await http.post(
      Uri.parse("https://api.openai.com/v1/completions"),
      headers: {
        'Authorization': 'Bearer $apiKey',
        'Content-Type': 'application/json'
      },
      body: jsonEncode({
        "model": "text-davinci-003",
        "prompt": "Say this is a test",
        "max_tokens": 7,
        "temperature": 0,
      }),
    );
    final message = jsonDecode(response.body);
    if (response.statusCode == 200) {
      _isAPI = true;
      print(message['choices'][0]['text']);
      return true;
    } else {
      print(message['error']['message']);
      return false;
    }
  }

  Future<void> _submit() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      prefs.setString(ShareKeys.APIkey, _enteredAPIKey.text);
      prefs.setString(ShareKeys.Username, _enteredUsername.text);
    }
    // var collection = FirebaseFirestore.instance.collection('memory');
    if (_isAPI == true && _enteredUsername.toString().trim().length >= 4) {
      print('Accept');
      return;
    }
  }

  @override
  void initState() {
    _getLocalValue();
    super.initState();
    setState(() {
      _isLoading = false;
    });
  }

  void _getLocalValue() async {
    prefs = await SharedPreferences.getInstance();
    setState(() {
      _initAPIKey = prefs.getString(ShareKeys.APIkey) ?? '';
      _initUsername = prefs.getString(ShareKeys.Username) ?? '';
      if (_initAPIKey != '' && _initUsername != '') {
        _isValid = true;
        _enteredAPIKey.text = _initAPIKey;
        _enteredUsername.text = _initUsername;
      }
    });
  }

  // void _addNewUserKey() async {
  //   if (_formKey.currentState!.validate()) {
  //     _formKey.currentState!.save();
  //     prefs.setString(ShareKeys.APIkey, _enteredAPIKey.text);
  //     prefs.setString(ShareKeys.Username, _enteredUsername.text);
  //   }
  // }

  void _checkAPI() {}

  @override
  Widget build(BuildContext context) {
    Widget inputForm = Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40),
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            TextFormField(
              autofocus: true,
              textCapitalization: TextCapitalization.words,
              controller: _enteredUsername,
              // textInputAction: TextInputAction.continueAction,
              decoration: const InputDecoration(
                hintText: 'Your Name:',
              ),

              onSaved: (value) {
                _enteredUsername.text = value!;
              },
            ),
            const SizedBox(height: 8),
            TextFormField(
              obscureText: passwordVisible,
              controller: _enteredAPIKey,
              onChanged: (value) async {
                final check = await checkApiKey(value);
                setState(() => _isAPI = check);
              },
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return "Không được để trống API key.";
                }

                if (value.trim().length != 51) {
                  return "Độ dài API Key không hợp lệ.";
                }
                if (!_isAPI!) {
                  return "API Key không tồn tại.";
                }
                return null;
              },
              onSaved: (value) {
                _enteredAPIKey.text = value!;
              },
              keyboardType: TextInputType.visiblePassword,
              decoration: InputDecoration(
                labelText: 'API Key',
                prefixIcon: Icon(Icons.key,
                    color: Theme.of(context).colorScheme.secondary),
                hintText: "Insert your OpenAPI key...",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                suffixIcon: IconButton(
                  icon: Icon(passwordVisible
                      ? Icons.visibility
                      : Icons.visibility_off),
                  onPressed: () {
                    setState(
                      () {
                        passwordVisible = !passwordVisible;
                      },
                    );
                  },
                ),
              ),
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        // _addNewUserKey();
                        _submit();
                        setState(() {
                          _initAPIKey = _enteredAPIKey.text;
                          _initUsername = _enteredUsername.text;
                          _isValid = true;
                        });
                      }
                    },
                    child:
                        // _isLoading
                        // ? const SizedBox(
                        //     height: 16,
                        //     width: 16,
                        //     child: CircularProgressIndicator(),
                        //   )
                        // :
                        const Text('Submit')),
              ],
            ),
          ],
        ),
      ),
    );

    if (_isValid) {
      inputForm = Padding(
          padding: const EdgeInsets.symmetric(horizontal: 60),
          child: Column(
            children: [
              Text.rich(
                TextSpan(
                  text: 'Hello ', // default text style
                  children: <TextSpan>[
                    TextSpan(
                        text: _initUsername,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).colorScheme.primary,
                        )),
                    const TextSpan(
                      text: ', Your API key is:',
                    ),
                  ],
                ),
              ),
              Text.rich(TextSpan(
                  text: _initAPIKey.substring(0, 5) +
                      '***' +
                      _initAPIKey.substring(48, 51),
                  style: TextStyle(
                    fontStyle: FontStyle.italic,
                    color: Theme.of(context).colorScheme.primary,
                  ))),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                      onPressed: () {
                        setState(() {
                          _isValid = false;
                        });
                      },
                      child: Text('change')),
                ],
              ),
            ],
          ));
    }

    return Scaffold(
      appBar: const ConfigAppBar(
        title: 'Home',
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            'assets/images/logo.jpg',
            width: 300,
          ),
          inputForm,
          if (_isValid)
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
          // const SizedBox(height: 30),
        ],
      ),
    );
  }
}
