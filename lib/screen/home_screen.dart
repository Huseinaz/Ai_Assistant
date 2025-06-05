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
        elevation: 1,
        centerTitle: true,
        title: Text(
          appName,
          style: TextStyle(
            fontSize: 20,
            color: Colors.blue,
            fontWeight: FontWeight.w500,
          ),
        ),
        actions: [
          IconButton(
            padding: EdgeInsets.only(right: 10),
            icon: Icon(
              Icons.brightness_4_rounded,
              color: Colors.blue,
              size: 26,
            ),
            onPressed: () {},
          ),
        ],
        backgroundColor: Colors.white,
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
