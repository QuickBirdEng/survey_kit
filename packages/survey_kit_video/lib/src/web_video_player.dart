import 'dart:ui_web';

import 'package:flutter/material.dart';
import 'package:universal_html/html.dart' as html;

// TODO(rinzin): Temporary fix for web until
// [https://github.com/fluttercommunity/chewie/issues/688]
// is fixed on chewie
class WebVideoPlayer extends StatefulWidget {
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
  State<WebVideoPlayer> createState() => _WebVideoPlayerState();
}

class _WebVideoPlayerState extends State<WebVideoPlayer> {
  bool isLoaded = false;
  @override
  void initState() {
    super.initState();
    platformViewRegistry.registerViewFactory(
      widget.src,
      (int viewId) {
        final url = '${widget.src}' '#t=${widget.startAt}';
        final video = html.VideoElement()
          ..src = url
          ..autoplay = widget.autoplay
          ..loop = widget.loop
          ..controls = widget.controls
          ..style.border = 'none'
          ..style.height = '100%'
          ..style.width = '100%'

          //Remove the download option from controls
          ..setAttribute('controlsList', 'nodownload')

          // Allows Safari iOS to play the video inline
          // ignore: cascade_invocations
          ..setAttribute('playsinline', 'true');

        return video;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        AspectRatio(
          aspectRatio: widget.aspectRatio,
          child: HtmlElementView(
            onPlatformViewCreated: (id) {
              setState(() {
                isLoaded = true;
              });
            },
            viewType: widget.src,
          ),
        ),
        if (!isLoaded)
          const Center(
            child: CircularProgressIndicator.adaptive(),
          ),
      ],
    );
  }
}
