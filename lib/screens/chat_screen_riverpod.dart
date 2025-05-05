import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_boot_ai/providers/chat_provider.dart';
import 'package:my_boot_ai/providers/river_pod/chat_riverpod_provider.dart';
import 'package:my_boot_ai/providers/widgets/buttin_chat_field.dart';

class ChatScreen extends StatefulWidget {
  final String title;

  const ChatScreen({required this.title, super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, Child) {
        final chatNotifier = ref.watch(chatProvider);
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
                    child: (chatNotifier.inMessageChat.isEmpty)
                        ? Center(child: Text('no message yet ...'))
                        : ListView.builder(
                            itemBuilder: (context, index) {
                              final message = chatNotifier.inMessageChat[index];
                              return ListTile(
                                title: Text(
                                  message.message.toString(),
                                ),
                              );
                            },
                            itemCount: chatNotifier.inMessageChat.length,
                          ),
                  ),
                  ButtonChatField(
                    chatProvider: chatNotifier,
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
