import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class EvacuationPage extends StatefulWidget {
  const EvacuationPage(
      {super.key, required this.token, required this.filename});
  final String token;
  final String filename;

  @override
  State<EvacuationPage> createState() => _EvacuationPageState();
}

class _EvacuationPageState extends State<EvacuationPage> {
  VideoPlayerController? _controller;
  //Future<void>? _initializeVideoPlayerFuture;

  @override
  void initState() {
    super.initState();
    _controller =
        VideoPlayerController.asset("assets/videos/${widget.filename}")
          ..initialize().then((_) {
            _controller?.setVolume(0);
            _controller?.play();
            _controller?.setLooping(true);
            setState(() {});
          });
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.token,
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Center(
            child: Column(
              children: [
                Text(
                  "Evacuation route",
                  style: TextStyle(fontSize: 20),
                ),
                SizedBox(
                  height: 20,
                ),
                SizedBox(
                  child: VideoPlayer(
                    _controller!,
                  ),
                  height: MediaQuery.of(context).size.height - 200,
                )
                /*FutureBuilder(
                future: _initializeVideoPlayerFuture,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    // If the VideoPlayerController has finished initialization, use
                    // the data it provides to limit the aspect ratio of the video.
                    return AspectRatio(
                      aspectRatio: _controller!.value.aspectRatio,
                      // Use the VideoPlayer widget to display the video.
                      child: VideoPlayer(_controller!),
                    );
                  } else {
                    // If the VideoPlayerController is still initializing, show a
                    // loading spinner.
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                },
              )*/
              ],
            ),
          ),
        ),
      ),
    );
  }
}
