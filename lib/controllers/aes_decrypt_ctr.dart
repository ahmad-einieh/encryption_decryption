import 'dart:io';

import 'package:encrypt/encrypt.dart' as encryptpackage;
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../helper/methods.dart';
import '../helper/select_file_return.dart';

class AESDecryptctr extends GetxController {
  encryptpackage.IV iv =
      encryptpackage.IV.fromBase16('505b8e8b5374eea4670cedffd1288b9c');

  num? finishTime;
  SelectFileReturn? fileAndExtention;
  String? privateKey;
  encryptpackage.AESMode? mode = encryptpackage.AESMode.sic;

  Uint8List? plain;

  bool isLoading = false;

  changeIsLoading() {
    isLoading = !isLoading;
    update();
  }

  decryetBytesAES(File file, String privateKey, encryptpackage.IV outIV) async {
    try {
      Uint8List fileContent = await file.readAsBytes();
      final stopwatch = Stopwatch()..start();
      final encryptpackage.Encrypter encrypter = encryptpackage.Encrypter(
        encryptpackage.AES(
          encryptpackage.Key.fromBase16(privateKey),
          mode: mode!,
        ),
      );
      encryptpackage.Encrypted encrypted =
          encryptpackage.Encrypted(fileContent);
      plain = Uint8List.fromList(encrypter.decryptBytes(encrypted, iv: outIV));
      finishTime = (stopwatch.elapsed.inMicroseconds) / 1000;
      update();
    } catch (e) {
      Get.snackbar(
          "Error", "Some Error Occured while decrypting file Try Again",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white);
    }
  }

  selectFileToDecrypt() async {
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
          colorText: Colors.white,
          duration: const Duration(seconds: 5));
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
    plain = null;
    fileAndExtention = null;
    update();
  }
}
