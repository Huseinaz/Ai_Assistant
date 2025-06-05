import 'package:get/get.dart';
import 'package:flutter/widgets.dart';
import 'package:ai_assistant/screen/feature/image_feature.dart';
import 'package:ai_assistant/screen/feature/chatbot_feature.dart';
import 'package:ai_assistant/screen/feature/translator_feature.dart';

enum HomeType { aiChatBot, aiImage, aiTranslator }

extension MyHomeType on HomeType {
  // Title
  String get title => switch (this) {
    HomeType.aiChatBot => 'AI ChatBot',
    HomeType.aiImage => 'AI Image Creator',
    HomeType.aiTranslator => 'Language Translator',
  };

  // Lottie
  String get lottie => switch (this) {
    HomeType.aiChatBot => 'ai_hand_waving',
    HomeType.aiImage => 'ai_play',
    HomeType.aiTranslator => 'ai_ask_me',
  };

  // For Alignment
  bool get leftAlign => switch (this) {
    HomeType.aiChatBot => true,
    HomeType.aiImage => false,
    HomeType.aiTranslator => true,
  };

  // For Padding
  EdgeInsets get padding => switch (this) {
    HomeType.aiChatBot => EdgeInsets.zero,
    HomeType.aiImage => EdgeInsets.all(20),
    HomeType.aiTranslator => EdgeInsets.zero,
  };

  // For Navigation
  VoidCallback get onTap => switch (this) {
    HomeType.aiChatBot => () => Get.to(() => ChatBotFeature()),
    HomeType.aiImage => () => Get.to(() => ImageFeature()),
    HomeType.aiTranslator => () => Get.to(() => TranslatorFeature()),
  };
}
