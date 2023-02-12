import 'package:fast_rsa/fast_rsa.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RSAEncryptctr extends GetxController {
  String? publicKey;
  String? plainText;

  bool isGetPublicFromFile = false;
  bool isGetTextFromFile = false;
  bool isShowText = false;

  String? cyper;

  num? finishTime;

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

  clearAll({isClearText = true}) {
    publicKey = null;
    plainText = null;
    isGetPublicFromFile = false;
    isGetTextFromFile = false;
    if (isClearText) {
      cyper = null;
    }
    update();
  }

  encrypt(String plainText, String publicKey) async {
    isShowText = false;
    try {
      final stopwatch = Stopwatch()..start();
      cyper = await RSA.encryptPKCS1v15(plainText, publicKey);
      finishTime = (stopwatch.elapsed.inMicroseconds) / 1000;
    } catch (e) {
      Get.defaultDialog(
          backgroundColor: Colors.red,
          title: "Error",
          middleText: "Error in encryption try again with correct key");
      Future.delayed(const Duration(seconds: 16), () {
        Get.back();
      });
      return false;
    }
    // clearAll();
    update();
    return true;
  }

  changeIsShowText() {
    isShowText = !isShowText;
    update();
  }
}
