import 'dart:io';

import 'package:encrypt/encrypt.dart';
import 'package:file_picker/file_picker.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

GetStorage storage = GetStorage();

IV iv = IV.fromBase16('505b8e8b5374eea4670cedffd1288b9c');

saveFile(text, fileName) async {
  var selectedDirectory = await FilePicker.platform.getDirectoryPath();
  final File file = File('$selectedDirectory/$fileName.txt');
  await file.writeAsString(text);
}

Future<File?>? selectFile() async {
  FilePickerResult? result = await FilePicker.platform.pickFiles();
  File? file;
  if (result != null) {
    file = File(result.files.single.path!);
    return file;
  } else {
    Get.snackbar("Error", "No file selected");
  }
  return file;
}
