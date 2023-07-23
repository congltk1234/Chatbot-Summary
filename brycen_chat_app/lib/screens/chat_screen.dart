import 'package:brycen_chat_app/models/model.dart';
import 'package:brycen_chat_app/widgets/app_bar.dart';
import 'package:flutter/material.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});
  static const id = 'chatpage_screen';

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final _textController = TextEditingController();
  final _scrollController = ScrollController();
  final List<ChatMessage> _messages = [];
  late bool isLoading;

  @override
  void initState() {
    super.initState();
    isLoading = false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ConfigAppBar(title: "OpenAI's ChatGPT Flutter"),
      backgroundColor: Colors.white,
      body: _buildBody(context),
    );
  }

  Widget _buildBody(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          Expanded(
            child: _buildList(),
          ),
          Visibility(
            visible: isLoading,
            child: const Padding(
              padding: EdgeInsets.all(8.0),
              child: CircularProgressIndicator(
                color: Color(0xff10a37f),
              ),
            ),
          ),
          Row(
            children: [
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Theme.of(context).colorScheme.secondary,
                  foregroundColor: Theme.of(context).colorScheme.onSecondary,
                  shape: const CircleBorder(),
                  padding: EdgeInsets.all(5),
                ),
                onPressed: () {},
                child: const Icon(Icons.mic),
              ),
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(32.0),
                  ),
                  margin: const EdgeInsets.symmetric(
                      vertical: 16.0, horizontal: 16.0),
                  padding: const EdgeInsets.symmetric(
                      vertical: 0.0, horizontal: 10.0),
                  child: Row(
                    children: [
                      _buildInput(),
                      const SizedBox(width: 5),
                      _buildSubmit(),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSubmit() {
    return Visibility(
      visible: !isLoading,
      child: Container(
        child: IconButton(
          icon: const Icon(
            Icons.send_rounded,
          ),
          onPressed: () async {
            setState(
              () {
                _messages.add(
                  ChatMessage(
                    text: _textController.text,
                    chatMessageType: ChatMessageType.user,
                  ),
                );
                isLoading = true;
              },
            );
            Future.delayed(const Duration(milliseconds: 50))
                .then((_) => _scrollDown());
            setState(() {
              isLoading = false;
              _messages.add(
                ChatMessage(
                  text: _textController.text,
                  chatMessageType: ChatMessageType.bot,
                ),
              );
              _textController.clear();
            });
          },
        ),
      ),
    );
  }

  Expanded _buildInput() {
    return Expanded(
      child: TextField(
        textCapitalization: TextCapitalization.sentences,
        autocorrect: true,
        enableSuggestions: true,
        controller: _textController,
        decoration: const InputDecoration.collapsed(hintText: 'Aa'),
      ),
    );
  }

  Widget _buildList() {
    if (_messages.isEmpty) {
      return const Center(
        child: Text('No messages found.'),
      );
    }

    return ListView.builder(
      physics: const BouncingScrollPhysics(),
      controller: _scrollController,
      itemCount: _messages.length,
      itemBuilder: (context, index) {
        var message = _messages[index];
        return ChatMessageWidget(
          text: message.text,
          chatMessageType: message.chatMessageType,
        );
      },
    );
  }

  void _scrollDown() {
    _scrollController.animateTo(
      _scrollController.position.maxScrollExtent,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeOut,
    );
  }
}

class ChatMessageWidget extends StatelessWidget {
  const ChatMessageWidget(
      {super.key, required this.text, required this.chatMessageType});

  final String text;
  final ChatMessageType chatMessageType;

  @override
  // Widget build(BuildContext context) {
  //   return Container(
  //     margin: const EdgeInsets.symmetric(vertical: 10.0),
  //     padding: const EdgeInsets.all(16),
  //     color: chatMessageType == ChatMessageType.bot
  //         ? const Color(0xff10a37f)
  //         : Colors.white,
  //     child: Row(
  //       crossAxisAlignment: CrossAxisAlignment.start,
  //       children: <Widget>[
  //         chatMessageType == ChatMessageType.bot
  //             ? Container(
  //                 margin: const EdgeInsets.only(right: 16.0),
  //                 child: CircleAvatar(
  //                   backgroundColor: const Color(0xff10a37f),
  //                   child: Image.asset(
  //                     'assets/images/logo.jpg',
  //                     scale: 1.5,
  //                   ),
  //                 ),
  //               )
  //             : Container(
  //                 margin: const EdgeInsets.only(right: 16.0),
  //                 child: const CircleAvatar(
  //                   child: Icon(
  //                     Icons.person,
  //                   ),
  //                 ),
  //               ),
  //         Expanded(
  //           child: Column(
  //             crossAxisAlignment: CrossAxisAlignment.start,
  //             children: <Widget>[
  //               Container(
  //                 padding: const EdgeInsets.all(8.0),
  //                 decoration: const BoxDecoration(
  //                   borderRadius: BorderRadius.all(Radius.circular(8.0)),
  //                 ),
  //                 child: Text(
  //                   text,
  //                   style: Theme.of(context).textTheme.bodyLarge?.copyWith(
  //                         color: chatMessageType == ChatMessageType.bot
  //                             ? Colors.white
  //                             : Colors.black,
  //                       ),
  //                 ),
  //               ),
  //             ],
  //           ),
  //         ),
  //       ],
  //     ),
  //   );
  // }
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10.0),
      padding: const EdgeInsets.all(16),
      color: chatMessageType == ChatMessageType.bot
          ? const Color(0xff10a37f)
          : Colors.white,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          chatMessageType == ChatMessageType.bot
              ? Container(
                  margin: const EdgeInsets.only(right: 16.0),
                  child: CircleAvatar(
                    backgroundColor: const Color(0xff10a37f),
                    child: Image.asset(
                      'assets/images/logo.jpg',
                      scale: 1.5,
                    ),
                  ),
                )
              : Container(
                  margin: const EdgeInsets.only(right: 16.0),
                  child: const CircleAvatar(
                    child: Icon(
                      Icons.person,
                    ),
                  ),
                ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  padding: const EdgeInsets.all(8.0),
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(8.0)),
                  ),
                  child: Text(
                    text,
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          color: chatMessageType == ChatMessageType.bot
                              ? Colors.white
                              : Colors.black,
                        ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
