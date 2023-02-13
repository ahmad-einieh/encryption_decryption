import 'dart:io';

import 'package:encryption_decryption/helper/select_file_return.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

Future<bool> saveFile(
    {String? text, Uint8List? bytes, String? fileName}) async {
  var selectedDirectory = await FilePicker.platform.getDirectoryPath();
  if (selectedDirectory == null) {
    return false;
  } else {
    File file;
    if (text != null) {
      file = File('$selectedDirectory/$fileName.txt');
      await file.writeAsString(text);
    } else {
      file = File('$selectedDirectory/$fileName');
      await file.writeAsBytes(bytes!);
    }
    return true;
  }
}

Future<SelectFileReturn> selectFile(
    {FileType? fileType, List<String>? allowedExtensions}) async {
  FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: fileType ?? FileType.any, allowedExtensions: allowedExtensions);
  File? file;
  if (result != null) {
    file = File(result.files.single.path!);
    return SelectFileReturn(
        file: file, extension: result.files.single.extension);
  } else {
    Get.snackbar("Error", "No file selected");
    return SelectFileReturn(file: null, extension: null);
  }
}
