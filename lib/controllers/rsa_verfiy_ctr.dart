import 'package:fast_rsa/fast_rsa.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../helper/methods.dart';
import '../helper/select_file_return.dart';

class RSAVerfiyCtr extends GetxController {
  String? publicKey;
  Uint8List? messageBytes;
  Uint8List? signatureBytes;
  bool? signResult;
  SelectFileReturn? fileAndExtention;
  num? finishTime;

  verfiyRSA() async {
    final stopwatch = Stopwatch()..start();
    signResult = await RSA.verifyPSSBytes(
        signatureBytes!, messageBytes!, Hash.SHA1, SaltLength.AUTO, publicKey!);
    finishTime = (stopwatch.elapsed.inMicroseconds) / 1000;
    update();
    if (signResult!) {
      Get.defaultDialog(
          title: "Verified",
          middleText: "Signature is verified",
          backgroundColor: Colors.green,
          titleStyle: const TextStyle(color: Colors.white),
          middleTextStyle: const TextStyle(color: Colors.white));
    } else {
      Get.defaultDialog(
          title: "Not Verified",
          middleText: "Signature is not verified",
          backgroundColor: Colors.red,
          titleStyle: const TextStyle(color: Colors.white),
          middleTextStyle: const TextStyle(color: Colors.white));
    }
    Future.delayed(const Duration(seconds: 3), () {
      Get.back();
    });
  }

  selectFileToVerfiy() async {
    fileAndExtention = await selectFile();
    messageBytes = await fileAndExtention!.file!.readAsBytes();
    update();
  }

  selectHashedFile() async {
    fileAndExtention = await selectFile();
    signatureBytes = await fileAndExtention!.file!.readAsBytes();
    update();
  }

  changePublicKey() async {
    try {
      SelectFileReturn select = await selectFile(
          fileType: FileType.custom, allowedExtensions: ['txt']);
      publicKey = await select.file!.readAsString();
    } catch (e) {
      Get.snackbar("Error", "Some Error Occured",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white);
    }
    update();
  }
}
