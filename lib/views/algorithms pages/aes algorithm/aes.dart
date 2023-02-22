import 'package:encryption_decryption/router/router.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../helper/style.dart';
import '../../widgets/general/general_card.dart';
import '../../widgets/homepage_widgets/upper_bar.dart';

class AESscreenPage extends StatelessWidget {
  const AESscreenPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: mainDecoration,
        child: Column(
          children: [
            const UpperBar(),
            SizedBox(height: MediaQuery.of(context).size.height * 0.1),
            const Text("AES Page", style: mainTextStyle),
            SizedBox(height: MediaQuery.of(context).size.height * 0.1),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GeneralCard(
                    title: "Get Key",
                    svgPath: "assets/key smartphone.svg",
                    color: Colors.white,
                    function: () => Get.toNamed(RouterName.aesGenerateKey),
                  ),
                  GeneralCard(
                    title: "Encryption",
                    svgPath: "assets/enscript.svg",
                    color: Colors.white,
                    function: () => Get.toNamed(RouterName.aesEncrypt),
                  ),
                  GeneralCard(
                    title: "Decryption",
                    svgPath: "assets/folder.svg",
                    color: Colors.white,
                    function: () => Get.toNamed(RouterName.aesDecrypt),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
