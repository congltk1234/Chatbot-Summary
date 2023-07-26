import 'package:brycen_chat_app/widgets/chat_screen/toggle_button.dart';
import 'package:flutter/material.dart';

enum InputMode {
  text,
  voice,
}

class TextAndVoiceField extends StatefulWidget {
  const TextAndVoiceField({super.key});

  @override
  State<TextAndVoiceField> createState() => _TextAndVoiceFieldState();
}

class _TextAndVoiceFieldState extends State<TextAndVoiceField> {
  InputMode _inputMode = InputMode.voice;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: TextField(
            onChanged: (value) {
              value.isNotEmpty
                  ? setInputMode(InputMode.text)
                  : setInputMode(InputMode.voice);
            },
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
        ),
        ToggleButton(
          inputMode: _inputMode,
        ),
      ],
    );
  }

  void setInputMode(InputMode inputMode) {
    setState(() {
      _inputMode = inputMode;
    });
  }
}
