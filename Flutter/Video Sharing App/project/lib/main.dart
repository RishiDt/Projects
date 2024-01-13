import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:video_sharing_app/data/dataSource.dart';
import 'package:video_sharing_app/entities/video_File.dart';
import 'package:video_sharing_app/entities/video_info.dart';
import 'package:video_sharing_app/widgets/my_app.dart';
import 'package:video_sharing_app/widgets/video_list_builder.dart';
import 'package:video_sharing_app/workers/get_video_from_file.dart';

import 'blocs/videos_channel/videos_channel_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(MyApp());
}
