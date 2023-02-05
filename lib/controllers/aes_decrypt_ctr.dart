import 'package:encrypt/encrypt.dart' as encryptpackage;
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../helper/constant.dart';

class AESDecryptctr extends GetxController {
  String? privateKey;
  String? cyperText;

  bool isGetPrivateFromFile = false;
  bool isGetTextFromFile = false;

  String? plain;

  changePrivateKey(newPrivateKey, {isFromFile = true}) {
    privateKey = newPrivateKey;
    if (isFromFile) {
      isGetPrivateFromFile = true;
    }
    update();
  }

  changeCyperText(newCyperText, {isFromButton = true}) {
    cyperText = newCyperText;
    if (isFromButton) {
      isGetTextFromFile = true;
    }
    update();
  }

  clearAll() {
    privateKey = null;
    cyperText = null;
    plain = null;
    isGetPrivateFromFile = false;
    isGetTextFromFile = false;
    update();
  }

  decrypt(String cyperText, String privateKey) async {
    try {
      final encrypter = encryptpackage.Encrypter(
          encryptpackage.AES(encryptpackage.Key.fromBase16(privateKey)));

      plain = encrypter.decrypt(encryptpackage.Encrypted.fromBase16(cyperText),
          iv: iv);
    } catch (e) {
      Get.defaultDialog(
          backgroundColor: Colors.red,
          title: "Error",
          middleText: "Error in encryption try again with correct key");
      Future.delayed(const Duration(seconds: 16), () {
        // Do something
        Get.back();
      });
      return false;
    }
    // clearAll();
    update();
    return true;
  }
}
