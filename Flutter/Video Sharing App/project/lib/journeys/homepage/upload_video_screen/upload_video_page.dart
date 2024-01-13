import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:video_sharing_app/data/dataSource.dart';
import 'package:video_sharing_app/entities/video_File.dart';
import 'package:video_sharing_app/entities/video_info.dart';
import 'package:video_sharing_app/journeys/homepage/homepage.dart';
import 'package:video_sharing_app/workers/get_location.dart';
import 'package:video_sharing_app/workers/get_video_from_camera.dart';
import 'package:video_sharing_app/workers/get_video_from_file.dart';

import '../../../workers/get_address_from_location.dart';

//for uploading progress
enum status { loading, success, error }

class VideoUploadScreen extends StatefulWidget {
  @override
  _VideoUploadScreenState createState() => _VideoUploadScreenState();
}

class _VideoUploadScreenState extends State<VideoUploadScreen> {
  String? _currentAddress;
  TextEditingController _locFieldController = TextEditingController();
  TextEditingController _nameFieldController = TextEditingController();
  TextEditingController _descFieldController = TextEditingController();
  VideoInfo? _videoInfo;
  VideoFile? _videoFile;
  String? error;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Video Upload'),
      ),
      resizeToAvoidBottomInset: false,
      body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ElevatedButton.icon(
                  icon: Icon(Icons.camera),
                  label: Text('Click to record'),
                  onPressed: () async {
                    XFile? file = await getVideoFromCamera();
                    if (file != null) {
                      setState(() {
                        _videoFile = VideoFile(file: file);
                      });
                    } else {
                      setState(() {
                        error = "could not get video";
                      });
                    }
                  },
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(50, 0, 250, 0),
                  child: const Text("or"),
                ),
                ElevatedButton.icon(
                  icon: Icon(Icons.video_file),
                  label: Text('Click to get from file'),
                  onPressed: () async {
                    XFile? file = await GetVideoFromFile();
                    if (file != null) {
                      setState(() {
                        _videoFile = VideoFile(file: file);
                      });
                    } else {
                      setState(() {
                        error = "could not get video";
                      });
                    }
                  },
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                  child: _videoFile == null
                      ? Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.warning),
                            Text("No video file selected"),
                          ],
                        )
                      : Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.done),
                            Text("Video file Ready"),
                          ],
                        ),
                ),
                TextField(
                  controller: _nameFieldController,
                  decoration: InputDecoration(
                    labelText: 'Video Name',
                  ),
                ),
                const SizedBox(height: 16.0),
                TextField(
                  controller: _descFieldController,
                  decoration: InputDecoration(
                    labelText: 'Description',
                  ),
                ),
                SizedBox(height: 16.0),
                TextField(
                  decoration: const InputDecoration(
                    labelText: 'location',
                  ),
                  controller: _locFieldController,
                ),
                const SizedBox(height: 16.0),
                ElevatedButton.icon(
                  icon: Icon(Icons.location_on),
                  label: Text('Get Location'),
                  onPressed: () async {
                    setState(() {
                      _locFieldController.text =
                          "plz wait to obtain your location.....";
                    });
                    _currentAddress = await getAddress();
                    setState(() {
                      print(_currentAddress);
                      _locFieldController.text =
                          _currentAddress ?? "no address has been determined.";
                    });
                  },
                ),
                const SizedBox(height: 16.0),
                Text(error ?? ""),
              ],
            ),
          )),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          if (_videoFile == null) {
            setState(() {
              error = "no video selected";
            });
            return;
          }
          if (_nameFieldController.text.isEmpty) {
            setState(() {
              error = "name is required";
              return;
            });
          }
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
          SharedPreferences prefs = await SharedPreferences.getInstance();

          _videoInfo = VideoInfo(
            uploadedBy: prefs.getString("userPhone"),
            videoName: _nameFieldController.text,
            videoDescription: _descFieldController.text,
            videoLocation: _locFieldController.text,
            uploadedAt: DateTime.now(),
          );
          print(_videoInfo);

          await DataSource.getInstance()
              .uplaodVideo(_videoInfo!, _videoFile!)
              .then((value) {
            if (value == true) {
              Fluttertoast.showToast(
                msg: 'Uplaod Succefull',
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.BOTTOM,
                timeInSecForIosWeb: 1,
                backgroundColor: Colors.red,
                textColor: Colors.white,
                fontSize: 16.0,
              );

              Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (context) => const MyHomePage()),
                  (route) => false);
            } else {
              setState(() {
                error = "could not upload video";
                return;
              });
            }
          });
        },
        child: Icon(Icons.upload),
      ),
    );
  }
}
