import 'package:child_game/Utils/AppAssets.dart';
import 'package:child_game/Utils/AppColors.dart';
import 'package:child_game/Utils/AppStyle.dart';
import 'package:child_game/view/VideoScreens/ForestVideoScreen.dart';
import 'package:child_game/view/VideoScreens/OceanVideoScreen.dart';
import 'package:flutter/material.dart';
import 'VideoScreens/FarmVideoScreen.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});
  static const String routeName = "HomePage";

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: AppColors.grayBlue,
        title:  Text(
          "اختر عالمك",
          style:AppStyle.bold30White ,
        ),
        centerTitle: true,
      ),

      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [

            _worldButton(
              context,
              color: AppColors.lightBlue, // pastel blue
              image: AppAssets.ocean,
              label: "المحيط",
              screen: const OceanVideoScreen(),

            ),

            _worldButton(
              context,
              color: AppColors.lightBlue, // pastel green
              image: AppAssets.forest,
              label: " الغابة",
              screen: const ForestVideoScreen(),
            ),

            _worldButton(
              context,
              color: AppColors.lightBlue, // pastel yellow
              image: AppAssets.farm,
              label: " المزرعة",
              screen: const FarmVideoScreen(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _worldButton(
      BuildContext context,
      {required Color color,
        required String image,
        required String label,
        required Widget screen
      }) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return InkWell(
      onTap: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (_) => screen));
      },
      child: Container(
        height: height*.165,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(22),
        ),
        child: Center(
          child: Row(
            children: [ Padding(
              padding:  EdgeInsets.symmetric(horizontal: width*.04),
              child: Container(clipBehavior: Clip.antiAlias,decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(28)),child: Image.asset(image, height: height *.12)),
            ),
              Text(
                "$label",
                style: AppStyle.bold30White,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
