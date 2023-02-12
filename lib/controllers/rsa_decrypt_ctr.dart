import 'package:fast_rsa/fast_rsa.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AESDecryptctr extends GetxController {
  String? privateKey;
  String? cyperText;

  bool isGetPrivateFromFile = false;
  bool isGetTextFromFile = false;
  bool isShowText = false;

  String? plain;

  num? finishTime;

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

  clearAll({isClearText = true}) {
    privateKey = null;
    cyperText = null;
    isGetPrivateFromFile = false;
    isGetTextFromFile = false;
    if (isClearText) {
      plain = null;
    }
    update();
  }

  decrypt(String cyperText, String privateKey) async {
    try {
      final stopwatch = Stopwatch()..start();
      plain = await RSA.decryptPKCS1v15(cyperText, privateKey);
      finishTime = (stopwatch.elapsed.inMicroseconds) / 1000;
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

  changeIsShowText() {
    isShowText = !isShowText;
    update();
  }
}
