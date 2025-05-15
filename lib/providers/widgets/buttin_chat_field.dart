import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:my_boot_ai/providers/chat_provider.dart';

class ButtonChatField extends StatefulWidget {
  ButtonChatField({required this.chatProvider, super.key});

  final ChatProvider chatProvider;

  // final ChangeNotifier chatProvider;

  @override
  State<ButtonChatField> createState() => _ButtonChatFieldState();
}

class _ButtonChatFieldState extends State<ButtonChatField> {
  final FocusNode focusNode = FocusNode();
  final TextEditingController controller = TextEditingController();

  @override
  void dispose() {
    focusNode.dispose();
    controller.dispose();
    super.dispose();
  }

  Future<void> sendMessage(
      {required String message,
      required ChatProvider chatProvider,
      required bool isTextOnly}) async {
    try {
      await chatProvider.sendMessage(message: message, isTextOnly: isTextOnly);
    } catch (e) {
      log('Error : $e');
    } finally {
      controller.clear();
      focusNode.unfocus();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          borderRadius: BorderRadius.circular(20),
          border:
              Border.all(color: Theme.of(context).textTheme.titleLarge!.color!),
        ),
        child: Row(
          children: [
            IconButton(
              onPressed: () {},
              icon: Icon(Icons.image),
            ),
            Expanded(
              child: TextField(
                focusNode: focusNode,
                controller: controller,
                onSubmitted: (String value) {
                  if (value.isNotEmpty) {
                    sendMessage(
                        message: controller.text,
                        chatProvider: widget.chatProvider,
                        isTextOnly: true);
                  }
                },
                decoration: InputDecoration.collapsed(
                  hintText: 'Enter Message',
                  border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                if (controller.text.isNotEmpty) {
                  sendMessage(
                      message: controller.text,
                      chatProvider: widget.chatProvider,
                      isTextOnly: true);
                }
              },
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.deepPurple,
                    borderRadius: BorderRadius.circular(20)),
                margin: const EdgeInsets.all(5.0),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Icon(
                    Icons.arrow_upward,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
