import 'package:edger/video_view.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

const videoUrl =
/*'https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4';*/
    'https://file-examples.com/wp-content/uploads/2017/04/file_example_MP4_480_1_5MG.mp4';

void main() {
  runApp(App());
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MainScreen(),
    );
  }
}

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  VideoPlayerController _controller;

  bool usePlugin = true;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.network(videoUrl)
      ..initialize().then((_) {
        // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
        //_controller.play();
        setState(() {});
      });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          Switch(
            value: usePlugin,
            onChanged: (value) => setState(() => usePlugin = value),
          ),
          Center(child: Text('Use plugin'))
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            _controller.value.isPlaying
                ? _controller.pause()
                : _controller.play();
          });
        },
        child: Icon(
          _controller.value.isPlaying ? Icons.pause : Icons.play_arrow,
        ),
      ),
      body: usePlugin
          ? Center(
              child: _controller.value.initialized
                  ? AspectRatio(
                      aspectRatio: _controller.value.aspectRatio,
                      child: VideoPlayer(_controller),
                    )
                  : Container(),
            )
          : VideoView(
              videoUrl: videoUrl,
              autoplay: false,
              onComplete: () => print('complete'),
            ),
    );
  }
}
