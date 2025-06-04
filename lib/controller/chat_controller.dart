import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ai_assistant/apis/apis.dart';
import 'package:ai_assistant/model/message.dart';

class ChatController extends GetxController {
  final textC = TextEditingController();

  final list =
      <Message>[
        Message(msg: 'Hello, How can I help you?', msgType: MessageType.bot),
      ].obs;

  Future<void> askQuestion() async {
    if (textC.text.trim().isNotEmpty) {
      // User
      list.add(Message(msg: textC.text, msgType: MessageType.user));
      list.add(Message(msg: 'Please wait...', msgType: MessageType.bot));

      final res = await APIs.getAnswer(textC.text);

      // AI Bot
      list.removeLast();
      list.add(Message(msg: res, msgType: MessageType.bot));
      
      // Clear text field
      textC.clear();
    }
  }
}
