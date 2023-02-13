import 'package:encryption_decryption/controllers/rsa_encrypt_ctr.dart';
import 'package:encryption_decryption/views/widgets/general/general_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../helper/methods.dart';
import '../../../helper/style.dart';
import '../../widgets/homepage_widgets/upper_bar.dart';

class RSAEncrypt extends StatelessWidget {
  const RSAEncrypt({super.key});

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
              child: GetBuilder<RSAEncryptctr>(
                init: RSAEncryptctr(),
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
                        buttonText: "Select File to Encrypt",
                        width: 444,
                        onPressed: () async {
                          await valueCTr.selectFileToEncrypt();
                        },
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      GeneralButton(
                        buttonText: "Encrypt",
                        width: 246,
                        onPressed: () async {
                          await valueCTr.encryptBytesRSA(
                              valueCTr.fileAndExtention!.file!,
                              valueCTr.publicKey!);
                          await saveFile(
                              bytes: valueCTr.cyper,
                              fileName:
                                  "enctypted_file RSA ${DateTime.now()}.${valueCTr.fileAndExtention!.extension}"
                                      .replaceAll(':', '--'));
                          valueCTr.clearAll();
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
