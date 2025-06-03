import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ai_assistant/helper/pref.dart';
import 'package:ai_assistant/helper/global.dart';

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

    return Scaffold(body: Center(child: Text('Welcome to Home Screen!')));
  }
}
