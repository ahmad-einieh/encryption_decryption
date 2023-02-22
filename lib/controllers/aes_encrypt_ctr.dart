import 'dart:io';

import 'package:encrypt/encrypt.dart' as encryptpackage;
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../helper/constant.dart';
import '../helper/methods.dart';
import '../helper/select_file_return.dart';

class AESEncryptctr extends GetxController {
  num? finishTime;
  SelectFileReturn? fileAndExtention;
  String? privateKey;
  encryptpackage.AESMode? mode = encryptpackage.AESMode.sic;
  encryptpackage.IV? iv;

  Uint8List? cyper;

  bool isLoading = false;

  changeIsLoading() {
    isLoading = !isLoading;
    update();
  }

  encryptBytesAES(File file, String publicKey, encryptpackage.IV? outIV) async {
    try {
      Uint8List fileContent = await file.readAsBytes();
      final stopwatch = Stopwatch()..start();
      final encrypter = encryptpackage.Encrypter(
        encryptpackage.AES(
          encryptpackage.Key.fromBase16(privateKey!),
          mode: mode!,
        ),
      );
      final encryptpackage.Encrypted encrypted =
          encrypter.encryptBytes(fileContent, iv: outIV ?? publicIV);
      finishTime = (stopwatch.elapsed.inMicroseconds) / 1000;
      cyper = encrypted.bytes;
      update();
    } catch (e) {
      Get.snackbar(
          "Error", "Some Error Occured while encrypting file Try Again",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white);
    }
  }

  selectFileToEncrypt() async {
    try {
      fileAndExtention = await selectFile();
      update();
    } catch (e) {
      Get.snackbar("Error", "Some Error Occured while selecting file Try Again",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white);
    }
  }

  changePrivateKey() async {
    try {
      SelectFileReturn select = await selectFile(
          fileType: FileType.custom, allowedExtensions: ['txt', 'pem']);
      privateKey = await select.file!.readAsString();
      update();
    } catch (e) {
      Get.snackbar("Error", "Some Error Occured",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white);
    }
  }

  changeIV() async {
    try {
      SelectFileReturn select = await selectFile(
          fileType: FileType.custom, allowedExtensions: ['txt', 'pem']);
      iv = encryptpackage.IV.fromBase16(await select.file!.readAsString());
      update();
    } catch (e) {
      Get.snackbar("Error", "Some Error Occured",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white);
    }
  }

  changeMode(encryptpackage.AESMode? newMode) {
    if (newMode != null) mode = newMode;
    update();
  }

  clearAll() {
    privateKey = null;
    cyper = null;
    fileAndExtention = null;
    update();
  }
}
