import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:survey_kit/survey_kit.dart';

class LottieWidget extends StatelessWidget {
  const LottieWidget({
    super.key,
    required this.lottieContent,
  });

  final LottieContent lottieContent;

  @override
  Widget build(BuildContext context) {
    return Lottie.asset(
      lottieContent.asset,
      package: 'survey_kit',
      repeat: lottieContent.repeat,
    );
  }
}
