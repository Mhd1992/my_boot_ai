import 'package:flutter/material.dart';
import 'package:my_boot_ai/models/message_model.dart';
import 'package:my_boot_ai/providers/chat_provider.dart';
import 'package:my_boot_ai/providers/widgets/assistant_message_widget.dart';
import 'package:my_boot_ai/providers/widgets/buttin_chat_field.dart';
import 'package:my_boot_ai/providers/widgets/chat_message_widget.dart';
import 'package:my_boot_ai/providers/widgets/my_message_widget.dart';
import 'package:provider/provider.dart';

class ChatScreen extends StatefulWidget {
  final String title;

  const ChatScreen({required this.title, super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final ScrollController _scrollController = ScrollController();

  @override
  void dispose() {
    // TODO: implement dispose
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollToBottom() {
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      if (_scrollController.hasClients &&
          _scrollController.position.maxScrollExtent > 0) {
        _scrollController.animateTo(_scrollController.position.maxScrollExtent,
            duration: Duration(microseconds: 300), curve: Curves.easeOut);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ChatProvider>(
      builder: (context, chatProvider, child) {
        if (chatProvider.inMessageChat.isNotEmpty) {
          _scrollToBottom();
        }

        chatProvider.addListener(() {
          if (chatProvider.inMessageChat.isNotEmpty) {
            _scrollToBottom();
          }
        });

        return Scaffold(
          appBar: AppBar(
            backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
            centerTitle: true,
            title: Text(widget.title),
          ),
          body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: SafeArea(
              child: Column(
                children: [
                  Expanded(
                      child: (chatProvider.inMessageChat.isEmpty)
                          ? Center(
                              child: Text('No Message'),
                            )
                          : ChatMessageWidget(
                              scrollController: _scrollController,
                              chatProvider: chatProvider)),
                  ButtonChatField(
                    chatProvider: chatProvider,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
