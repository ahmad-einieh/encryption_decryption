import 'package:fast_rsa/fast_rsa.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RSAKeyCtr extends GetxController {
  int? selectedValue = 256;
  String? publicKey;
  String? privateKey;

  changeSelectedValue(int? newValue) {
    selectedValue = newValue;
    update();
  }

  generateKey() async {
    try {
      var result = await RSA.generate(selectedValue ?? 256);
      publicKey = result.publicKey;
      privateKey = result.privateKey;
      update();
    } catch (e) {
      Get.snackbar("Error", "Something went wrong while generating keys",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white);
    }
  }
}
