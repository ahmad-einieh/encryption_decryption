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

  bool isLoading = false;

  changeIsLoading() {
    isLoading = !isLoading;
    update();
  }

  encryptBytesRSA(File file, String publicKey) async {
    try {
      Uint8List fileContent = await file.readAsBytes();
      final stopwatch = Stopwatch()..start();
      cyper = await RSA.encryptPKCS1v15Bytes(fileContent, publicKey);
      finishTime = (stopwatch.elapsed.inMicroseconds) / 1000;
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

  changePublicKey() async {
    try {
      SelectFileReturn select = await selectFile(
          fileType: FileType.custom, allowedExtensions: ['txt', 'pem']);
      publicKey = await select.file!.readAsString();
      update();
    } catch (e) {
      Get.snackbar("Error", "Some Error Occured",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white);
    }
  }

  clearAll() {
    publicKey = null;
    cyper = null;
    fileAndExtention = null;
    update();
  }

  // convertPrivateToPublic(privateKey) async {
  //   var result = await RSA.convertPrivateKeyToPublicKey(privateKey);
  // }
}
