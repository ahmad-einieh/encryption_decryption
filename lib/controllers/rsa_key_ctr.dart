import 'package:fast_rsa/fast_rsa.dart';
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
    var result = await RSA.generate(selectedValue ?? 256);
    publicKey = result.publicKey;
    privateKey = result.privateKey;
    update();
  }
}
