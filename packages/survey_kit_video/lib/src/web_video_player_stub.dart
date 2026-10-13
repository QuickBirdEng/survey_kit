import 'package:flutter/widgets.dart';

class WebVideoPlayer extends StatelessWidget {
  const WebVideoPlayer(
    this.src, {
    super.key,
    this.autoplay = false,
    this.controls = true,
    this.loop = false,
    this.startAt = 0,
    this.aspectRatio = 16 / 9,
  });

  final String src;
  final double startAt;
  final bool autoplay;
  final bool loop;
  final bool controls;
  final double aspectRatio;

  @override
  Widget build(BuildContext context) => const SizedBox.shrink();
}
