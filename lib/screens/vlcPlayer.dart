import 'package:flutter/material.dart';
import 'package:flutter_vlc_player/vlc_player.dart';
import 'package:flutter_vlc_player/vlc_player_controller.dart';
import 'package:chewie/chewie.dart';
import 'package:video_player/video_player.dart';

class ExampleVideo extends StatefulWidget {
  final int index;

  @override
  ExampleVideo(this.index);

  _ExampleVideoState createState() => _ExampleVideoState(this.index);
}

List<String> links = [
  'https://ca94879c.ngrok.io/movie/mp4/sample',
  'https://ca94879c.ngrok.io/movie/mkv/Gurkha',
  'https://ca94879c.ngrok.io/movie/mp4/jersey',
  'https://ca94879c.ngrok.io/movie/mkv/avengersendgame',
];

class _ExampleVideoState extends State<ExampleVideo> {
  int val = 0;

  _ExampleVideoState(this.val);

  final VlcPlayerController controller = VlcPlayerController();
  final int playerWidth = 900;
  final int playerHeight = 500;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    debugPrint('Value is $val');
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Hello World',
        home: Scaffold(

            backgroundColor: Colors.black,
            body: Padding(
              padding: const EdgeInsets.only(top: 80),
              child: RotatedBox(
                quarterTurns: 1,
                child: VlcPlayer(
                  defaultWidth: playerWidth,
                  defaultHeight: playerHeight,
                  url: links[val],
                  controller: controller,
                  placeholder: Center(child: CircularProgressIndicator()),
                ),
              ),
            )));
  }
}
