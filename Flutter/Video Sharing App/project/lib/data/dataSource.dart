import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:video_sharing_app/entities/video_File.dart';
import 'package:video_sharing_app/entities/video_info.dart';

import '../entities/file_info.dart';

class DataSource {
  static DataSource? ds = null;

  static DataSource getInstance() {
    if (ds == null) {
      ds = DataSource();
    }
    return ds!;
  }

  Future<bool> uplaodVideo(VideoInfo videoInfo, VideoFile file) async {
    //requires proper null response by function
    if (file == null) print("no file!");

    try {
      var snapshot = await FirebaseStorage.instance
          .ref("/videosFolder")
          .child(videoInfo.videoName)
          .putFile(File(file.info.path));

      //video url will be stored allong other fields in firestore
      await snapshot.ref.getDownloadURL().then((value) {
        if (value != null) {
          videoInfo.addToDoc(key: "url", value: value);
        }
      }).then((value) async {
        // SharedPreferences prefs = await SharedPreferences.getInstance();
        //prefs.getString("userPhone")

        var countDoc = await FirebaseFirestore.instance
            .collection('videosCount')
            .doc("count")
            .get();
        print("count doc is");
        print(countDoc.data());

        int count = countDoc.get("count");

        await FirebaseFirestore.instance
            .collection('videosCount')
            .doc("count")
            .set({
          "count": count + 1,
        });

        await FirebaseFirestore.instance
            .collection('videos')
            .doc("video${count}")
            .set(videoInfo.doc);
      });

      print("here's videoInfo.doc" + videoInfo.doc.toString());
      return true;
    } catch (e) {
      //print(e);
      return false;
    }
  }

  Future<bool> deleteFileAndEntry(VideoInfo videoInfo) async {
    try {
      // Delete file from Cloud Storage.
      try {
        final Reference storageReference =
            FirebaseStorage.instance.ref("/videosFolder");
        if (storageReference != null)
          await storageReference.child(videoInfo.videoName).delete();
      } catch (e) {}

      // Delete entry from Firestore.
      var countDoc = await FirebaseFirestore.instance
          .collection('videosCount')
          .doc("count")
          .get();

      int count = countDoc.get("count");

      await FirebaseFirestore.instance
          .collection('videosCount')
          .doc("count")
          .set({
        "count": count - 1,
      });

      final DocumentReference documentReference =
          FirebaseFirestore.instance.collection("videos").doc("video${count}");
      await documentReference.delete();
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }
}
