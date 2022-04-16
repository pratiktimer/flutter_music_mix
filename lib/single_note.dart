import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;
import 'package:flutter_spinkit/flutter_spinkit.dart';

class SingleNote extends StatefulWidget {
  SingleNote({this.songUrl, this.audioPlayer});

  final String songUrl;
  final AudioPlayer audioPlayer;

  @override
  State<SingleNote> createState() => _SingleNoteState();
}

class _SingleNoteState extends State<SingleNote> {
  PlayerState state;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: ElevatedButton(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all<Color>(
              Color((math.Random().nextDouble() * 0xFFFFFF).toInt())
                  .withOpacity(1.0)),
        ),
        onPressed: () async {
          await _playSound(widget.songUrl);
        },
        child: state == PlayerState.PLAYING
            ? SpinKitSpinningLines(
                color: Colors.white,
                size: 70.0,
              )
            : Icon(
                Icons.audiotrack,
              ),
      ),
    );
  }

  Future<void> _playSound(String url) async {
    switch (state) {
      case PlayerState.PLAYING:
        widget.audioPlayer.pause();
        break;
      case PlayerState.PAUSED:
        widget.audioPlayer.resume();
        break;
      default:
        state = PlayerState.PLAYING;
        await widget.audioPlayer.play(url);
        break;
    }
    setState(() {});
    widget.audioPlayer.onPlayerStateChanged.listen((PlayerState s) {
      switch (s) {
        case PlayerState.STOPPED:
          break;
        case PlayerState.PLAYING:
          break;
        case PlayerState.PAUSED:
          break;
        case PlayerState.COMPLETED:
          break;
      }
      setState(() {
        state = s;
      });
    });
  }

  @override
  void dispose() {
    widget.audioPlayer.dispose();
    super.dispose();
  }
}
