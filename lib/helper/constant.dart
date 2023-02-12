import 'dart:io';

import 'package:encrypt/encrypt.dart';
import 'package:file_picker/file_picker.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:syncfusion_flutter_pdf/pdf.dart';

GetStorage storage = GetStorage();

IV iv = IV.fromBase16('505b8e8b5374eea4670cedffd1288b9c');

Future<bool> saveFile(text, fileName) async {
  var selectedDirectory = await FilePicker.platform.getDirectoryPath();
  if (selectedDirectory == null) {
    return false;
  } else {
    final File file = File('$selectedDirectory/$fileName.txt');
    await file.writeAsString(text);
    return true;
  }
}

Future<List> selectFile() async {
  FilePickerResult? result = await FilePicker.platform
      .pickFiles(allowedExtensions: ['txt', 'pdf'], type: FileType.custom);
  File? file;
  if (result != null) {
    file = File(result.files.single.path!);
    return [file, result.files.single.extension];
  } else {
    Get.snackbar("Error", "No file selected");
    return [];
  }
}

String readPDFile(file) {
  final PdfDocument document = PdfDocument(inputBytes: file.readAsBytesSync());
  String text = PdfTextExtractor(document).extractText();
  document.dispose();
  return text;
}
