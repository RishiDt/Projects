import 'package:flutter/material.dart';
import 'package:video_sharing_app/entities/video_info.dart';

class CommentsList extends StatefulWidget {
  VideoInfo videoInfo;
  CommentsList({Key? key, required this.videoInfo}) : super(key: key) {
    print("videoInfo recieved in CommentsList is");
    print(videoInfo.comments);
  }

  @override
  _CommentsListState createState() => _CommentsListState(videoInfo: videoInfo);
}

class _CommentsListState extends State<CommentsList> {
  VideoInfo videoInfo;
  _CommentsListState({required this.videoInfo});

  @override
  Widget build(BuildContext context) {
    var cmts;

    cmts = videoInfo.comments;
    //var comment = cmts[0] as Map<String, dynamic>;
    //print(comment);
    print(cmts);

    if (cmts != null) {
      return ListView.separated(
        padding: EdgeInsets.zero,
        itemCount: cmts!.length,
        itemBuilder: (context, index) {
          return (Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                child: Text(
                  videoInfo.uploadedBy,
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
                child: Text(
                  cmts![index][videoInfo.uploadedBy],
                ),
              ),
            ],
          ));
        },
        separatorBuilder: (BuildContext context, int index) {
          return Container(
            height: 2.5,
            color: Colors.grey,
          );
        },
      );
    }
    print("cmnts null");
    return const Text("no Comments");
  }
}
