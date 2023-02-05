import 'package:fast_rsa/fast_rsa.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AESDecryptctr extends GetxController {
  String? privateKey;
  String? cyperText;

  bool isGetPrivateFromFile = false;
  bool isGetTextFromFile = false;

  String? plain;

  changePrivateKey(newPublicKey, {isFromFile = true}) {
    privateKey = newPublicKey;
    if (isFromFile) {
      isGetPrivateFromFile = true;
    }
    update();
  }

  changeCyperText(newPlainText, {isFromButton = true}) {
    cyperText = newPlainText;
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
      plain = await RSA.decryptPKCS1v15(cyperText, privateKey);
      // update();
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