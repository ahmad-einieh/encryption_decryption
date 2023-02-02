import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.red,
      body: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Card(
              color: Colors.amber,
              child: SizedBox(
                  width: 300,
                  height: 432,
                  child: ElevatedButton(
                    onPressed: () async {
                      FilePickerResult? result =
                          await FilePicker.platform.pickFiles();

                      if (result != null) {
                        File file = File(result.files.single.path!);
                        // file.readAsBytes().then((value) => print(value));
                        file.readAsString().then((value) => print(value));
                      } else {
                        // User canceled the picker
                      }
                    },
                    child: const Text('Click Me'),
                  )),
            ),
            Card(
              color: Colors.amber,
              child: SizedBox(
                width: 300,
                height: 432,
                child: Column(
                  children: [
                    SvgPicture.asset(
                      "assets/Laptop.svg",
                      height: 100,
                      width: 100,
                      colorFilter:
                          const ColorFilter.mode(Colors.blue, BlendMode.srcIn),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
