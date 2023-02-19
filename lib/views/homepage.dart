import 'package:encryption_decryption/helper/methods.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../helper/style.dart';
import '../router/router.dart';
import 'widgets/homepage_widgets/home_page_content.dart';
import 'widgets/homepage_widgets/upper_bar.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return RawKeyboardListener(
      focusNode: FocusNode(),
      autofocus: true,
      onKey: (event) {
        var letter = event.logicalKey.keyLabel;
        if (letter == "R" || letter == "r") {
          Get.toNamed(RouterName.rsa);
        } else if (letter == "A" || letter == "a") {
          Get.toNamed(RouterName.aes);
        }
      },
      child: Scaffold(
        body: Container(
          decoration: mainDecoration,
          child: Column(
            children: [
              const UpperBar(),
              SizedBox(height: MediaQuery.of(context).size.height * 0.22),
              const HomePageContent(),
            ],
          ),
        ),
      ),
    );
  }
}
