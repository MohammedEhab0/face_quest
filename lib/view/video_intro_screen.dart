import 'package:child_game/Utils/AppColors.dart';
import 'package:child_game/Utils/AppStyle.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class VideoIntroScreen extends StatefulWidget {
  final String title;
  final String videoPath;
  final Widget screen;
  final Color themeColor;

  const VideoIntroScreen({
    super.key,
    required this.title,
    required this.videoPath,
    required this.screen,
    this.themeColor = const Color(0xFF4DD0E1), // Default teal theme
  });

  @override
  State<VideoIntroScreen> createState() => _VideoIntroScreenState();
}

class _VideoIntroScreenState extends State<VideoIntroScreen> {
  late VideoPlayerController _controller;
  bool _isPlaying = false;

  @override
  void initState() {
    super.initState();
    _controller =
        VideoPlayerController.asset(
            widget.videoPath,
            videoPlayerOptions: VideoPlayerOptions(mixWithOthers: true),
            viewType: VideoViewType.textureView,
          )
          ..initialize().then((_) {
            setState(() {});
          })
          ..addListener(() {
            setState(() {
              _isPlaying = _controller.value.isPlaying;
            });
          });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _playPause() {
    if (_isPlaying) {
      _controller.pause();
    } else {
      _controller.play();
    }
  }

  void _replay() {
    _controller.seekTo(Duration.zero);
    _controller.play();
  }

  void _goToWorld() {
    _controller.pause();
    Navigator.push(context, MaterialPageRoute(builder: (_) => widget.screen));
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        foregroundColor: AppColors.white,
        elevation: 0,
        backgroundColor: widget.themeColor,
        title: Text(widget.title, style: AppStyle.bold30White),
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          if (_controller.value.isInitialized)
            AspectRatio(
              aspectRatio: 9 / 11,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: VideoPlayer(_controller),
              ),
            )
          else
            const CircularProgressIndicator(color: Colors.teal),

          SizedBox(height: height * .03),

          // Control Buttons
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _controlButton(
                style: AppStyle.bold24DarkBlue,
                icon: Icons.replay,
                label: "إعادة",
                color: AppColors.darkBlue,
                onPressed: _replay,
              ),
              SizedBox(width: width * .07),
              _controlButton(
                style: AppStyle.bold24GrayBlue,
                icon: _isPlaying ? Icons.pause : Icons.play_arrow,
                label: _isPlaying ? "إيقاف" : "تشغيل",
                color: widget.themeColor,
                onPressed: _playPause,
              ),
              SizedBox(width: width * .07),
              _controlButton(
                style: AppStyle.bold24LightBlue,
                icon: Icons.skip_next,
                label: "تخطي",
                color: AppColors.lightBlue,
                onPressed: _goToWorld,
              ),
            ],

          ),SizedBox(height: height * .02)
        ],
      ),
    );
  }

  Widget _controlButton({
    required IconData icon,
    required String label,
    required Color color,
    required VoidCallback onPressed,
    required TextStyle style,
  }) {
    return Column(
      children: [
        ElevatedButton(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
            backgroundColor: color,
            padding: const EdgeInsets.all(20),
            shape: const CircleBorder(),
            shadowColor: Colors.black26,
            elevation: 5,
          ),
          child: Icon(icon, size: 32, color: Colors.white),
        ),
        const SizedBox(height: 6),
        Text(label, style: style),
      ],
    );
  }
}
