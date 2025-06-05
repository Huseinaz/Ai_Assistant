import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:ai_assistant/helper/global.dart';
import 'package:ai_assistant/model/home_type.dart';
import 'package:flutter_animate/flutter_animate.dart';

class HomeCard extends StatelessWidget {
  final HomeType homeType;

  const HomeCard({super.key, required this.homeType});

  @override
  Widget build(BuildContext context) {
    Animate.restartOnHotReload = true;

    return Card(
      elevation: 0,
      color: Colors.blue.withOpacity(0.2),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(20)),
      ),
      margin: EdgeInsets.only(bottom: mq.height * 0.02),
      child: InkWell(
        borderRadius: BorderRadius.all(Radius.circular(20)),
        onTap: homeType.onTap,
        child:
            homeType.leftAlign
                ? Row(
                  children: [
                    // Lottie
                    Container(
                      width: mq.width * 0.35,
                      padding: homeType.padding,
                      child: Lottie.asset(
                        'assets/lottie/${homeType.lottie}.json',
                      ),
                    ),

                    Spacer(),

                    // Text
                    Text(
                      homeType.title,
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.black,
                        fontWeight: FontWeight.w500,
                        letterSpacing: 1,
                      ),
                    ),

                    Spacer(flex: 2),
                  ],
                )
                : Row(
                  children: [
                    Spacer(flex: 2),

                    // Text
                    Text(
                      homeType.title,
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.black,
                        fontWeight: FontWeight.w500,
                        letterSpacing: 1,
                      ),
                    ),

                    Spacer(),

                    // Lottie
                    Container(
                      width: mq.width * 0.35,
                      padding: homeType.padding,
                      child: Lottie.asset(
                        'assets/lottie/${homeType.lottie}.json',
                      ),
                    ),
                  ],
                ),
      ),
    ).animate().fade(duration: 1.seconds, curve: Curves.easeIn);
  }
}
