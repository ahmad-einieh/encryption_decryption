import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
// import 'package:path/path.dart';

import '../../../helper/style.dart';
import '../../../router/router.dart';

class UpperBar extends StatelessWidget {
  const UpperBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return WindowTitleBarBox(
      child: Row(
        children: [
          ModalRoute.of(context)!.settings.name == RouterName.homepage
              ? const SizedBox()
              : Row(
                  children: [
                    IconButton(
                        onPressed: () {
                          Get.back();
                        },
                        icon: const Icon(
                          Icons.arrow_back,
                          size: 24,
                        )),
                    IconButton(
                        onPressed: () {
                          Get.toNamed(RouterName.homepage);
                        },
                        icon: const Icon(
                          Icons.home_outlined,
                          size: 24,
                        )),
                  ],
                ),
          Expanded(child: Container()),
          Row(
            children: [
              MinimizeWindowButton(
                colors: buttonColors,
              ),
              MaximizeWindowButton(
                colors: buttonColors,
              ),
              CloseWindowButton(),
            ],
          ),
        ],
      ),
    );
  }
}
