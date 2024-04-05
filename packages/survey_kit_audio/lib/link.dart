import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class LinkText extends StatelessWidget {
  const LinkText({super.key, required this.link});

  final String link;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return RichText(
      overflow: TextOverflow.clip,
      text: TextSpan(
        text: link,
        style: theme.textTheme.bodySmall?.copyWith(color: Colors.blue),
        recognizer: TapGestureRecognizer()
          ..onTap = () async {
            final url = Uri.parse(link);
            if (await canLaunchUrl(url)) {
              await launchUrl(url);
            }
          },
      ),
    );
  }
}
