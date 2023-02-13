import 'dart:io';

import 'package:encryption_decryption/helper/select_file_return.dart';
import 'package:fast_rsa/fast_rsa.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../helper/methods.dart';

class RSAEncryptctr extends GetxController {
  num? finishTime;
  SelectFileReturn? fileAndExtention;
  String? publicKey;

  Uint8List? cyper;

  encryptBytesRSA(File file, String publicKey) async {
    Uint8List fileContent = await file.readAsBytes();
    final stopwatch = Stopwatch()..start();
    cyper = await RSA.encryptPKCS1v15Bytes(fileContent, publicKey);
    finishTime = (stopwatch.elapsed.inMicroseconds) / 1000;
    update();
  }

  selectFileToEncrypt() async {
    fileAndExtention = await selectFile();
    update();
  }

  changePublicKey() async {
    try {
      SelectFileReturn select = await selectFile(
          fileType: FileType.custom, allowedExtensions: ['txt']);
      publicKey = await select.file!.readAsString();
    } catch (e) {
      Get.snackbar("Error", "Some Error Occured",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white);
    }
    update();
  }

  clearAll() {
    publicKey = null;
    cyper = null;
    fileAndExtention = null;
    update();
  }
}
