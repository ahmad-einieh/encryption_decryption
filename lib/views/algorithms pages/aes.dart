import 'package:flutter/material.dart';

import '../../helper/style.dart';
import '../widgets/general/general_card.dart';
import '../widgets/homepage_widgets/upper_bar.dart';

class AESscreenPage extends StatelessWidget {
  const AESscreenPage({super.key});

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
            const UpperBar(),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.1,
            ),
            const Text(
              "AES Page",
              style: TextStyle(
                  color: Colors.cyan,
                  fontSize: 32,
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.1,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GeneralCard(
                    title: "Get Keys",
                    svgPath: "assets/key smartphone.svg",
                    color: Colors.white,
                    function: () {}),
                GeneralCard(
                    title: "Encryption",
                    svgPath: "assets/enscript.svg",
                    color: Colors.white,
                    function: () {}),
                GeneralCard(
                    title: "Decryption",
                    svgPath: "assets/folder.svg",
                    color: Colors.white,
                    function: () {}),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
