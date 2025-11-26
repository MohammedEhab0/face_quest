import 'package:child_game/Utils/AppStyle.dart';
import 'package:flutter/material.dart';
import '../view/ar/ARAnimalPage.dart';

Widget animalCard(
    BuildContext context, {
      required String arabicName,
      required String name,
      required String image,
      Color themeColor = const Color(0xFF4DD0E1),
    }) {
  double width = MediaQuery.of(context).size.width;
  double height = MediaQuery.of(context).size.height;
  return InkWell(
    borderRadius: BorderRadius.circular(28),
    splashColor: themeColor.withOpacity(0.25),
    highlightColor: themeColor.withOpacity(0.1),
    onTap: () {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => ARAnimalPage(
            animalName: name.toLowerCase(),
            themeColor: themeColor, arabicName: arabicName,
          ),
        ),
      );
    },
    child: Container(
      height: height *.165,
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.9),
        borderRadius: BorderRadius.circular(28),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.12),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          Padding(
            padding:  EdgeInsets.symmetric(horizontal:width*.05),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(28),
              child: Image.asset(
                image,
                height: height *.13,
                fit: BoxFit.cover,
              ),
            ),
          ),
          Expanded(
            child: Text(
              arabicName,
              style: AppStyle.bold30GrayBlue,
            ),
          ),
        ],
      ),
    ),
  );
}
