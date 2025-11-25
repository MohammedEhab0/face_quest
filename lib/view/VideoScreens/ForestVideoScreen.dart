import 'package:child_game/Utils/AppAssets.dart';
import 'package:child_game/view/WorldScreen/ForestScreen.dart';
import 'package:flutter/material.dart';
import '../../Utils/AppColors.dart';
import '../video_intro_screen.dart';

class ForestVideoScreen extends StatelessWidget {
  const ForestVideoScreen({super.key});

  static const String routeName = "ForestVideoScreen";

  @override
  Widget build(BuildContext context) {
    return  VideoIntroScreen(
      title: "🌲 الغابة",
      videoPath: AppAssets.forestVideo,
      screen: const ForestScreen(),
      themeColor: AppColors.grayBlue, // teal-blue for ocean
    );
  }
}
