import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:xylophone/single_note.dart';
import 'package:xylophone/song_list.dart';

void main() => runApp(XylophoneApp());

class XylophoneApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
          body: GridView.count(
        shrinkWrap: true,
        crossAxisCount: 4,
        children: List.generate(SongList.songUrlList.length, (index) {
          return SingleNote(
              songUrl: SongList.songUrlList[index], audioPlayer: AudioPlayer());
        }),
      )),
    );
  }
}
