import 'package:encryption_decryption/router/router.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../general/general_card.dart';

class HomePageContent extends StatelessWidget {
  const HomePageContent({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        GeneralCard(
          title: "RSA",
          svgPath: "assets/Laptop.svg",
          color: Colors.white,
          function: () {
            Get.toNamed(RouterName.rsa);
          },
        ),
        GeneralCard(
          title: "AES",
          svgPath: "assets/Laptop.svg",
          color: Colors.white,
          function: () {
            Get.toNamed(RouterName.aes);
          },
        ),
      ],
    );
  }
}
