import 'package:flutter/material.dart' hide Step;
import 'package:survey_kit/src/util/extension.dart';
import 'package:survey_kit/survey_kit.dart';

/// Renders a list of [Content] items using the builders registered in
/// [SurveyKitRegistry], separated by [spacing]. Content types without a
/// registered builder are skipped.
class ContentWidget extends StatelessWidget {
  const ContentWidget({
    super.key,
    required this.content,
    this.center = true,
    this.padding = EdgeInsets.zero,
    this.spacing = 14,
  });

  final List<Content> content;
  final bool center;
  final EdgeInsetsGeometry padding;

  /// Vertical space between two content items.
  final double spacing;

  @override
  Widget build(BuildContext context) {
    final registry = SurveyKitRegistry.of(context);
    final contentView = Padding(
      padding: padding,
      child: SizedBox(
        width: double.infinity,
        child: Column(
          mainAxisAlignment:
              center ? MainAxisAlignment.center : MainAxisAlignment.start,
          children: content
              .map((e) => registry?.createContentWidget(e))
              .whereType<Widget>()
              .withSeparator(SizedBox(height: spacing))
              .toList(),
        ),
      ),
    );

    return center ? Center(child: contentView) : contentView;
  }
}
