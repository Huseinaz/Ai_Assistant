import 'package:flutter/material.dart';
import 'package:ai_assistant/main.dart';
import 'package:ai_assistant/helper/global.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({super.key, required this.onTap, required this.text});

  final VoidCallback onTap;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Align(
      child: ElevatedButton(
        onPressed: onTap,
        style: ElevatedButton.styleFrom(
          shape: StadiumBorder(),
          elevation: 0,
          backgroundColor: Theme.of(context).buttonColor,
          minimumSize: Size(mq.width * 0.4, 50),
        ),
        child: Text(
          text,
          style: TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}
