import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controllers/rsa_verfiy_ctr.dart';
import '../../../helper/style.dart';
import '../../widgets/general/general_button.dart';
import '../../widgets/homepage_widgets/upper_bar.dart';

class RSAVerify extends StatelessWidget {
  const RSAVerify({super.key});

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
              height: MediaQuery.of(context).size.height * 0.09,
            ),
            const Text(
              "RSA Encrypt Page",
              style: TextStyle(
                  color: Colors.cyan,
                  fontSize: 32,
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.08,
            ),
            SingleChildScrollView(
              child: GetBuilder<RSAVerfiyCtr>(
                init: RSAVerfiyCtr(),
                builder: (valueCTr) {
                  return Column(
                    children: [
                      GeneralButton(
                        buttonText: "Select Public Key",
                        width: 444,
                        onPressed: () async {
                          await valueCTr.changePublicKey();
                        },
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      GeneralButton(
                        buttonText: "Select Signed File",
                        width: 444,
                        onPressed: () async {
                          await valueCTr.selectHashedFile();
                        },
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      GeneralButton(
                        buttonText: "Select Orginal File",
                        width: 444,
                        onPressed: () async {
                          await valueCTr.selectFileToVerfiy();
                        },
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      GeneralButton(
                        buttonText: "Verify",
                        width: 246,
                        onPressed: () async {
                          await valueCTr.verfiyRSA();
                        },
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      valueCTr.finishTime != null
                          ? Text(
                              "Finish Time: ${valueCTr.finishTime}",
                              style: const TextStyle(
                                  color: Colors.white, fontSize: 16),
                            )
                          : const SizedBox(),
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
