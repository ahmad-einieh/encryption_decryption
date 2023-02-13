import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controllers/rsa_sign_ctr.dart';
import '../../../helper/methods.dart';
import '../../../helper/style.dart';
import '../../widgets/general/general_button.dart';
import '../../widgets/homepage_widgets/upper_bar.dart';

class RSASign extends StatelessWidget {
  const RSASign({super.key});

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
              child: GetBuilder<RSASignCtr>(
                init: RSASignCtr(),
                builder: (valueCTr) {
                  return Column(
                    children: [
                      GeneralButton(
                        buttonText: "Select Private Key",
                        width: 444,
                        onPressed: () async {
                          await valueCTr.changePrivateKey();
                        },
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      GeneralButton(
                        buttonText: "Select File to Sign",
                        width: 444,
                        onPressed: () async {
                          await valueCTr.selectFileToSign();
                        },
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      GeneralButton(
                        buttonText: "Sign File",
                        width: 246,
                        onPressed: () async {
                          await valueCTr.signBytesRSA(
                              valueCTr.messageBytes!, valueCTr.privateKey!);
                          await saveFile(
                              bytes: valueCTr.signResult!,
                              fileName:
                                  "signed_file RSA ${DateTime.now()}.${valueCTr.fileAndExtention!.extension}"
                                      .replaceAll(':', '--'));
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
