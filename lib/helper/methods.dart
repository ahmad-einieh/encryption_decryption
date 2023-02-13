import 'dart:io';

import 'package:encryption_decryption/helper/select_file_return.dart';
import 'package:fast_rsa/fast_rsa.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_pdf/pdf.dart';
import 'package:encrypt/encrypt.dart' as encryptpackage;

import 'constant.dart';

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

String readPDFile(file) {
  final PdfDocument document = PdfDocument(inputBytes: file.readAsBytesSync());
  String text = PdfTextExtractor(document).extractText();
  document.dispose();
  return text;
}

encryptBytesRSA(
    File file, String publicKey, String fileNamaeWithExteinsion) async {
  Uint8List fileContent = await file.readAsBytes();
  Uint8List cyper = await RSA.encryptPKCS1v15Bytes(fileContent, publicKey);
  saveFile(bytes: cyper, fileName: fileNamaeWithExteinsion);
}

decryetBytesRSA(
    File file, String privateKey, String fileNamaeWithExteinsion) async {
  Uint8List fileContent = await file.readAsBytes();
  Uint8List plain = await RSA.decryptPKCS1v15Bytes(fileContent, privateKey);
  saveFile(bytes: plain, fileName: fileNamaeWithExteinsion);
}

encryptBytesAES(
    File file, String privateKey, String fileNamaeWithExteinsion) async {
  Uint8List fileContent = await file.readAsBytes();

  final encrypter = encryptpackage.Encrypter(
      encryptpackage.AES(encryptpackage.Key.fromBase16(privateKey)));

  final encryptpackage.Encrypted encrypted =
      encrypter.encryptBytes(fileContent, iv: iv);
  saveFile(bytes: encrypted.bytes, fileName: fileNamaeWithExteinsion);
}

decryetBytesAES(
    File file, String privateKey, String fileNamaeWithExteinsion) async {
  Uint8List fileContent = await file.readAsBytes();

  final encryptpackage.Encrypter encrypter = encryptpackage.Encrypter(
      encryptpackage.AES(encryptpackage.Key.fromBase16(privateKey)));
  encryptpackage.Encrypted encrypted = encryptpackage.Encrypted(fileContent);
  final List<int> decrypted = encrypter.decryptBytes(encrypted, iv: iv);
  saveFile(
      bytes: Uint8List.fromList(decrypted), fileName: fileNamaeWithExteinsion);
}
