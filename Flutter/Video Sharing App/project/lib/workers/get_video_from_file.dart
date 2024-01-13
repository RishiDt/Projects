import 'package:image_picker/image_picker.dart';

Future<XFile?> GetVideoFromFile() async {
  return await ImagePicker().pickVideo(source: ImageSource.gallery);
}
