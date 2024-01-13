import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:video_sharing_app/data/dataSource.dart';
import 'package:video_sharing_app/journeys/homepage/homepage.dart';
import 'package:video_sharing_app/journeys/homepage/video_screen/video_screen.dart';
import 'package:video_thumbnail/video_thumbnail.dart';
import 'package:path_provider/path_provider.dart';

import '../entities/video_info.dart';
import 'package:timeago/timeago.dart' as Timeago;

class VideoCard extends StatelessWidget {
  final VideoInfo videoInfo;
  const VideoCard({Key? key, required this.videoInfo}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // VideoInfo.uploadedAt has DateTime obj sent while uploading and while receiving it
    //gives Timestamp type following code converts it to a string formate

    final DateTime dateTime;
    String formatted_date_time = "unavailable";
    final timestamp = videoInfo.uploadedAt;
    if (timestamp != null) {
      dateTime = DateTime.fromMillisecondsSinceEpoch(timestamp.seconds * 1000);
      formatted_date_time = Timeago.format(dateTime);
    }

    return Column(
      children: [
        SizedBox(
          child: Padding(
            padding: EdgeInsets.all(10),
            child: Center(
              child: videoInfo.url == null
                  ? const Text("no video url")
                  : GestureDetector(
                      onTap: () => Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => VideoScreen(videoInfo: videoInfo),
                      )),
                      child: Thumbnail(
                          fileName: videoInfo.videoName, url: videoInfo.url!),
                    ),
            ),
          ),
        ),
        Container(
          //use device adaptive values(ur)
          height: 20,
          child: Row(
            children: [
              Icon(Icons.movie),
              SizedBox(width: 10),
              Text(videoInfo.videoName,
                  style: TextStyle(height: 2, fontWeight: FontWeight.bold)),
              const Spacer(),
              IconButton(
                padding: EdgeInsets.fromLTRB(0, 0, 0, 3),
                iconSize: 25,
                onPressed: () async {
                  await DataSource.getInstance()
                      .deleteFileAndEntry(videoInfo)
                      .then((value) {
                    if (value == true) {
                      Navigator.of(context).pushAndRemoveUntil(
                          MaterialPageRoute(builder: (context) => MyHomePage()),
                          (route) => false);
                    } else {
                      ScaffoldMessenger.of(context)
                          .showSnackBar(SnackBar(content: Text("error")));
                    }
                  });
                },
                icon: Icon(Icons.delete),
              )
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.fromLTRB(5, 5, 245, 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [Text(videoInfo.uploadedBy), Text(formatted_date_time)],
          ),
        ),
      ],
    );
  }
}

class Thumbnail extends StatelessWidget {
  late String url;
  late String fileName;

  Thumbnail({required this.fileName, required this.url});

  Future<Uint8List?> _fetchImgBytes() async {
    return await VideoThumbnail.thumbnailData(
      video: url,
      imageFormat: ImageFormat.WEBP,
      quality: 50,
    );
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Uint8List?>(
      future: _fetchImgBytes(),
      builder: (BuildContext context, AsyncSnapshot<Uint8List?> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else {
          return Container(
              height: 200,
              width: 400,
              child: Image(
                image: MemoryImage(snapshot.data!),
                fit: BoxFit.cover,
              ));

          ;
        }
      },
    );
  }
}
