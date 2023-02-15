import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controllers/aes_encrypt_ctr.dart';
import '../../../helper/methods.dart';
import '../../../helper/style.dart';
import '../../widgets/general/general_button.dart';
import '../../widgets/homepage_widgets/upper_bar.dart';

class AESEncrypt extends StatelessWidget {
  const AESEncrypt({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: mainDecoration,
        child: Column(
          children: [
            const UpperBar(),
            SizedBox(height: MediaQuery.of(context).size.height * 0.09),
            const Text("AES Encrypt Page", style: mainTextStyle),
            SizedBox(height: MediaQuery.of(context).size.height * 0.08),
            SingleChildScrollView(
              child: GetBuilder<AESEncryptctr>(
                init: AESEncryptctr(),
                builder: (valueCTr) {
                  return Column(
                    children: [
                      GeneralButton(
                        buttonText: "Select Private Key",
                        width: 444,
                        onPressed: () async =>
                            await valueCTr.changePrivateKey(),
                      ),
                      const SizedBox(height: 20),
                      GeneralButton(
                        buttonText: "Select File to Encrypt",
                        width: 444,
                        onPressed: () async =>
                            await valueCTr.selectFileToEncrypt(),
                      ),
                      const SizedBox(height: 20),
                      GeneralButton(
                        buttonText: "Encrypt",
                        width: 246,
                        onPressed: () async {
                          await valueCTr.encryptBytesAES(
                              valueCTr.fileAndExtention!.file!,
                              valueCTr.privateKey!);
                          await saveFile(
                              bytes: valueCTr.cyper,
                              fileName:
                                  "enctypted_file AES ${DateTime.now()}.${valueCTr.fileAndExtention!.extension}"
                                      .replaceAll(':', '--'));
                          valueCTr.clearAll();
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
