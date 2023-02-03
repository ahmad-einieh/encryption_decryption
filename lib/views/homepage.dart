import 'package:fast_rsa/fast_rsa.dart';
import 'package:flutter/material.dart';

import '../helper/style.dart';
import 'widgets/homepage_widgets/home_page_content.dart';
import 'widgets/homepage_widgets/upper_bar.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.red,
      body: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                stops: const [0.0, 1.0],
                colors: [backgroundStartColor, backgroundEndColor])),
        child: Column(
          children: [
            const UpperBar(),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.175,
            ),
            const HomePageContent(),
            ElevatedButton(
                onPressed: () async {
                  var result = await RSA.generate(512);
                  // print(result.privateKey);
                  // print(result.publicKey);
                  var e = await RSA.encryptPKCS1v15("ahmad", result.privateKey);
                  print(e);
                  var d = await RSA.decryptPKCS1v15(e, result.publicKey);
                  print(d);
                },
                child: Text("sdfs"))
          ],
        ),
      ),
    );
  }
}
