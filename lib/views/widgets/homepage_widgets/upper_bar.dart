import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
// import 'package:path/path.dart';

import '../../../helper/style.dart';
import '../../../router/router.dart';

class UpperBar extends StatelessWidget {
  UpperBar({
    super.key,
  });
  var settingsIcon = IconButton(
    onPressed: () {
      // Get.toNamed(RouterName.homepage);
    },
    icon: const Icon(
      Icons.settings_outlined,
      size: 24,
    ),
  );
  @override
  Widget build(BuildContext context) {
    return WindowTitleBarBox(
      child: Row(
        children: [
          ModalRoute.of(context)!.settings.name == RouterName.homepage
              ? settingsIcon
              : Row(
                  children: [
                    IconButton(
                      onPressed: () {
                        Get.back();
                      },
                      icon: const Icon(
                        Icons.arrow_back,
                        size: 24,
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        Get.toNamed(RouterName.homepage);
                      },
                      icon: const Icon(
                        Icons.home_outlined,
                        size: 24,
                      ),
                    ),
                    settingsIcon,
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
