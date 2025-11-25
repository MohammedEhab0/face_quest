import 'package:flutter/material.dart';

// 📺 Video Screens
import 'package:child_game/view/VideoScreens/FarmVideoScreen.dart';
import 'package:child_game/view/VideoScreens/ForestVideoScreen.dart';
import 'package:child_game/view/VideoScreens/OceanVideoScreen.dart';

// 🌍 World Screens
import 'package:child_game/view/WorldScreen/FarmScreen.dart';
import 'package:child_game/view/WorldScreen/ForestScreen.dart';
import 'package:child_game/view/WorldScreen/OceanScreen.dart';

// 🐠 AR Pages
import 'package:child_game/view/ar/ARAnimalPage.dart';

// 🏠 Core Pages
import 'package:child_game/view/HomePage.dart';
import 'package:child_game/view/onboarding_screen.dart';
import 'package:child_game/view/video_intro_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'AR Animal Adventure',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.teal),
        useMaterial3: true,
        fontFamily: 'Poppins',
      ),

      // 🌟 Start from Onboarding
      initialRoute: OnboardingScreen.routeName,

      // 🗺️ All App Routes
      routes: {
        // 🧭 Core Navigation
        OnboardingScreen.routeName: (context) => const OnboardingScreen(),
        HomePage.routeName: (context) => const HomePage(),

        // 🎬 Video Intro Screens
        FarmVideoScreen.routeName: (context) => const FarmVideoScreen(),
        OceanVideoScreen.routeName: (context) => const OceanVideoScreen(),
        ForestVideoScreen.routeName: (context) => const ForestVideoScreen(),

        // 🐾 World Screens
        FarmScreen.routeName: (context) => const FarmScreen(),
        OceanScreen.routeName: (context) => const OceanScreen(),
        ForestScreen.routeName: (context) => const ForestScreen(),


      },
    );
  }
}
