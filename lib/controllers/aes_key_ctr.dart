import 'package:encrypt/encrypt.dart' as encrypt;
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AESKeyCtr extends GetxController {
  int? selectedValue = 16;
  String? privateKey;

  changeSelectedValue(int? newValue) {
    selectedValue = newValue;
    update();
  }

  generateKey() async {
    try {
      final encrypt.Key key = encrypt.Key.fromSecureRandom(selectedValue!);
      privateKey = key.base16;
      update();
    } catch (e) {
      Get.snackbar("Error", "Something went wrong while generating keys",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white);
    }
  }
}
