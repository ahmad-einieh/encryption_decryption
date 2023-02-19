import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
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
        decoration: mainDecoration,
        child: Column(
          children: [
            const UpperBar(),
            SizedBox(height: MediaQuery.of(context).size.height * 0.09),
            const Text("RSA Verify Page", style: mainTextStyle),
            SizedBox(height: MediaQuery.of(context).size.height * 0.08),
            SingleChildScrollView(
              child: GetBuilder<RSAVerfiyCtr>(
                init: RSAVerfiyCtr(),
                builder: (valueCTr) {
                  return Column(
                    children: [
                      GeneralButton(
                        buttonText: "Select Public Key",
                        width: 444,
                        onPressed: () async => await valueCTr.changePublicKey(),
                      ),
                      const SizedBox(height: 20),
                      GeneralButton(
                        buttonText: "Select Signed File",
                        width: 444,
                        onPressed: () async {
                          await valueCTr.selectHashedFile();
                        },
                      ),
                      const SizedBox(height: 20),
                      GeneralButton(
                        buttonText: "Select Orginal File",
                        width: 444,
                        onPressed: () async =>
                            await valueCTr.selectFileToVerfiy(),
                      ),
                      const SizedBox(height: 20),
                      GeneralButton(
                        buttonText: "Verify",
                        width: 246,
                        onPressed: () async {
                          valueCTr.changeIsLoading();
                          await valueCTr.verfiyRSA();
                          valueCTr.changeIsLoading();
                        },
                      ),
                      const SizedBox(height: 15),
                      valueCTr.finishTime != null
                          ? SelectableText(
                              "Finish Time: ${valueCTr.finishTime} ms",
                              style: const TextStyle(
                                  color: Colors.white, fontSize: 16),
                            )
                          : const SizedBox(),
                      SizedBox(
                          height: MediaQuery.of(context).size.height * 0.05),
                      valueCTr.isLoading
                          ? const SpinKitPouringHourGlass(
                              color: Colors.white,
                              size: 66.6,
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
