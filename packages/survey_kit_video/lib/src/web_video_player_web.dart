import 'dart:js_interop';

import 'package:flutter/material.dart';
import 'package:web/web.dart' as web;

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
  web.HTMLVideoElement? _video;
  String? _appliedUrl;
  bool _isLoaded = false;
  bool _hasError = false;

  late final JSFunction _onLoadedMetadata = ((web.Event _) {
    if (mounted) {
      setState(() => _isLoaded = true);
    }
  }).toJS;

  late final JSFunction _onError = ((web.Event _) {
    if (mounted) {
      setState(() => _hasError = true);
    }
  }).toJS;

  @override
  void didUpdateWidget(covariant WebVideoPlayer oldWidget) {
    super.didUpdateWidget(oldWidget);
    final video = _video;
    if (video == null) {
      return;
    }
    if (oldWidget.src != widget.src || oldWidget.startAt != widget.startAt) {
      _isLoaded = false;
      _hasError = false;
    }
    _configure(video);
  }

  @override
  void dispose() {
    final video = _video;
    if (video != null) {
      video
        ..removeEventListener('loadedmetadata', _onLoadedMetadata)
        ..removeEventListener('error', _onError)
        ..pause();
    }
    super.dispose();
  }

  void _onElementCreated(Object element) {
    final video = element as web.HTMLVideoElement;
    _video = video;
    video
      ..addEventListener('loadedmetadata', _onLoadedMetadata)
      ..addEventListener('error', _onError)
      ..setAttribute('controlsList', 'nodownload')
      ..playsInline = true
      ..style.border = 'none'
      ..style.height = '100%'
      ..style.width = '100%';
    _configure(video);
  }

  void _configure(web.HTMLVideoElement video) {
    final url = '${widget.src}#t=${widget.startAt}';
    if (_appliedUrl != url) {
      _appliedUrl = url;
      video.src = url;
    }
    video
      ..autoplay = widget.autoplay
      ..loop = widget.loop
      ..controls = widget.controls;
  }

  void _retry() {
    final video = _video;
    if (video == null) {
      return;
    }
    setState(() {
      _hasError = false;
      _isLoaded = false;
    });
    video.load();
  }

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: widget.aspectRatio,
      child: Stack(
        alignment: Alignment.center,
        children: [
          HtmlElementView.fromTagName(
            tagName: 'video',
            onElementCreated: _onElementCreated,
          ),
          if (_hasError)
            IconButton(
              iconSize: 48,
              icon: const Icon(Icons.refresh),
              onPressed: _retry,
            )
          else if (!_isLoaded)
            const CircularProgressIndicator.adaptive(),
        ],
      ),
    );
  }
}
