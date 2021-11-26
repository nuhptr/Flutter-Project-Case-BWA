import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart';
import 'package:image_picker/image_picker.dart';

// TODO: function get image
Future getImage() async {
  var image = await ImagePicker().getImage(source: ImageSource.gallery);
  return File(image.path);
}

// TODO: function upload image to firebase Storage
Future<String> uploadImage(File image) async {
  String filename = basename(image.path);

  StorageReference ref = FirebaseStorage.instance.ref().child(filename);
  StorageUploadTask task = ref.putFile(image);
  StorageTaskSnapshot snapshot = await task.onComplete;

  return await snapshot.ref.getDownloadURL();
}
