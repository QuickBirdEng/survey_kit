import 'package:flutter/material.dart';
import 'package:survey_kit/src/model/content/image_content.dart';

class ImageWidget extends StatelessWidget {
  const ImageWidget({
    super.key,
    required this.imageContent,
  });

  final ImageContent imageContent;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: imageContent.width,
      height: imageContent.height,
      child: Image.network(
        imageContent.url,
        fit: imageContent.fit,
        width: imageContent.width,
        height: imageContent.height,
      ),
    );
  }
}
