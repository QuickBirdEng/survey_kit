import 'package:flutter/material.dart';
import 'package:survey_kit/src/widget/platform_view_registry/platform_view_registry.dart';
import 'package:universal_html/html.dart' as html;
import 'package:visibility_detector/visibility_detector.dart';

// TODO(rinzin): Temporary fix for web until
// [https://github.com/fluttercommunity/chewie/issues/688]
// is fixed on chewie
class WebVideoPlayer extends StatefulWidget {
  const WebVideoPlayer(
    this.src, {
    super.key,
    this.autoplay = true,
    this.controls = true,
    this.startAt = 0,
    this.aspectRatio = 16 / 9,
  });

  final String src;
  final double startAt;

  final bool autoplay;

  final bool controls;
  final double aspectRatio;

  @override
  State<WebVideoPlayer> createState() => _WebVideoPlayerState();
}

class _WebVideoPlayerState extends State<WebVideoPlayer> {
  late final html.VideoElement video;

  bool _isVideoLoaded = false;

  @override
  void initState() {
    super.initState();
    final url = '${widget.src}' '#t=${widget.startAt}';

    video = html.VideoElement()
      ..src = url
      ..autoplay = widget.autoplay
      ..controls = widget.controls
      ..style.border = 'none'
      ..style.height = '100%'
      ..style.width = '100%'

      //Remove the download option from controls
      ..setAttribute('controlsList', 'nodownload')

      // Allows Safari iOS to play the video inline
      // ignore: cascade_invocations
      ..setAttribute('playsinline', 'true')
      ..addEventListener(
        'canplaythrough',
        (_) {
          setState(() {
            _isVideoLoaded = true;
          });
        },
      );

    platformViewRegistry.registerViewFactory(
      widget.src,
      (int viewId) => video,
    );
  }

  @override
  void dispose() {
    video.remove();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _isVideoLoaded
        ? AspectRatio(
            aspectRatio: widget.aspectRatio,
            child: VisibilityDetector(
              key: Key(widget.src),
              onVisibilityChanged: (info) {
                if (info.visibleFraction == 0 && mounted) {
                  video.pause();
                }
              },
              child: HtmlElementView(viewType: widget.src),
            ),
          )
        : Container(
            height: 200,
            child: const Center(
              child: CircularProgressIndicator.adaptive(),
            ),
          );
  }
}
