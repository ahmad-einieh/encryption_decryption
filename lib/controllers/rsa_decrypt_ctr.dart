import 'dart:io';

import 'package:fast_rsa/fast_rsa.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../helper/methods.dart';
import '../helper/select_file_return.dart';

class AESDecryptctr extends GetxController {
  num? finishTime;
  SelectFileReturn? fileAndExtention;
  String? privateKey;

  Uint8List? plain;

  decryptBytesRSA(File file, String privateKey) async {
    Uint8List fileContent = await file.readAsBytes();
    final stopwatch = Stopwatch()..start();
    plain = await RSA.decryptPKCS1v15Bytes(fileContent, privateKey);
    finishTime = (stopwatch.elapsed.inMicroseconds) / 1000;
    update();
  }

  selectFileToDecrypt() async {
    fileAndExtention = await selectFile();
    update();
  }

  changePrivateKey() async {
    try {
      SelectFileReturn select = await selectFile(
          fileType: FileType.custom, allowedExtensions: ['txt']);
      privateKey = await select.file!.readAsString();
    } catch (e) {
      Get.snackbar("Error", "Some Error Occured",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white);
    }
    update();
  }

  clearAll() {
    privateKey = null;
    plain = null;
    fileAndExtention = null;
    update();
  }
}
