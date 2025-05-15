import 'package:flutter/material.dart';
import 'package:my_boot_ai/models/message_model.dart';
import 'package:my_boot_ai/providers/chat_provider.dart';
import 'package:my_boot_ai/providers/widgets/assistant_message_widget.dart';
import 'package:my_boot_ai/providers/widgets/my_message_widget.dart';

class ChatMessageWidget extends StatelessWidget {
  const ChatMessageWidget(
      {required this.scrollController, required this.chatProvider, super.key});

  final ScrollController scrollController;
  final ChatProvider chatProvider;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      controller: scrollController,
      itemBuilder: (context, index) {
        final message = chatProvider.inMessageChat[index];
        return message.role == Role.user
            ? MyMessageWidget(message)
            : AssistantMessageWidget(message);
      },
      itemCount: chatProvider.inMessageChat.length,
    );
  }
}
