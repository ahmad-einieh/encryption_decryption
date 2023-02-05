import 'package:fast_rsa/fast_rsa.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AESEncryptctr extends GetxController {
  String? publicKey;
  String? plainText;

  bool isGetPublicFromFile = false;
  bool isGetTextFromFile = false;

  String? cyper;

  changePublicKey(newPublicKey, {isFromFile = true}) {
    publicKey = newPublicKey;
    if (isFromFile) {
      isGetPublicFromFile = true;
    }
    update();
  }

  changePlainText(newPlainText, {isFromButton = true}) {
    plainText = newPlainText;
    if (isFromButton) {
      isGetTextFromFile = true;
    }
    update();
  }

  clearAll() {
    publicKey = null;
    plainText = null;
    cyper = null;
    isGetPublicFromFile = false;
    isGetTextFromFile = false;
    update();
  }

  encrypt(String plainText, String publicKey) async {
    try {
      cyper = await RSA.encryptPKCS1v15(plainText, publicKey);
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
