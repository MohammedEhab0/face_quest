import 'package:child_game/view/WorldScreen/FarmScreen.dart';
import 'package:flutter/material.dart';
import '../../Utils/AppColors.dart';
import '../video_intro_screen.dart';
import 'package:child_game/Utils/AppAssets.dart';
class FarmVideoScreen extends StatelessWidget {
  const FarmVideoScreen({super.key});

  static const String routeName = "FarmVideoScreen";

  @override
  Widget build(BuildContext context) {
    return  VideoIntroScreen(
      title: " المزرعة 🐄",
      videoPath: AppAssets.farmVideo,
      screen: const FarmScreen(),
      themeColor: AppColors.grayBlue, // soft green for farm theme
    );
  }
}
