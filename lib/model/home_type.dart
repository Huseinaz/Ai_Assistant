import 'package:flutter/widgets.dart';

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
}
