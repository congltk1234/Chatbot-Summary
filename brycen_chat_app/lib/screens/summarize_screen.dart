import 'package:brycen_chat_app/widgets/app_bar.dart';
import 'package:flutter/material.dart';

class SummarizeScreen extends StatefulWidget {
  const SummarizeScreen({super.key});
  static const id = 'summarize_screen';

  @override
  State<StatefulWidget> createState() {
    return _SummarizeScreenstate();
  }
}

class _SummarizeScreenstate extends State<SummarizeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ConfigAppBar(title: 'Summarize Screen'),
    );
  }
}
