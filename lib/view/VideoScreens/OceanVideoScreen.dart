import 'package:child_game/Utils/AppColors.dart';
import 'package:child_game/view/WorldScreen/OceanScreen.dart';
import 'package:flutter/material.dart';
import '../video_intro_screen.dart';
import 'package:child_game/Utils/AppAssets.dart';
class OceanVideoScreen extends StatelessWidget {
  const OceanVideoScreen({super.key});

  static const String routeName = "OceanVideoScreen";

  @override
  Widget build(BuildContext context) {
    return  VideoIntroScreen(
      title: "المحيط 🐠",
      videoPath: AppAssets.oceanVideo,
      screen: const OceanScreen(),
      themeColor: AppColors.grayBlue, // teal-blue for ocean
    );
  }
}
