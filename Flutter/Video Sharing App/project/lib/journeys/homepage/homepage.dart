import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:video_sharing_app/data/dataSource.dart';
import 'package:video_sharing_app/entities/video_File.dart';
import 'package:video_sharing_app/entities/video_info.dart';
import 'package:video_sharing_app/journeys/homepage/upload_video_screen/upload_video_page.dart';
import 'package:video_sharing_app/journeys/login_screen/first.dart';
import 'package:video_sharing_app/workers/get_address_from_location.dart';
import 'package:video_sharing_app/workers/get_video_from_file.dart';
import 'package:video_sharing_app/workers/get_location.dart';

import '../../blocs/videos_channel/videos_channel_bloc.dart';
import '../../widgets/video_list_builder.dart';
import 'package:firebase_auth/firebase_auth.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({
    super.key,
  });

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late DataSource ds;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    ds = DataSource.getInstance();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("video sharing app"),
        backgroundColor: Colors.red,
        actions: [
          TextButton(
              onPressed: () async {
                print("before logout");
                SharedPreferences.getInstance()
                    .then((value) => print(value.getString("userPhone")));
                final FirebaseAuth auth = FirebaseAuth.instance;
                await auth.signOut().then((value) {
                  SharedPreferences.getInstance()
                      .then((value) => print(value.remove("userPhone")));

                  print("after logout");
                  SharedPreferences.getInstance()
                      .then((value) => print(value.getString("userPhone")));
                  Fluttertoast.showToast(msg: "logOut Success");
                  Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(builder: (context) => First()),
                      (route) => false);
                });
              },
              child: Text("LogOut"))
        ],
      ),
      body: const VideoListBuilder(),
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(
              builder: (context) {
                return VideoUploadScreen();
              },
            ));
          },
          // () async {
          //   var pos = await getLocation();
          //   print(pos);

          //   var add = await getAddress(pos.latitude, pos.longitude);
          //   print(add);
          // },

          // () async {
          //   //make an object variable for GetVideoFile
          //   //use getIt
          //   XFile? file = await GetVideoFile().getVideo();
          //   if (file == null) {
          //     print("file is null");
          //     return;
          //   }
          //   var vFile = VideoFile(file: file);
          //   var vInfo = VideoInfo(
          //       videoDescription: "",
          //       uploadedAt: DateTime.now(),
          //       videoName: file.name);

          //   //directly adding an event
          //   VcBloc().add(VcBlocUploadEvent(videoFile: vFile, videoInfo: vInfo));
          // },
          child: Icon(
            Icons.add,
            color: Colors.red,
          )),
    );
  }
}
