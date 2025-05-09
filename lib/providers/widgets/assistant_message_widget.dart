import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:my_boot_ai/models/message_model.dart';

class AssistantMessageWidget extends StatefulWidget {
  const AssistantMessageWidget(this.messageModel, {super.key});

  final MessageModel messageModel;

  @override
  State<AssistantMessageWidget> createState() => _AssistantMessageWidgetState();
}

class _AssistantMessageWidgetState extends State<AssistantMessageWidget> {
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topLeft,
      child: Container(
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width * 0.8,
        ),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surfaceContainerHigh,
          borderRadius: BorderRadius.circular(18),
        ),
        padding: EdgeInsets.all(15),
        margin: EdgeInsets.only(bottom: 8),
        child: widget.messageModel.message.isEmpty
            ? SizedBox(
                width: 50,
                child: SpinKitThreeBounce(
                  color: Colors.blueGrey,
                  size: 20,
                ),
              )
            : MarkdownBody(
                selectable: true,
                data: widget.messageModel.message.toString(),
              ),
      ),
    );
  }
}
