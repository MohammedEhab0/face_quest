import 'package:child_game/Utils/AppColors.dart';
import 'package:child_game/Utils/AppStyle.dart';
import 'package:flutter/material.dart';
import '../../Utils/AppAssets.dart';
import '../../Utils/animalCard.dart';

class FarmScreen extends StatelessWidget {
  const FarmScreen({super.key});

  static const String routeName = "FarmScreen";

  @override
  Widget build(BuildContext context) {
     Color farmThemeColor = AppColors.grayBlue; // Green for Farm world
     double height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: AppColors.darkBlue,
      appBar: AppBar(
        backgroundColor: farmThemeColor,
        foregroundColor: AppColors.white,
        title:  Text(
          "🌾 المزرعة",
          style: AppStyle.bold30White,
        ),
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
                name: "Horse",
                image: AppAssets.horse,
                themeColor: farmThemeColor, arabicName: 'حصان',
              ),
              SizedBox(height: height *.025),
              animalCard(
                context,
                name: "Chick",
                image: AppAssets.chick,
                themeColor: farmThemeColor, arabicName: 'كتكوت',
              ),
              SizedBox(height: height *.025),
              animalCard(
                context,
                name: "Rooster",
                image: AppAssets.rooster,
                themeColor: farmThemeColor, arabicName: 'ديك',
              ),
              SizedBox(height: height *.025),
              animalCard(
                context,
                name: "Cow",
                image: AppAssets.cow,
                themeColor: farmThemeColor, arabicName: 'بقرة',
              ),
              SizedBox(height: height *.025),
              animalCard(
                context,
                name: "Sheep",
                image: AppAssets.sheep,
                themeColor: farmThemeColor, arabicName: 'خروف',
              ),
              SizedBox(height: height *.025),
              animalCard(
                context,
                name: "Rabbit",
                image: AppAssets.rabbit,
                themeColor: farmThemeColor, arabicName: 'أرنب',
              ),
              SizedBox(height: height *.025),
            ],
          ),
        ),
      ),
    );
  }
}
