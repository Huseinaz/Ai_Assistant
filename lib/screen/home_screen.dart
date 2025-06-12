import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ai_assistant/helper/pref.dart';
import 'package:ai_assistant/helper/global.dart';
import 'package:ai_assistant/model/home_type.dart';
import 'package:ai_assistant/widget/home_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _isDarkMode = Pref.isDarkMode.obs;

  @override
  void initState() {
    super.initState();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
    // Set onboarding to false after first use
    Pref.showOnboarding = false;
  }

  @override
  Widget build(BuildContext context) {
    // Initializing device size
    mq = MediaQuery.sizeOf(context);

    return Scaffold(
      // AppBar
      appBar: AppBar(
        title: Text(appName),

        actions: [
          IconButton(
            padding: EdgeInsets.only(right: 10),
            icon: Obx(
              () => Icon(
                _isDarkMode.value
                    ? Icons.brightness_2_rounded
                    : Icons.brightness_5_rounded,
                size: 26,
              ),
            ),
            onPressed: () {
              Get.changeThemeMode(
                _isDarkMode.value ? ThemeMode.light : ThemeMode.dark,
              );
              _isDarkMode.value = !_isDarkMode.value;
              Pref.isDarkMode = _isDarkMode.value;
            },
          ),
        ],
      ),

      // Body
      body: ListView(
        padding: EdgeInsets.symmetric(
          horizontal: mq.width * 0.04,
          vertical: mq.height * 0.015,
        ),
        children: HomeType.values.map((e) => HomeCard(homeType: e)).toList(),
      ),
    );
  }
}
