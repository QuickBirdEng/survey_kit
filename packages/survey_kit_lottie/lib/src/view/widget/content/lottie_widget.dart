import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:survey_kit_lottie/src/model/content/lottie_content.dart';

class LottieWidget extends StatelessWidget {
  const LottieWidget({super.key, required this.lottieContent});

  final LottieContent lottieContent;

  @override
  Widget build(BuildContext context) {
    final url = lottieContent.url;
    final asset = lottieContent.asset;

    if (url != null) {
      return Lottie.network(
        url,
        fit: BoxFit.contain,
        repeat: lottieContent.repeat,
        width: lottieContent.width,
        height: lottieContent.height,
        frameBuilder: _buildFrame,
        errorBuilder: _buildError,
      );
    }
    if (asset != null) {
      return Lottie.asset(
        asset,
        fit: BoxFit.contain,
        repeat: lottieContent.repeat,
        width: lottieContent.width,
        height: lottieContent.height,
        frameBuilder: _buildFrame,
        errorBuilder: _buildError,
      );
    }
    return _buildError(context, null, null);
  }

  Widget _buildFrame(
    BuildContext context,
    Widget child,
    LottieComposition? composition,
  ) {
    if (composition != null) {
      return child;
    }
    return SizedBox(
      width: lottieContent.width,
      height: lottieContent.height,
      child: const Center(child: CircularProgressIndicator.adaptive()),
    );
  }

  Widget _buildError(
    BuildContext context,
    Object? error,
    StackTrace? stackTrace,
  ) {
    return SizedBox(
      width: lottieContent.width,
      height: lottieContent.height,
      child: const Center(child: Icon(Icons.broken_image_outlined)),
    );
  }
}
