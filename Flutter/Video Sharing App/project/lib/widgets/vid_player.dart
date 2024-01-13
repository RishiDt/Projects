import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class VidPlayer extends StatefulWidget {
  final VideoPlayerController controller;

  const VidPlayer({Key? key, required this.controller}) : super(key: key);

  @override
  _VidPlayerState createState() => _VidPlayerState(controller);
}

class _VidPlayerState extends State<VidPlayer> {
  final VideoPlayerController controller;
  bool visible = false;

  _VidPlayerState(this.controller);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        GestureDetector(
          onTap: () {
            setState(() {
              visible = !visible;
            });
          },
          child: VideoPlayer(controller),
        ),
        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: Visibility(
            visible: visible,
            child: Row(
              children: [
                IconButton(
                  icon: Icon(
                    controller.value.isPlaying ? Icons.pause : Icons.play_arrow,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    setState(() {
                      controller.value.isPlaying
                          ? controller.pause()
                          : controller.play();
                    });
                  },
                ),
                Expanded(
                  child: VideoProgressIndicator(
                    controller,
                    allowScrubbing: true,
                    colors: VideoProgressColors(
                      playedColor: Colors.red,
                      backgroundColor: Colors.grey,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
