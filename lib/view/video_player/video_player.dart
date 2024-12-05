// import 'package:chewie/chewie.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:video_player/video_player.dart';

// class VideoViewScreen extends StatefulWidget {
//   static const route = 'video_view_screen';
//   final String videoUrl;
//   const VideoViewScreen({Key? key, required this.videoUrl}) : super(key: key);
//   @override
//   State<VideoViewScreen> createState() => _VideoViewScreenState();
// }

// class _VideoViewScreenState extends State<VideoViewScreen> {
//   late VideoPlayerController videoPlayerController;
//   ChewieController? chewieController;

//   @override
//   void initState() {
//     super.initState();
//     initializePlayer();
//   }

//   Future<void> initializePlayer() async {
//     Uri url = Uri.parse(widget.videoUrl);
//     videoPlayerController = VideoPlayerController.networkUrl(url);
//     await videoPlayerController.initialize();
//     chewieController = ChewieController(
//       videoPlayerController: videoPlayerController,
//       placeholder: const Center(child: CircularProgressIndicator.adaptive()),
//       autoInitialize: true, allowFullScreen: false,
//       // fullScreenByDefault: true,
//       autoPlay: true,
//     );
//     setState(() {});
//   }

//   @override
//   void dispose() {
//     videoPlayerController.dispose();
//     chewieController?.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.black,
//       body: chewieController != null &&
//               chewieController!.videoPlayerController.value.isInitialized
//           ? Chewie(controller: chewieController!)
//           : const Center(child: CircularProgressIndicator.adaptive()),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class VideoViewScreen extends StatefulWidget { final String videoUrl;
   VideoViewScreen({super.key, required this.videoUrl});

  @override
  State<VideoViewScreen> createState() => _VideoViewScreenState();
}

class _VideoViewScreenState extends State<VideoViewScreen> {
  late VideoPlayerController _controller;
  @override
  void initState() {
 print("url-----${widget.videoUrl}");

    super.initState();
    _controller = VideoPlayerController.networkUrl(Uri.parse(widget.videoUrl))
      ..initialize().then((_) {
        // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
        setState(() {});
      });
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
        body: Center(
          child: _controller.value.isInitialized
              ? AspectRatio(
                  aspectRatio: _controller.value.aspectRatio,
                  child: VideoPlayer(_controller),
                )
              : Container(),
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
      
    );
  }
}