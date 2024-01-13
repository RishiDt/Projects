import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:video_sharing_app/entities/video_info.dart';
import 'package:video_sharing_app/widgets/video_card.dart';

class VideoListBuilder extends StatefulWidget {
  const VideoListBuilder({Key? key}) : super(key: key);

  @override
  _VideoListBuilderState createState() => _VideoListBuilderState();
}

class _VideoListBuilderState extends State<VideoListBuilder> {
  late Stream<QuerySnapshot<Map<String, dynamic>>> _videoStream;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _videoStream = FirebaseFirestore.instance.collection("videos").snapshots();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: StreamBuilder<QuerySnapshot>(
        stream: _videoStream,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Text("Error");
          }

          if (snapshot.data == null || snapshot.data!.docs == null) {
            return const Text("No data");
          }

          final _videos = snapshot.data!.docs;

          return ListView.separated(
              itemBuilder: (context, i) {
                // return Text(_videos[i].id);

                return VideoCard(
                    videoInfo: VideoInfo.fromDoc(_videos[i].data()));
              },
              separatorBuilder: (context, i) {
                return Container(
                  height: 2.5,
                  color: Colors.grey,
                );
              },
              itemCount: _videos.length);
        },
      ),
    );
  }
}
