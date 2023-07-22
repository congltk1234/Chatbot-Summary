import 'package:flutter/material.dart';

class NewMessage extends StatefulWidget {
  const NewMessage({super.key});

  @override
  State<StatefulWidget> createState() {
    return _NewMessageState();
  }
}

class _NewMessageState extends State<NewMessage> {
  var _messageController = TextEditingController();

  @override
  void dispose() {
    _messageController.dispose();
    super.dispose();
  }

  void _submitMessage() {
    final enteredMessage = _messageController.text;

    if (enteredMessage.trim().isEmpty) {
      return;
    }
    // send to fitebase
    _messageController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return // input box
        Container(
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(32.0),
      ),
      margin: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
      padding: const EdgeInsets.symmetric(vertical: 0.0, horizontal: 16.0),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _messageController,
              decoration: const InputDecoration.collapsed(hintText: 'Aa'),
            ),
          ),
          IconButton(
              icon: const Icon(Icons.send),
              onPressed: () {
                _submitMessage;
              }
              // listen to apikey to see if changed
              // Provider.of<ConversationProvider>(context, listen: true)
              //             .yourApiKey ==
              //         "YOUR_API_KEY"
              //     ? () {
              //         showRenameDialog(context);
              //       }
              //     : () {
              //         _sendMessageAndAddToChat();
              //       },
              ),
        ],
      ),
    );
    // return Padding(
    //   padding: const EdgeInsets.only(left: 15, right: 1, bottom: 14),
    //   child: Row(
    //     children: [
    //       const Expanded(
    //           child: TextField(
    //         textCapitalization: TextCapitalization.sentences,
    //         autocorrect: true,
    //         enableSuggestions: true,
    //         decoration: InputDecoration(labelText: 'Send a message...'),
    //       )),
    //       IconButton(onPressed: _submitMessage, icon: const Icon(Icons.send))
    //     ],
    //   ),
    // );
  }
}
