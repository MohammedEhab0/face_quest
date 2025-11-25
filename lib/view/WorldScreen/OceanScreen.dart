import 'package:child_game/Utils/AppColors.dart';
import 'package:child_game/Utils/AppStyle.dart';
import 'package:flutter/material.dart';
import '../../Utils/AppAssets.dart';
import '../../Utils/animalCard.dart';

class OceanScreen extends StatelessWidget {
  const OceanScreen({super.key});

  static const String routeName = "OceanScreen";

  @override
  Widget build(BuildContext context) {
     Color oceanThemeColor = AppColors.lightBlue; // 🌊 Soft ocean blue

    return Scaffold(
      backgroundColor: AppColors.darkBlue,
      appBar: AppBar(
        title:  Text(
          "🌊 المحيط",
          style: AppStyle.bold30White,
        ),
        backgroundColor: oceanThemeColor,
        foregroundColor: AppColors.white,
        centerTitle: true,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(18),
        child: SingleChildScrollView(
          child: Column(
            children: [
              animalCard(
                context,
                name: "Turtle",
                image: AppAssets.turtle,
                themeColor: oceanThemeColor, arabicName: 'سلحفاة',
              ),
              const SizedBox(height: 20),
              animalCard(
                context,
                name: "Dolphin",
                image: AppAssets.dolphin,
                themeColor: oceanThemeColor, arabicName: 'دولفين',
              ),
              const SizedBox(height: 20),
              animalCard(
                context,
                name: "Octopus",
                image: AppAssets.octopus,
                themeColor: oceanThemeColor, arabicName: 'أخطبوط',
              ),
              const SizedBox(height: 20),
              animalCard(
                context,
                name: "Crab",
                image: AppAssets.crab,
                themeColor: oceanThemeColor, arabicName: 'كابوريا',
              ),
              const SizedBox(height: 20),
              animalCard(
                context,
                name: "Shark",
                image: AppAssets.shark,
                themeColor: oceanThemeColor, arabicName: 'قرش',
              ),
              const SizedBox(height: 20),
              animalCard(
                context,
                name: "Whale",
                image: AppAssets.whale,
                themeColor: oceanThemeColor, arabicName: 'حوت',
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
