import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:flutter/material.dart';
import 'package:ai_assistant/main.dart';
import 'package:ai_assistant/helper/global.dart';
import 'package:ai_assistant/model/onboard.dart';
import 'package:ai_assistant/screen/home_screen.dart';
import 'package:ai_assistant/widget/custom_button.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final c = PageController();

    final list = [
      // Onboarding 1
      Onboard(
        title: 'Ask Me Anything',
        subtitle:
            'I can be your Best Friend & You can ask me anything & I will help you!',
        lottie: 'ai_ask_me',
      ),

      // Onboarding 2
      Onboard(
        title: 'Imagination to Reality',
        subtitle:
            'Just Imagine anything & let me know, I will create something wonderful for you!',
        lottie: 'ai_play',
      ),
    ];

    return Scaffold(
      body: PageView.builder(
        controller: c,
        itemCount: list.length,
        itemBuilder: (ctx, ind) {
          final isLast = ind == list.length - 1;

          return Column(
            children: [
              // Lottie
              Lottie.asset(
                'assets/lottie/${list[ind].lottie}.json',
                height: mq.height * 0.6,
                width: isLast ? mq.width * 0.7 : null,
              ),

              // Title
              Text(
                list[ind].title,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w900,
                  letterSpacing: 0.5,
                ),
              ),

              SizedBox(height: mq.height * 0.015),

              // Subtitle
              SizedBox(
                width: mq.width * 0.7,
                child: Text(
                  list[ind].subtitle,
                  style: TextStyle(
                    fontSize: 13.5,
                    color: Theme.of(context).lightTextColor,
                    letterSpacing: 0.5,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),

              Spacer(),

              // Dots
              Wrap(
                spacing: 10,
                children: List.generate(
                  list.length,
                  (i) => Container(
                    width: i == ind ? 15 : 10,
                    height: 8,
                    decoration: BoxDecoration(
                      color:
                          i == ind
                              ? Theme.of(context).buttonColor
                              : Colors.grey,
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                ),
              ),

              Spacer(),

              // Button
              CustomButton(
                onTap: () {
                  if (isLast) {
                    // If last page, navigate to HomeScreen
                    Get.off(() => HomeScreen());
                  } else {
                    // Go to next page
                    c.nextPage(
                      duration: Duration(milliseconds: 600),
                      curve: Curves.ease,
                    );
                  }
                },
                text: isLast ? 'Get Started' : 'Next',
              ),

              Spacer(flex: 2),
            ],
          );
        },
      ),
    );
  }
}
