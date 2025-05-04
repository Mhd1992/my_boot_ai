import 'package:flutter/material.dart';
import 'package:my_boot_ai/providers/chat_provider.dart';

class ButtonChatField extends StatefulWidget {
  ButtonChatField({required this.chatProvider, super.key});

  final ChatProvider chatProvider;

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
                decoration: InputDecoration.collapsed(
                  hintText: 'enter promb',
                  border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
              ),
            ),
            GestureDetector(
              onTap: () {},
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
