import 'package:flutter/material.dart' hide Step;
import 'package:survey_kit/src/util/extension.dart';
import 'package:survey_kit/survey_kit.dart';

class ContentWidget extends StatefulWidget {
  const ContentWidget({
    super.key,
    required this.content,
    this.center = true,
  });
  final List<Content> content;
  final bool center;

  @override
  State<ContentWidget> createState() => _ContentWidgetState();
}

class _ContentWidgetState extends State<ContentWidget> {
  @override
  Widget build(BuildContext context) {
    final contentView = SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: widget.content
            .map(
              (e) => e.createWidget(),
            )
            .withSeparator(
              const _Separator(
                height: 14,
              ),
            )
            .toList(),
      ),
    );

    return widget.center ? Center(child: contentView) : contentView;
  }
}

class _Separator extends StatelessWidget {
  const _Separator({
    required this.height,
  });

  final double height;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
    );
  }
}
