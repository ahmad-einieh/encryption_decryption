import 'dart:io';

import 'package:encrypt/encrypt.dart' as encryptpackage;
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../helper/constant.dart';
import '../helper/methods.dart';
import '../helper/select_file_return.dart';

class AESDecryptctr extends GetxController {
  // String? privateKey;
  // String? cyperText;

  // bool isGetPrivateFromFile = false;
  // bool isGetTextFromFile = false;
  // bool isShowText = false;

  // String? plain;

  // num? finishTime;

  // changePrivateKey(newPrivateKey, {isFromFile = true}) {
  //   privateKey = newPrivateKey;
  //   if (isFromFile) {
  //     isGetPrivateFromFile = true;
  //   }
  //   update();
  // }

  // changeCyperText(newCyperText, {isFromButton = true}) {
  //   cyperText = newCyperText;
  //   if (isFromButton) {
  //     isGetTextFromFile = true;
  //   }
  //   update();
  // }

  // clearAll({isClearText = true}) {
  //   privateKey = null;
  //   cyperText = null;
  //   isGetPrivateFromFile = false;
  //   isGetTextFromFile = false;
  //   if (isClearText) {
  //     plain = null;
  //   }
  //   update();
  // }

  // decrypt(String cyperText, String privateKey) async {
  //   try {
  //     final stopwatch = Stopwatch()..start();
  //     final encrypter = encryptpackage.Encrypter(
  //         encryptpackage.AES(encryptpackage.Key.fromBase16(privateKey)));
  //     plain = encrypter.decrypt(encryptpackage.Encrypted.fromBase16(cyperText),
  //         iv: iv);
  //     finishTime = (stopwatch.elapsed.inMicroseconds) / 1000;
  //   } catch (e) {
  //     Get.defaultDialog(
  //         backgroundColor: Colors.red,
  //         title: "Error",
  //         middleText: "Error in encryption try again with correct key");
  //     Future.delayed(const Duration(seconds: 16), () {
  //       // Do something
  //       Get.back();
  //     });
  //     return false;
  //   }
  //   // clearAll();
  //   update();
  //   return true;
  // }

  // changeIsShowText() {
  //   isShowText = !isShowText;
  //   update();
  // }

  num? finishTime;
  SelectFileReturn? fileAndExtention;
  String? privateKey;

  Uint8List? plain;

  decryetBytesAES(File file, String privateKey) async {
    Uint8List fileContent = await file.readAsBytes();
    final stopwatch = Stopwatch()..start();
    final encryptpackage.Encrypter encrypter = encryptpackage.Encrypter(
        encryptpackage.AES(encryptpackage.Key.fromBase16(privateKey)));
    encryptpackage.Encrypted encrypted = encryptpackage.Encrypted(fileContent);
    plain = Uint8List.fromList(encrypter.decryptBytes(encrypted, iv: iv));
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
