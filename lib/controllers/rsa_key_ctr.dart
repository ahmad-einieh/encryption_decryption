import 'package:fast_rsa/fast_rsa.dart';
import 'package:get/get.dart';

import '../helper/constant.dart';

class RSAKeyCtr extends GetxController {
  int? selectedValue = 64;
  String publicKey = "";
  String privateKey = "";
  changeSelectedValue(int? newValue) {
    selectedValue = newValue;
    update();
  }

  generateKey() async {
    var result = await RSA.generate(selectedValue ?? 64);
    publicKey = result.publicKey;
    privateKey = result.privateKey;
    storage.write("publicKey", publicKey);
    storage.write("rsa_privateKey", privateKey);
    update();
  }
}
