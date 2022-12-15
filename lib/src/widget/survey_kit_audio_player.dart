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
      height: 50,
      child: FutureBuilder<void>(
        future: audioReady,
        builder: (_, snapshot) {
          if (ConnectionState.done == snapshot.connectionState) {
            return IconButton(
              onPressed: () {
                if (player.state == PlayerState.playing) {
                  player.pause();
                } else {
                  player.resume();
                }
                setState(() {});
              },
              icon: Icon(
                player.state == PlayerState.playing
                    ? Icons.pause
                    : Icons.play_arrow,
              ),
            );
          } else {
            return const SizedBox.shrink();
          }
        },
      ),
    );
  }
}
