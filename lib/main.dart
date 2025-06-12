import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ai_assistant/helper/pref.dart';
import 'package:ai_assistant/helper/global.dart';
import 'package:ai_assistant/screen/splash_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Hive
  Pref.initialize();

  await SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: appName,
      debugShowCheckedModeBanner: false,

      themeMode: Pref.defaultTheme,

      // dark
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        appBarTheme: AppBarTheme(
          elevation: 1,
          centerTitle: true,
          titleTextStyle: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
        ),
      ),

      // light
      theme: ThemeData(
        appBarTheme: AppBarTheme(
          elevation: 1,
          centerTitle: true,
          backgroundColor: Colors.white,
          titleTextStyle: TextStyle(
            fontSize: 20,
            color: Colors.blue,
            fontWeight: FontWeight.w500,
          ),
          iconTheme: IconThemeData(color: Colors.blue),
        ),
      ),

      home: SplashScreen(),
    );
  }
}

extension AppTheme on ThemeData {
  // Light text color
  Color get lightTextColor =>
      brightness == Brightness.dark ? Colors.white70 : Colors.black54;

  Color get lightTextColor2 =>
      brightness == Brightness.dark ? Colors.white : Colors.black;

  // Button color
  Color get buttonColor =>
      brightness == Brightness.dark
          ? Colors.cyan.withOpacity(0.5)
          : Colors.blue;
}
