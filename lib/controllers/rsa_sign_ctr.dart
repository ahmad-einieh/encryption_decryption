import 'package:fast_rsa/fast_rsa.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
      signResult =
          await RSA.signPKCS1v15Bytes(messageBytes, Hash.SHA512, privateKey);
      finishTime = (stopwatch.elapsed.inMicroseconds) / 1000;
      print(signResult);
    } catch (e) {
      print(e);
    }
    update();
  }

  selectFileToSign() async {
    fileAndExtention = await selectFile();
    messageBytes = await fileAndExtention!.file!.readAsBytes();
    update();
  }

  changePrivateKey() async {
    try {
      SelectFileReturn select = await selectFile(
          fileType: FileType.custom, allowedExtensions: ['txt']);
      privateKey = await select.file!.readAsString();
    } catch (e) {
      Get.snackbar("Error", "Some Error Occured",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white);
    }
    update();
  }
}
