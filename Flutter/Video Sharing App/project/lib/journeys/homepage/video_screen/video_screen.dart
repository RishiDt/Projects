import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:video_sharing_app/entities/video_info.dart';
import 'package:video_sharing_app/widgets/comments_list.dart';

import '../../../widgets/vid_player.dart';

/// Stateful widget to fetch and then display video content.
class VideoScreen extends StatefulWidget {
  VideoInfo videoInfo;

  VideoScreen({
    super.key,
    required this.videoInfo,
  });

  @override
  // ignore: no_logic_in_create_state, library_private_types_in_public_api
  _VideoScreenState createState() => _VideoScreenState(videoInfo: videoInfo);
}

class _VideoScreenState extends State<VideoScreen> {
  late VideoPlayerController? _controller;
  VideoInfo videoInfo;
  CommentsList? cList;
  _VideoScreenState({required this.videoInfo});

  //for new comment widget
  final TextEditingController _textEditingController = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (videoInfo.url != null) {
      _controller = VideoPlayerController.networkUrl(Uri.parse(videoInfo.url!));
      _controller!.initialize().then((value) => setState(() {}));
    }
  }

  @override
  Widget build(BuildContext context) {
    print("build fired. videoInfo.comments is ");
    print(videoInfo.comments);

    return Scaffold(
        body: SingleChildScrollView(
      child: Column(children: [
        //logic for video player widget
        _controller != null
            ? (_controller!.value.isInitialized
                ? AspectRatio(
                    aspectRatio: _controller!.value.aspectRatio,
                    child: VidPlayer(
                      controller: _controller!,
                    ),
                  )
                : Container(
                    height: 200,
                    padding: EdgeInsets.fromLTRB(0, 75, 0, 0),
                    child: Center(
                        child: Column(
                      children: [
                        CircularProgressIndicator(),
                        Text("plz wait"),
                      ],
                    )),
                  ))
            : Container(
                padding: EdgeInsets.fromLTRB(0, 75, 0, 0),
                child: Center(child: const Text("No video")),
              ),

        Container(
          width: double.infinity,

          // border for testing purpose
          decoration: BoxDecoration(
              border: Border.all(
            color: Colors.black,
            width: 2,
          )),

          //title and video description column
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
                child: Text(videoInfo.videoName!),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
                child: Text(videoInfo.videoLocation),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
                child: Text(videoInfo.videoDescription),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
                child: Text("Comments"),
              ),
            ],
          ),
        ),
        Container(
            decoration: BoxDecoration(
                border: Border.all(
              color: Colors.black,
              width: 2,
            )),
            height: 250,
            width: double.infinity,
            child: cList ??
                CommentsList(
                  videoInfo: VideoInfo.fromDoc({
                    "videoName": videoInfo.videoName,
                    "uploadedBy": videoInfo.uploadedBy,
                    "uploadedAt": videoInfo.uploadedAt,
                    "videoDescription": videoInfo.videoDescription,
                    "url": videoInfo.url,
                    "videoLocation": videoInfo.videoLocation,
                    "comments": videoInfo.comments
                  }),
                )),
        Container(
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _textEditingController,
                  decoration: InputDecoration(
                    hintText: 'Enter your comment',
                  ),
                ),
              ),
              IconButton(
                icon: Icon(Icons.send),
                onPressed: () async {
                  showDialog(
                    context: context,
                    barrierDismissible: false,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        content: Container(
                          height: 100,
                          child: const Center(
                            child: CircularProgressIndicator(),
                          ),
                        ),
                      );
                    },
                  );

                  String comment = _textEditingController.text;
                  print("uploadedBy in videoInfo:" + videoInfo.uploadedBy);
                  await FirebaseFirestore.instance
                      .collection('videos')
                      .doc(videoInfo.uploadedBy)
                      .update({
                    "comments": FieldValue.arrayUnion([
                      {videoInfo.uploadedBy: comment}
                    ])
                  }).then(
                    //lazy logic change this to only refresh this screen
                    (value) => {
                      FirebaseFirestore.instance
                          .collection("/videos")
                          .doc(videoInfo.uploadedBy)
                          .get()
                          .then((value) {
                        print("here's new document obtained ");
                        print(value);
                        // Navigator.of(context).pushAndRemoveUntil(
                        //     MaterialPageRoute(
                        //       builder: (context) => VideoScreen(
                        //           videoInfo: VideoInfo.fromDoc(value)),
                        //     ),
                        //     (route) => false);

                        setState(() {
                          videoInfo = VideoInfo.fromDoc(value);
                          // cList = CommentsList(videoInfo: videoInfo);
                          super.setState(() {});
                          Navigator.of(context).pop();
                          Navigator.of(context).pushReplacement(
                              MaterialPageRoute(builder: (context) {
                            return VideoScreen(
                              videoInfo: videoInfo,
                            );
                          }));
                        });
                      })
                    },
                  );

                  // Do something with the comment
                },
              ),
            ],
          ),
        )
      ]),
    )
        //main column of video screen

        );
  }

  @override
  void dispose() {
    super.dispose();
    _controller!.dispose();
  }
}
