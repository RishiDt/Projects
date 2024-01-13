import 'package:image_picker/image_picker.dart';

Future<XFile?> getVideoFromCamera() async {
  return await ImagePicker().pickVideo(source: ImageSource.camera);
}
