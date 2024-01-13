//component of VideoFile class

import 'package:image_picker/image_picker.dart';

class FileInfo {
  final XFile file;
  late String name;
  late String path;
  FileInfo({required this.file}) {
    name = file.name;
    path = file.path;
  }
}
