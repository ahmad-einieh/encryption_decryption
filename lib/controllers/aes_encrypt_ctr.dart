import 'package:encrypt/encrypt.dart' as encryptpackage;
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../helper/constant.dart';

class AESEncryptctr extends GetxController {
  String? privateKey;
  String? plainText;

  bool isGetPrivateFromFile = false;
  bool isGetTextFromFile = false;
  bool isShowText = false;

  String? cyper;

  changePrivateKey(newPublicKey, {isFromFile = true}) {
    privateKey = newPublicKey;
    if (isFromFile) {
      isGetPrivateFromFile = true;
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
    privateKey = null;
    plainText = null;
    isGetPrivateFromFile = false;
    isGetTextFromFile = false;
    if (isClearText) {
      cyper = null;
    }
    update();
  }

  encrypt(String plainText, String privateKey) async {
    try {
      final stopwatch = Stopwatch()..start();
      final encrypter = encryptpackage.Encrypter(
          encryptpackage.AES(encryptpackage.Key.fromBase16(privateKey)));
      final encryptpackage.Encrypted encrypted =
          encrypter.encrypt(plainText, iv: iv);
      if (kDebugMode) {
        print('doSomething() executed in ${stopwatch.elapsed.inMilliseconds}');
      }
      cyper = encrypted.base16;
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
    update();
    return true;
  }

  changeIsShowText() {
    isShowText = !isShowText;
    update();
  }
}
