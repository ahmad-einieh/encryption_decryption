import 'package:fast_rsa/fast_rsa.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../helper/methods.dart';
import '../helper/select_file_return.dart';

class RSASignCtr extends GetxController {
  String? privateKey;
  Uint8List? messageBytes;
  Uint8List? signResult;
  SelectFileReturn? fileAndExtention;
  num? finishTime;

  signBytesRSA(Uint8List messageBytes, String privateKey) async {
    try {
      final stopwatch = Stopwatch()..start();
      signResult = await RSA.signPSSBytes(
          messageBytes, Hash.SHA1, SaltLength.AUTO, privateKey);
      finishTime = (stopwatch.elapsed.inMicroseconds) / 1000;
      update();
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }

  selectFileToSign() async {
    try {
      fileAndExtention = await selectFile();
      messageBytes = await fileAndExtention!.file!.readAsBytes();
      update();
    } catch (e) {
      Get.snackbar("Error", "Some Error Occured while selecting file Try Again",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white);
    }
  }

  changePrivateKey() async {
    try {
      SelectFileReturn select = await selectFile(
          fileType: FileType.custom, allowedExtensions: ['txt']);
      privateKey = await select.file!.readAsString();
      update();
    } catch (e) {
      Get.snackbar("Error", "Some Error Occured",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white);
    }
  }
}
