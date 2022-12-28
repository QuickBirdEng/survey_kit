import 'dart:async';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';

class SurveyKitAudioPlayer extends StatefulWidget {
  const SurveyKitAudioPlayer({
    super.key,
    required this.audioUrl,
  });
  final String audioUrl;

  @override
  State<SurveyKitAudioPlayer> createState() => _SurveyKitAudioPlayerState();
}

class _SurveyKitAudioPlayerState extends State<SurveyKitAudioPlayer> {
  late final AudioPlayer player;
  late final Future<void> audioReady;

  @override
  void initState() {
    super.initState();
    player = AudioPlayer();
    audioReady = player.setSourceUrl(widget.audioUrl);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      width: double.infinity,
      child: FutureBuilder<void>(
        future: audioReady,
        builder: (_, snapshot) {
          if (ConnectionState.done == snapshot.connectionState) {
            return _PlayerWidget(
              player: player,
            );
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}

class _PlayerWidget extends StatefulWidget {
  final AudioPlayer player;

  const _PlayerWidget({
    required this.player,
  });

  @override
  State<StatefulWidget> createState() {
    return _PlayerWidgetState();
  }
}

class _PlayerWidgetState extends State<_PlayerWidget>
    with SingleTickerProviderStateMixin {
  Duration? _duration;
  Duration? _position;

  PlayerState _playerState = PlayerState.stopped;
  StreamSubscription? _durationSubscription;
  StreamSubscription? _positionSubscription;
  StreamSubscription? _playerCompleteSubscription;
  StreamSubscription? _playerStateChangeSubscription;

  bool get _isPlaying => _playerState == PlayerState.playing;
  String get _durationText =>
      _duration?.toString().split('.').first ?? '0:00:00';
  String get _positionText =>
      _position?.toString().split('.').first ?? '0:00:00';

  AudioPlayer get player => widget.player;

  late final AnimationController controller;
  late final Animation<double> animation;

  @override
  void initState() {
    super.initState();
    _initStreams();

    controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 100),
    );
    animation = Tween<double>(begin: 0.0, end: 1.0).animate(controller);
  }

  @override
  void setState(VoidCallback fn) {
    // Subscriptions only can be closed asynchronously,
    // therefore events can occur after widget has been disposed.
    if (mounted) {
      super.setState(fn);
    }
  }

  @override
  void dispose() {
    _durationSubscription?.cancel();
    _positionSubscription?.cancel();
    _playerCompleteSubscription?.cancel();
    _playerStateChangeSubscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
              key: const Key('play_button'),
              onPressed: _isPlaying ? _pause : _play,
              iconSize: 32,
              icon: AnimatedIcon(
                icon: AnimatedIcons.play_pause,
                progress: animation,
                size: 32,
                semanticLabel: 'Play/Pause',
              ),
              color: Colors.cyan,
            ),
            Text(
              _position != null
                  ? '$_positionText / $_durationText'
                  : _duration != null
                      ? _durationText
                      : '',
              style: const TextStyle(fontSize: 16.0),
            ),
          ],
        ),
        const SizedBox(width: 14),
        Slider(
          onChanged: (v) {
            final duration = _duration;
            if (duration == null) {
              return;
            }
            final position = v * duration.inMilliseconds;
            player.seek(Duration(milliseconds: position.round()));
          },
          value: (_position != null &&
                  _duration != null &&
                  _position!.inMilliseconds > 0 &&
                  _position!.inMilliseconds < _duration!.inMilliseconds)
              ? _position!.inMilliseconds / _duration!.inMilliseconds
              : 0.0,
        ),
      ],
    );
  }

  void _initStreams() {
    _durationSubscription = player.onDurationChanged.listen((duration) {
      setState(() => _duration = duration);
    });

    _positionSubscription = player.onPositionChanged.listen(
      (p) => setState(() => _position = p),
    );

    _playerCompleteSubscription = player.onPlayerComplete.listen((event) {
      setState(() {
        _playerState = PlayerState.stopped;
        _position = Duration.zero;
      });
    });
  }

  Future<void> _play() async {
    final position = _position;
    if (position != null && position.inMilliseconds > 0) {
      await player.seek(position);
    }
    await player.resume();
    unawaited(controller.forward());

    setState(() => _playerState = PlayerState.playing);
  }

  Future<void> _pause() async {
    await player.pause();
    unawaited(controller.reverse());
    setState(() => _playerState = PlayerState.paused);
  }
}
