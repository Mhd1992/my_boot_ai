import 'package:flutter/material.dart';
import 'package:my_boot_ai/providers/chat_provider.dart';
import 'package:my_boot_ai/providers/widgets/buttin_chat_field.dart';
import 'package:provider/provider.dart';

class ChatScreen extends StatefulWidget {
  final String title;

  const ChatScreen({required this.title, super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  @override
  Widget build(BuildContext context) {
    return Consumer<ChatProvider>(
      builder: (context, chatProvider, child) {
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
                        ? Center(child: Text('no message yet ...'))
                        : ListView.builder(
                            itemBuilder: (context, index) {
                              final message = chatProvider.inMessageChat[index];
                              return ListTile(
                                title: Text(
                                  message.message.toString(),
                                ),
                              );
                            },
                            itemCount: chatProvider.inMessageChat.length,
                          ),
                  ),
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
