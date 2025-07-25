import 'package:flutter/material.dart';
import 'package:ai_assistant/main.dart';
import 'package:ai_assistant/helper/global.dart';
import 'package:ai_assistant/model/message.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

class MessageCard extends StatelessWidget {
  final Message message;

  const MessageCard({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    const r = Radius.circular(15);

    return message.msgType == MessageType.bot
        // Bot
        ? Row(
          children: [
            SizedBox(width: 6),

            CircleAvatar(
              radius: 18,
              backgroundColor: Colors.white,
              child: Image.asset("assets/images/logo.png", width: 24),
            ),

            Container(
              constraints: BoxConstraints(maxWidth: mq.width * 0.6),
              margin: EdgeInsets.only(
                bottom: mq.height * 0.02,
                left: mq.width * 0.02,
              ),
              padding: EdgeInsets.symmetric(
                vertical: mq.height * 0.01,
                horizontal: mq.width * 0.03,
              ),
              decoration: BoxDecoration(
                border: Border.all(color: Theme.of(context).lightTextColor),
                borderRadius: BorderRadius.only(
                  topLeft: r,
                  topRight: r,
                  bottomRight: r,
                ),
              ),
              child:
                  message.msg.isEmpty
                      ? AnimatedTextKit(
                        animatedTexts: [
                          TypewriterAnimatedText(
                            'Please wait...',
                            speed: const Duration(milliseconds: 100),
                          ),
                        ],
                        repeatForever: true,
                      )
                      : Text(message.msg),
            ),
          ],
        )
        
        // User
        : Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Container(
              constraints: BoxConstraints(maxWidth: mq.width * 0.6),
              margin: EdgeInsets.only(
                bottom: mq.height * 0.02,
                right: mq.width * 0.02,
              ),
              padding: EdgeInsets.symmetric(
                vertical: mq.height * 0.01,
                horizontal: mq.width * 0.03,
              ),
              decoration: BoxDecoration(
                border: Border.all(color: Theme.of(context).lightTextColor),
                borderRadius: BorderRadius.only(
                  topLeft: r,
                  topRight: r,
                  bottomLeft: r,
                ),
              ),
              child: Text(message.msg),
            ),

            CircleAvatar(
              radius: 18,
              backgroundColor: Colors.white,
              child: Icon(Icons.person, color: Colors.blue, size: 24),
            ),

            SizedBox(width: 6),
          ],
        );
  }
}
