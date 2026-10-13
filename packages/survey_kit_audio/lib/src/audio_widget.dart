import 'dart:async';
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:survey_kit/survey_kit.dart';
import 'package:survey_kit_audio/src/audio_content.dart';

class AudioWidget extends StatefulWidget {
  const AudioWidget({super.key, required this.audioContent});

  final AudioContent audioContent;

  @override
  State<AudioWidget> createState() => _AudioWidgetState();
}

class _AudioWidgetState extends State<AudioWidget> {
  final AudioPlayer _player = AudioPlayer();
  final List<StreamSubscription<Object?>> _subscriptions = [];
  int _loadGeneration = 0;
  bool _isLoading = true;
  bool _hasError = false;
  bool _isPlaying = false;
  bool _isCompleted = false;
  Duration _duration = Duration.zero;
  Duration _position = Duration.zero;

  @override
  void initState() {
    super.initState();
    _subscriptions
      ..add(
        _player.playerStateStream.listen((state) {
          if (!mounted) {
            return;
          }
          setState(() {
            _isPlaying = state.playing;
            _isCompleted = state.processingState == ProcessingState.completed;
          });
        }),
      )
      ..add(
        _player.durationStream.listen((duration) {
          if (mounted) {
            setState(() => _duration = duration ?? Duration.zero);
          }
        }),
      )
      ..add(
        _player.positionStream.listen((position) {
          if (mounted) {
            setState(() => _position = position);
          }
        }),
      );
    _load();
  }

  @override
  void didUpdateWidget(covariant AudioWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.audioContent.url != widget.audioContent.url) {
      _isLoading = true;
      _hasError = false;
      _load();
    }
  }

  Future<void> _load() async {
    final generation = ++_loadGeneration;
    try {
      await _player.setUrl(widget.audioContent.url);
    } catch (_) {
      if (mounted && generation == _loadGeneration) {
        setState(() {
          _isLoading = false;
          _hasError = true;
        });
      }
      return;
    }
    if (!mounted || generation != _loadGeneration) {
      return;
    }
    setState(() => _isLoading = false);
    if (widget.audioContent.autoPlay) {
      unawaited(_player.play());
    }
  }

  void _retry() {
    setState(() {
      _isLoading = true;
      _hasError = false;
    });
    _load();
  }

  Future<void> _togglePlayback() async {
    if (_isPlaying && !_isCompleted) {
      await _player.pause();
      return;
    }
    if (_isCompleted) {
      await _player.seek(Duration.zero);
    }
    await _player.play();
  }

  @override
  void dispose() {
    for (final subscription in _subscriptions) {
      subscription.cancel();
    }
    _player.dispose();
    super.dispose();
  }

  String _formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
    final twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
    return '$twoDigitMinutes:$twoDigitSeconds';
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final title = widget.audioContent.title;
    final subtitle = widget.audioContent.subtitle;
    final externalLink = widget.audioContent.externalLink;

    return Column(
      children: [
        if (title != null) ...[
          SelectableText(title, style: theme.textTheme.titleLarge),
          smallVerticalSpacer,
        ],
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: theme.cardColor,
            borderRadius: BorderRadius.circular(12),
            boxShadow: const [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 8,
                offset: Offset(0, 4),
              ),
            ],
          ),
          child: _buildPlayer(),
        ),
        if (externalLink != null) ...[
          smallVerticalSpacer,
          LinkText(link: externalLink),
        ],
        if (subtitle != null) ...[
          smallVerticalSpacer,
          SelectableText(subtitle, style: theme.textTheme.bodyMedium),
        ],
      ],
    );
  }

  Widget _buildPlayer() {
    if (_hasError) {
      return Column(
        children: [
          const Icon(Icons.music_off_outlined, size: 48),
          IconButton(icon: const Icon(Icons.refresh), onPressed: _retry),
        ],
      );
    }

    final maxSeconds = _duration.inSeconds.toDouble();
    final positionSeconds = math.min(
      _position.inSeconds.toDouble(),
      maxSeconds,
    );
    final showPause = _isPlaying && !_isCompleted;

    return Column(
      children: [
        SizedBox(
          height: 64,
          child: Center(
            child: _isLoading
                ? const CircularProgressIndicator.adaptive()
                : IconButton(
                    iconSize: 48,
                    icon: Icon(
                      showPause
                          ? Icons.pause_circle_filled
                          : Icons.play_circle_filled,
                    ),
                    onPressed: _togglePlayback,
                  ),
          ),
        ),
        Slider(
          value: positionSeconds,
          max: maxSeconds,
          onChanged: maxSeconds > 0
              ? (value) => _player.seek(Duration(seconds: value.toInt()))
              : null,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(_formatDuration(_position)),
              Text(_formatDuration(_duration)),
            ],
          ),
        ),
      ],
    );
  }
}
