import 'dart:io';

import 'package:encryption_decryption/helper/select_file_return.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/services.dart';

Future<bool> saveFile(
    {String? text, Uint8List? bytes, String? fileName}) async {
  var selectedDirectory = await FilePicker.platform.getDirectoryPath(
    dialogTitle: "Select Directory To Save File",
    lockParentWindow: true,
  );
  if (selectedDirectory == null) {
    return false;
  }
  File file;
  try {
    file = File('$selectedDirectory/$fileName');
    text != null
        ? await file.writeAsString(text)
        : await file.writeAsBytes(bytes!);
  } catch (e) {
    return false;
  }
  return true;
}

Future<SelectFileReturn> selectFile(
    {FileType? fileType, List<String>? allowedExtensions}) async {
  FilePickerResult? result = await FilePicker.platform.pickFiles(
    type: fileType ?? FileType.any,
    allowedExtensions: allowedExtensions,
    lockParentWindow: true,
    dialogTitle: "Select File",
  );
  File? file;
  if (result == null) {
    return SelectFileReturn(file: null, extension: null);
  }
  file = File(result.files.single.path!);
  return SelectFileReturn(file: file, extension: result.files.single.extension);
}
