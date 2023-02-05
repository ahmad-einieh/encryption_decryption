import 'package:encrypt/encrypt.dart';
import 'package:get/get.dart';

import '../helper/constant.dart';

class AESKeyCtr extends GetxController {
  int? selectedValue = 16;
  String privateKey = "";
  bool isOpend = false;

  changeSelectedValue(int? newValue) {
    selectedValue = newValue;
    update();
  }

  generateKey() async {
    final Key key = Key.fromSecureRandom(selectedValue!);
    privateKey = key.base16;
    storage.write("aes_privateKey", privateKey);
    update();
  }

  changeOpenEye() {
    isOpend = !isOpend;
    update();
  }
}
