import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:my_boot_ai/models/message_model.dart';

class MyMessageWidget extends StatefulWidget {
  const MyMessageWidget(this.messageModel, {super.key});
  final MessageModel messageModel;

  @override
  State<MyMessageWidget> createState() => _MyMessageWidgetState();
}

class _MyMessageWidgetState extends State<MyMessageWidget> {
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: Container(
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width * 0.7,
        ),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.primaryContainer,
          borderRadius: BorderRadius.circular(18),
        ),
        padding: EdgeInsets.all(15),
        margin: EdgeInsets.only(bottom: 8),
        child: MarkdownBody(
          selectable: true,
          data: widget.messageModel.message.toString(),
        ),
      ),
    );
  }
}
