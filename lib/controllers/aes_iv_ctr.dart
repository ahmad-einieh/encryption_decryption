import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:encrypt/encrypt.dart';

class AESIVCtr extends GetxController {
  int? selectedValue = 16;
  String? IVgenerated;

  bool isLoading = false;

  changeIsLoading() {
    isLoading = !isLoading;
    update();
  }

  changeSelectedValue(int? newValue) {
    if (newValue != null) selectedValue = newValue;
    update();
  }

  generateIV() {
    try {
      final iv = IV.fromSecureRandom(selectedValue ?? 16);
      IVgenerated = iv.base16;
      update();
    } catch (e) {
      Get.snackbar("Error", "Something went wrong while generating IV",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white);
    }
  }
}
