import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import '../Utils/AppAssets.dart';
import '../Utils/AppColors.dart';
import '../Utils/AppStyle.dart';
import 'HomePage.dart';

class OnboardingScreen extends StatelessWidget {
  static const String routeName = "Onboarding";

  const OnboardingScreen({super.key});

  Future<void> _requestPermissions(BuildContext context) async {
    // طلب الأذونات الأساسية
    Map<Permission, PermissionStatus> statuses = await [
      Permission.camera,       // للواقع المعزز AR
      // لتشغيل الأصوات أو التسجيل
    ].request();

    // التحقق هل جميع الأذونات مقبولة؟
    bool allGranted = statuses.values.every((status) => status.isGranted);

    if (allGranted) {
      Navigator.pushReplacementNamed(context, HomePage.routeName);
    } else {
      _showPermissionRequiredDialog(context);
    }
  }

  void _showPermissionRequiredDialog(BuildContext context) {

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("الأذونات مطلوبة"),
          content: Text(
            "يجب السماح بالأذونات حتى يعمل التطبيق بشكل صحيح.\n"
                "من فضلك اضغط (سماح) عند طلب الإذن.",
            textDirection: TextDirection.rtl,
          ),
          actions: [
            TextButton(
              child: Text("حسنًا"),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            TextButton(
              child: Text("إعدادات"),
              onPressed: () {
                openAppSettings();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: height*.02),

              /// ---------------------- TOP IMAGES ----------------------
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _worldCircle(AppAssets.farmWorld),
                  _worldCircle(AppAssets.seaWorld),
                ],
              ),

              SizedBox(height: height*.005),

              _worldCircle(AppAssets.forestWorld),

              SizedBox(height: height*.02),

              /// ---------------------- TITLE ----------------------
              Text(
                "أهلاً بكم!",
                style: AppStyle.bold30DarkBlue.copyWith(fontSize: 32),
                textDirection: TextDirection.rtl,
              ),

              SizedBox(height: height*.015),

              /// ---------------------- BODY TEXT ----------------------
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Text(
                  "هنا يبدأ المكان الذي سيتمكّن\n"
                      "فيه طفلكم من التعلّم خطوة بخطوة\n"
                      "لنبدأ معًا رحلة بسيطة بتفاصيلها كبيرة\n"
                      "بأثرها💙",
                  textAlign: TextAlign.center,
                  textDirection: TextDirection.rtl,
                  style: AppStyle.bold24DarkBlue.copyWith(fontSize: 20),
                ),
              ),

              /// ---------------------- STARS ----------------------
              Image.asset(
                AppAssets.stars,
                fit: BoxFit.fitWidth,
              ), SizedBox(height: height*.015),

              /// ---------------------- START BUTTON ----------------------
              Padding(
                padding: const EdgeInsets.only(bottom: 20),
                child: ElevatedButton(
                  onPressed: () => _requestPermissions(context),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.darkBlue,
                    padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                  ),
                  child: Text(
                    "ابدأ الرحلة",
                    style: AppStyle.bold24White,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// ---------------------- WORLD IMAGE CIRCLE ----------------------
  Widget _worldCircle(String assetPath) {
    return Container(
      width: 130,
      height: 130,
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 6,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: ClipOval(
        child: Image.asset(assetPath, fit: BoxFit.cover),
      ),
    );
  }
}
