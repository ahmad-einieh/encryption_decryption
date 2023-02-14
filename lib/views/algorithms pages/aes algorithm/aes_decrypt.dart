import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controllers/aes_decrypt_ctr.dart';
import '../../../helper/methods.dart';
import '../../../helper/style.dart';
import '../../widgets/general/general_button.dart';
import '../../widgets/homepage_widgets/upper_bar.dart';

class AESDecrypt extends StatelessWidget {
  const AESDecrypt({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: mainDecoration,
        child: Column(
          children: [
            const UpperBar(),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.09,
            ),
            const Text(
              "AES Decrypt Page",
              style: TextStyle(
                  color: Colors.cyan,
                  fontSize: 32,
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.08,
            ),
            SingleChildScrollView(
              child: GetBuilder<AESDecryptctr>(
                init: AESDecryptctr(),
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
                        buttonText: "Select File to Decrypt",
                        width: 444,
                        onPressed: () async {
                          await valueCTr.selectFileToDecrypt();
                        },
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      GeneralButton(
                        buttonText: "Decrypt",
                        width: 246,
                        onPressed: () async {
                          await valueCTr.decryetBytesAES(
                              valueCTr.fileAndExtention!.file!,
                              valueCTr.privateKey!);
                          await saveFile(
                              bytes: valueCTr.plain,
                              fileName:
                                  "dectypted_file AES ${DateTime.now()}.${valueCTr.fileAndExtention!.extension}"
                                      .replaceAll(':', '--'));
                          valueCTr.clearAll();
                        },
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      valueCTr.finishTime != null
                          ? SelectableText(
                              "Finish Time: ${valueCTr.finishTime}  ms",
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
