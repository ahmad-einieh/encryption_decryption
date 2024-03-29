import 'package:encryption_decryption/router/router.dart';
import 'package:encryption_decryption/views/widgets/general/general_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../helper/style.dart';
import '../../widgets/homepage_widgets/upper_bar.dart';

class RSAscreenPage extends StatelessWidget {
  const RSAscreenPage({super.key});

  @override
  Widget build(BuildContext context) {
    return RawKeyboardListener(
      focusNode: FocusNode(),
      autofocus: true,
      onKey: (event) {
        var letter = event.logicalKey.keyLabel;
        if (letter == "Backspace") {
          Get.back();
        }
      },
      child: Scaffold(
        body: Container(
          decoration: mainDecoration,
          child: Column(
            children: [
              const UpperBar(),
              SizedBox(height: MediaQuery.of(context).size.height * 0.1),
              const Text("RSA Page", style: mainTextStyle),
              SizedBox(height: MediaQuery.of(context).size.height * 0.1),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GeneralCard(
                        title: "Get Keys",
                        svgPath: "assets/key smartphone.svg",
                        color: Colors.white,
                        function: () => Get.toNamed(RouterName.resGeneratekey),
                      ),
                      GeneralCard(
                        title: "Encryption",
                        svgPath: "assets/enscript.svg",
                        color: Colors.white,
                        function: () => Get.toNamed(RouterName.resEncrypt),
                      ),
                      GeneralCard(
                        title: "Decryption",
                        svgPath: "assets/folder.svg",
                        color: Colors.white,
                        function: () => Get.toNamed(RouterName.resDecrypt),
                      ),
                      GeneralCard(
                        title: "Sign",
                        svgPath: "assets/user.svg",
                        color: Colors.white,
                        function: () => Get.toNamed(RouterName.sign),
                      ),
                      GeneralCard(
                        title: "Verify",
                        svgPath: "assets/finger print.svg",
                        color: Colors.white,
                        function: () => Get.toNamed(RouterName.verify),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
