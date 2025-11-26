import 'package:child_game/Utils/AppColors.dart';
import 'package:child_game/Utils/AppStyle.dart';
import 'package:flutter/material.dart';
import '../../Utils/AppAssets.dart';
import '../../Utils/animalCard.dart';

class ForestScreen extends StatelessWidget {
  const ForestScreen({super.key});

  static const String routeName = "ForestScreen";

  @override
  Widget build(BuildContext context) {
    Color forestThemeColor = AppColors.grayBlue; // 🌳 green forest tone
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: AppColors.darkBlue,
      appBar: AppBar(
        title:  Text(
          "🌲  الغابة",
          style: AppStyle.bold30White,
        ),
        backgroundColor: forestThemeColor,
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
                name: "Tiger",
                image: AppAssets.tiger,
                themeColor: forestThemeColor, arabicName: 'نمر',
              ),
              SizedBox(height: height *.025),
              animalCard(
                context,
                name: "Lion",
                image: AppAssets.lion,
                themeColor: forestThemeColor, arabicName: 'أسد',
              ),
              SizedBox(height: height *.025),
              animalCard(
                context,
                name: "Elephant",
                image: AppAssets.elephant,
                themeColor: forestThemeColor, arabicName: 'فيل',
              ),
              SizedBox(height: height *.025),
              animalCard(
                context,
                name: "Monkey",
                image: AppAssets.monkey,
                themeColor: forestThemeColor, arabicName: 'قرد',
              ),
              SizedBox(height: height *.025),
              animalCard(
                context,
                name: "Giraffe",
                image: AppAssets.giraffe,
                themeColor: forestThemeColor, arabicName: 'زرافة',
              ),
              SizedBox(height: height *.025),
              animalCard(
                context,
                name: "Bear",
                image: AppAssets.bear,
                themeColor: forestThemeColor, arabicName: 'دب',

              ),
              SizedBox(height: height *.025),
            ],
          ),
        ),
      ),
    );
  }
}
