import 'package:get/get.dart';

class RSAKeyCtr extends GetxController {
  int? selectedValue = 64;
  changeSelectedValue(int? newValue) {
    selectedValue = newValue;
    update();
  }
}
