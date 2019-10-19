import 'package:video_player/video_player.dart';
import 'package:flutter/material.dart';
import 'package:chewie/chewie.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:mystream/screens/vlcPlayer.dart';
String name ;
class VideoApp extends StatefulWidget {
  @override
  final int index ;
  VideoApp(this.index);

  _VideoAppState createState() => _VideoAppState(this.index);
}


List<String> links=[
  'https://ca94879c.ngrok.io/movie/mp4/sample',
  'https://ca94879c.ngrok.io/movie/mkv/Gurkha',
  'https://ca94879c.ngrok.io/movie/mp4/jersey',
  'https://ca94879c.ngrok.io/movie/mkv/avengersendgame',

];
List<String> images = [
  "assets/image_04.jpg",
  "assets/image_03.jpg",
  "assets/image_02.jpg",
  "assets/image_01.jpg",
];
List<String> title = [
  'Sample',
  'Gurkha',
  'Jersey',
  'The Avengers End Game',
];
List<int> num=[
  0,1,2,3
];
class _VideoAppState extends State<VideoApp> {
  VideoPlayerController _controller;
  ChewieController _chewieController;
  int value =0;
  _VideoAppState(this.value);

  Future<bool> _onWillPop() {
    return showDialog(
      context: context,
      child: new AlertDialog(
        title: new Text('Are you sure?'),
        content: new Text('You wanna goto HomePage'),
        actions: <Widget>[
          new FlatButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: new Text('No'),
          ),
          new FlatButton(
            onPressed: () => {
              Navigator.of(context).pop(true)
            },
            child: new Text('Yes'),
          ),
        ],
      ),
    ) ?? false;
  }

  @override
  void initState() {
    super.initState();
    debugPrint('$value value of index');
    _controller = VideoPlayerController.network(
        links[value])
      ..initialize().then((_) {
        // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
        setState(() {});

      });
    _chewieController = ChewieController(
      videoPlayerController: _controller,
      aspectRatio: 16 / 9,
      autoPlay: true,
      looping: true,
      fullScreenByDefault: true,
      // Try playing around with some of these other options:

      // showControls: false,
      materialProgressColors: ChewieProgressColors(
        playedColor: Colors.red,
        handleColor: Colors.blue,
        backgroundColor: Colors.grey,
        bufferedColor: Colors.lightGreen,
      ),
      placeholder: Container(
        color: Colors.grey,
      ),
      // autoInitialize: true,
    );
  }
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          backgroundColor: Color(0xFF2d3447),
          body: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(top:30.0,left: 0,right: 0,bottom: 0),
                  child: Chewie(
                    controller: _chewieController,
                  ),
                ),

                Card(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      ListTile(
                        leading: Icon(Icons.movie_creation),
                        title: Text(title[value]),
                        subtitle: Text('Enjoy the Movie'),
                      ),
                    ],
                  ),
                ),
//                RaisedButton(
//                  child: Text('If not playing properly Click Here!!!'),
//                  onPressed: (){},
//                ),
                ListTile(
                  title: Text('on Not playing properly click here!!!'),
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => ExampleVideo(value)));
                  },
                ),
                CarouselSlider(
                  enlargeCenterPage: true,
                  enableInfiniteScroll: false,
                  height: 360.0,
                  items: num.map((i) {
                    return Builder(
                      builder: (BuildContext context) {
                        return Container(
                          width: MediaQuery.of(context).size.width,
                          margin: EdgeInsets.symmetric(horizontal: 5.0),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(50)
                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(top: 40),
                            child: Container(
                              child: Column(
                                children: <Widget>[
                                  Container(
                                    decoration: BoxDecoration(
                                        color: Colors.black54,
                                        borderRadius: BorderRadius.circular(10)),
                                    child: Padding(
                                      padding: const EdgeInsets.only(top:5.0,left:2.0,right: 2.0,bottom: 10.0),
                                      child: Text(title[i],
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              color: Colors.white,
                                              letterSpacing: 2,
                                              fontSize: 20.0,
                                              fontFamily: "SF-Pro-Text-Regular")),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(left: 2.0,top: 5.0),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(20.0),
                                      child: Image.asset(images[i],
                                          width: 296.0, height: 222.0),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  }).toList(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
    _chewieController.dispose();
  }
}
