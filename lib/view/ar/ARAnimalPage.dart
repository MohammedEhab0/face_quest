import 'dart:math';
import 'dart:ui';
import 'package:child_game/Utils/AppColors.dart';
import 'package:child_game/Utils/AppStyle.dart';
import 'package:flutter/material.dart';
import 'package:model_viewer_plus/model_viewer_plus.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:child_game/Utils/AppAssets.dart';

class ARAnimalPage extends StatefulWidget {
  final String animalName;
  final String arabicName;
  final Color themeColor;

  const ARAnimalPage({
    super.key,
    required this.animalName,
    required this.arabicName,
    this.themeColor = const Color(0xFF4DD0E1),
  });

  @override
  State<ARAnimalPage> createState() => _ARAnimalPageState();
}

class _ARAnimalPageState extends State<ARAnimalPage>
    with SingleTickerProviderStateMixin {
  final AudioPlayer _audioPlayer = AudioPlayer();
  final AudioPlayer _celebratePlayer = AudioPlayer();

  bool _isAnimationPlaying = true;
  String? _currentAudioLabel;

  late String modelPath;
  late List<String> audioFiles;

  late AnimationController _starController;
  bool _celebrating = false;

  Color _currentBackgroundColor = AppColors.white;

  // 🔥 MUST be 3 values because you ONLY have 3 sound buttons
  List<bool> clicked = [false, false, false];

  @override
  void initState() {
    super.initState();

    modelPath = AppAssets.getModelForAnimal(widget.animalName);
    audioFiles = List.generate(3, (i) => "${widget.animalName}${i + 1}.mp3");

    _starController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    );
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    _celebratePlayer.dispose();
    _starController.dispose();
    super.dispose();
  }

  Future<void> playAudio(String file, String label, int index) async {
    await _audioPlayer.stop();
    await _audioPlayer.play(AssetSource("audio/$file"));

    setState(() {
      _currentAudioLabel = label;
      clicked[index] = true;
    });

    _audioPlayer.onPlayerComplete.listen((event) {
      if (mounted) {
        setState(() => _currentAudioLabel = null);

        // CHECK FOR CELEBRATION **AFTER AUDIO FINISHES**
        _checkForCelebration();
      }
    });
  }

  void _checkForCelebration() {
    // Celebrate ONLY if all are clicked AND no celebration is running
    if (clicked.every((e) => e) && !_celebrating) {
      _startCelebration();
    }
  }

  Future<void> _startCelebration() async {
    setState(() => _celebrating = true);

    // 🔊 تشغيل صوت الاحتفال
    _celebratePlayer.stop();
    _celebratePlayer.play(AssetSource(AppAssets.celebration));
    print("celebration sound played");
    // GOLD background
    setState(() => _currentBackgroundColor = Colors.amber.shade300);

    // Fireworks start
    _starController.forward(from: 0);

    // Keep gold longer & slower
    await Future.delayed(const Duration(seconds: 3));

    // Fade back to original (slower)
    for (int i = 0; i <= 20; i++) {
      await Future.delayed(const Duration(milliseconds: 120));
      setState(() {
        double t = i / 20;
        _currentBackgroundColor = Color.lerp(
          Colors.amber.shade300,
          AppColors.white,
          t,
        )!;
      });
    }

    // Reset celebration
    setState(() {
      _celebrating = false;
      clicked = [false, false, false];
    });
  }


  void toggleAnimation() {
    setState(() => _isAnimationPlaying = !_isAnimationPlaying);
  }

  @override
  Widget build(BuildContext context) {
    final Color buttonColor = widget.themeColor;
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: _currentBackgroundColor,
      appBar: AppBar(
        title: Text(
          "${widget.arabicName} 🐾 AR ",
          style: AppStyle.bold30White       ),
        backgroundColor: buttonColor,
        iconTheme: const IconThemeData(color: Colors.white),
        centerTitle: true,
      ),
      body: Stack(
        children: [
          Column(
            children: [
              Expanded(
                child: ModelViewer(
                  src: modelPath,
                  ar: true,
                  arModes: const ['scene-viewer', 'quick-look'],
                  cameraControls: true,
                  autoPlay: _isAnimationPlaying,
                  animationName: "Idle3",
                  alt: "A 3D model of ${widget.animalName}",
                  arPlacement: ArPlacement.floor,
                  // Prevent too much zoom-out
                  exposure: 1,
                  // Balanced brightness
                  disablePan: false,
                  arScale: ArScale.auto,orbitSensitivity: -3,

                  // Let user rotate around model
                  // ⭐ END
                  innerModelViewerHtml: """
    <button slot='ar-button' 
      style='background:#7DA0CA;border-radius:16px;border:none;position:absolute;
      font-size:18px;font-weight:bold;color:white;top:16px;right:16px;padding:10;'>
      تشغيل AR
    </button>
  """,
                ),
              ),

              _buildControls(buttonColor),SizedBox(height: height *.02,)
            ],
          ),

          if (_celebrating) _buildFireworks(),

          if (_celebrating)
            const Positioned(
              top: 40,
              left: 0,
              right: 0,
              child: Center(
                child: Text(
                  "🌟 فخورة بيك 🌟",
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    shadows: [Shadow(color: Colors.black, blurRadius: 6)],
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildControls(Color buttonColor) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: Wrap(
        spacing: 8,
        runSpacing: 8,
        children: [
          _soundButton(
            file: '${widget.animalName}1.mp3',
            index: 0,
            label: 'اسمه',
            icon: const Icon(Icons.person, color: Colors.white, size: 30),
          ),
          _soundButton(
            file: '${widget.animalName}2.mp3',
            index: 1,
            label: 'صوته',
            icon: const Icon(
              Icons.surround_sound,
              color: Colors.white,
              size: 30,
            ),
          ),
          _soundButton(
            file: '${widget.animalName}3.mp3',
            index: 2,
            label: 'المهارة',
            icon: const Icon(
              Icons.note_alt_outlined,
              color: Colors.white,
              size: 30,
            ),
          ),
        ],
      ),
    );
  }

  Widget _soundButton({
    required String file,
    required String label,
    required int index,
    required Icon icon,
  }) {
    final bool isActive = _currentAudioLabel == label;

    return ElevatedButton(
      onPressed: () => playAudio(file, label, index),
      style: ElevatedButton.styleFrom(
        backgroundColor: isActive ? Colors.green : AppColors.lightBlue,
        padding: const EdgeInsets.symmetric(vertical: 9, horizontal: 10),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
        elevation: 5,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          icon,
          const SizedBox(width: 4),
          Text(label, style: AppStyle.bold24White),
        ],
      ),
    );
  }

  Widget _buildFireworks() {
    return AnimatedBuilder(
      animation: _starController,
      builder: (_, __) {
        return CustomPaint(
          painter: FireworksPainter(_starController.value),
          child: Container(),
        );
      },
    );
  }
}

// ⭐ FIREWORKS ⭐
class FireworksPainter extends CustomPainter {
  final double progress;

  FireworksPainter(this.progress);

  @override
  void paint(Canvas canvas, Size size) {
    final rand = Random();
    final center = Offset(size.width / 2, size.height / 3);

    for (int i = 0; i < 80; i++) {
      final angle = rand.nextDouble() * pi * 2;
      final distance = lerpDouble(0, 200, progress)!;

      final dx = cos(angle) * distance;
      final dy = sin(angle) * distance;

      final pos = center.translate(dx, dy);

      final paint = Paint()
        ..color = Colors.primaries[i % Colors.primaries.length].withOpacity(
          1 - progress,
        )
        ..style = PaintingStyle.fill;

      _drawStar(canvas, pos, 6 + rand.nextDouble() * 10, paint);
    }
  }

  void _drawStar(Canvas canvas, Offset c, double r, Paint paint) {
    final path = Path();
    const int p = 5;
    final double inner = r / 2.5;

    for (int i = 0; i < p * 2; i++) {
      final double rad = i % 2 == 0 ? r : inner;
      final double a = (pi / p) * i;

      final x = c.dx + rad * cos(a);
      final y = c.dy + rad * sin(a);

      if (i == 0)
        path.moveTo(x, y);
      else
        path.lineTo(x, y);
    }
    path.close();
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(FireworksPainter old) => old.progress != progress;
}
