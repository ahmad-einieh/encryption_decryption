import 'package:encrypt/encrypt.dart';
import 'package:get/get.dart';

class AESKeyCtr extends GetxController {
  int? selectedValue = 16;
  String? privateKey;

  changeSelectedValue(int? newValue) {
    selectedValue = newValue;
    update();
  }

  generateKey() async {
    final Key key = Key.fromSecureRandom(selectedValue!);
    privateKey = key.base16;
    update();
  }
}
