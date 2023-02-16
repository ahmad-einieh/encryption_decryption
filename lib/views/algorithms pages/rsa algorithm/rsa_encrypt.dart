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
        decoration: mainDecoration,
        child: Column(
          children: [
            const UpperBar(),
            SizedBox(height: MediaQuery.of(context).size.height * 0.09),
            const Text("RSA Encrypt Page", style: mainTextStyle),
            SizedBox(height: MediaQuery.of(context).size.height * 0.08),
            SingleChildScrollView(
              child: GetBuilder<RSAEncryptctr>(
                init: RSAEncryptctr(),
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
                        buttonText: "Select File to Encrypt",
                        width: 444,
                        onPressed: () async =>
                            await valueCTr.selectFileToEncrypt(),
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
                          var deviceInfo = await getDeviceAndUserName();
                          await saveFile(
                              bytes: valueCTr.cyper,
                              fileName:
                                  "enctypted_file RSA $deviceInfo ${DateTime.now()}.${valueCTr.fileAndExtention!.extension}"
                                      .replaceAll(':', '--'));
                          valueCTr.clearAll();
                        },
                      ),
                      const SizedBox(height: 15),
                      valueCTr.finishTime != null
                          ? SelectableText(
                              'Finish Time: ${valueCTr.finishTime} ms',
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
