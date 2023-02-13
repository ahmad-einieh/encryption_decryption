import 'package:flutter/material.dart';

import '../helper/methods.dart';
import '../helper/style.dart';
import 'widgets/homepage_widgets/home_page_content.dart';
import 'widgets/homepage_widgets/upper_bar.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                stops: const [0.0, 1.0],
                colors: [backgroundStartColor, backgroundEndColor])),
        child: Column(
          children: [
            UpperBar(),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.22,
            ),
            const HomePageContent(),
            ElevatedButton(
                onPressed: () async {
                  var x = await selectFile();
                  var y = await selectFile();
                  await encryptBytesRSA(
                      x.file!, await y.file!.readAsString(), "test.txt");
                  Future.delayed(
                    const Duration(seconds: 5),
                  );
                  x = await selectFile();
                  y = await selectFile();
                  await decryetBytesRSA(
                      x.file!, await y.file!.readAsString(), "test2.txt");
                },
                child: const Text("Encrypt")),
          ],
        ),
      ),
    );
  }
}
