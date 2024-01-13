import 'package:image_picker/image_picker.dart';
import 'package:video_sharing_app/entities/file_info.dart';

class VideoFile {
  final XFile file;
  late FileInfo info;

  VideoFile({required this.file}) {
    info = FileInfo(file: file);
  }
}
