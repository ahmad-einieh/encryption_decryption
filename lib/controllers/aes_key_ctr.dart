import 'package:encrypt/encrypt.dart' as encrypt;
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AESKeyCtr extends GetxController {
  int? selectedValue = 16;
  String? privateKey;
  bool isLoading = false;

  changeSelectedValue(int? newValue) {
    if (newValue != null) selectedValue = newValue;
    update();
  }

  changeIsLoading() {
    isLoading = !isLoading;
    update();
  }

  generateKey() async {
    try {
      final encrypt.Key key = encrypt.Key.fromSecureRandom(selectedValue ?? 16);
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
