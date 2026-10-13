import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';

class LinkText extends StatefulWidget {
  const LinkText({super.key, required this.link});

  final String link;

  @override
  State<LinkText> createState() => _LinkTextState();
}

class _LinkTextState extends State<LinkText> {
  late final TapGestureRecognizer _recognizer;

  @override
  void initState() {
    super.initState();
    _recognizer = TapGestureRecognizer()..onTap = _openLink;
  }

  @override
  void dispose() {
    _recognizer.dispose();
    super.dispose();
  }

  Future<void> _openLink() async {
    final url = Uri.tryParse(widget.link);
    if (url == null) {
      return;
    }
    try {
      await launchUrl(url);
    } on PlatformException catch (error, stackTrace) {
      FlutterError.reportError(
        FlutterErrorDetails(
          exception: error,
          stack: stackTrace,
          library: 'survey_kit',
          context: ErrorDescription('while opening a link'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Semantics(
      link: true,
      child: Text.rich(
        TextSpan(
          text: widget.link,
          style: theme.textTheme.bodySmall?.copyWith(
            color: theme.colorScheme.primary,
            decoration: TextDecoration.underline,
          ),
          recognizer: _recognizer,
        ),
        overflow: TextOverflow.clip,
      ),
    );
  }
}
