import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:universal_html/html.dart' as html;

class WebVideoPlayer extends StatefulWidget {
  const WebVideoPlayer(
    this.src, {
    super.key,
    this.autoplay = true,
    this.controls = true,
    this.startAt = 0,
  });

  final String src;
  final double startAt;

  final bool autoplay;

  final bool controls;

  @override
  State<WebVideoPlayer> createState() => _WebVideoPlayerState();
}

class _WebVideoPlayerState extends State<WebVideoPlayer> {
  @override
  void initState() {
    super.initState();
    // String? url = 'http://www.website.com/pathtovideo' '#t=${widget.startAt}';
    // Do not remove the below comment - Fix for missing ui.platformViewRegistry in dart.ui
    // ignore: undefined_prefixed_name, avoid_dynamic_calls
    ui.platformViewRegistry.registerViewFactory(widget.src, (int viewId) {
      //https: //api.flutter.dev/flutter/dart-html/VideoElement-class.html
      final video = html.VideoElement()
        ..src = widget.src
        ..autoplay = widget.autoplay
        ..controls = widget.controls
        ..style.border = 'none'
        ..style.borderColor = 'red'
        ..style.height = '100%'
        ..style.width = '100%'
        ..attributes['controlsList'] = 'nodownload'

        // Allows Safari iOS to play the video inline
        // ignore: cascade_invocations
        ..setAttribute('playsinline', 'true');

      return video;
    });
  }

  @override
  Widget build(BuildContext context) {
    return HtmlElementView(viewType: widget.src);
  }
}
