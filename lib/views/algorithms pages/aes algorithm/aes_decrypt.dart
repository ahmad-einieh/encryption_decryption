import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:encrypt/encrypt.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';

import '../../../controllers/aes_decrypt_ctr.dart';
import '../../../helper/constant.dart';
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
            SizedBox(height: MediaQuery.of(context).size.height * 0.09),
            const Text("AES Decrypt Page", style: mainTextStyle),
            SizedBox(height: MediaQuery.of(context).size.height * 0.08),
            SingleChildScrollView(
              child: GetBuilder<AESDecryptctr>(
                init: AESDecryptctr(),
                builder: (valueCTr) {
                  return Column(
                    children: [
                      GeneralButton(
                        buttonText: "Select Secure Key",
                        width: 444,
                        onPressed: () async =>
                            await valueCTr.changePrivateKey(),
                      ),
                      const SizedBox(height: 20),
                      GeneralButton(
                        buttonText: "Select Initialization Vector (optional)",
                        width: 444,
                        onPressed: () async => await valueCTr.changeIV(),
                      ),
                      const SizedBox(height: 20),
                      GeneralButton(
                        buttonText: "Select File to Decrypt",
                        width: 444,
                        onPressed: () async =>
                            await valueCTr.selectFileToDecrypt(),
                      ),
                      const SizedBox(height: 20),
                      const Text("Select mode", style: selectListLabelSytle),
                      SizedBox(
                          height: MediaQuery.of(context).size.height * 0.01),
                      DropdownButtonHideUnderline(
                        child: DropdownButton2(
                          isExpanded: true,
                          items: modesString
                              .map(
                                (item) => DropdownMenuItem<AESMode>(
                                  value: modes[modesString.indexOf(item)],
                                  child: Text(
                                    item,
                                    style: const TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              )
                              .toList(),
                          value: valueCTr.mode,
                          onChanged: (value) async {
                            await valueCTr.changeMode(value!);
                          },
                          icon: const Icon(
                            Icons.arrow_forward_ios_outlined,
                          ),
                          iconSize: 14,
                          iconEnabledColor: Colors.white,
                          buttonHeight: 64,
                          buttonWidth: 246,
                          buttonPadding:
                              const EdgeInsets.only(left: 14, right: 14),
                          buttonDecoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(14),
                            border: Border.all(
                              color: Colors.black26,
                            ),
                            color: Colors.redAccent,
                          ),
                          buttonElevation: 2,
                          itemHeight: 40,
                          itemPadding:
                              const EdgeInsets.only(left: 14, right: 14),
                          dropdownMaxHeight: 200,
                          dropdownWidth: 246,
                          dropdownDecoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(14),
                            color: Colors.redAccent,
                          ),
                          dropdownElevation: 8,
                          scrollbarRadius: const Radius.circular(40),
                          scrollbarThickness: 6,
                          scrollbarAlwaysShow: true,
                        ),
                      ),
                      const SizedBox(height: 20),
                      GeneralButton(
                        buttonText: "Decrypt",
                        width: 246,
                        onPressed: () async {
                          valueCTr.changeIsLoading();
                          await valueCTr.decryetBytesAES(
                              valueCTr.fileAndExtention!.file!,
                              valueCTr.privateKey!,
                              valueCTr.iv);
                          var deviceInfo = await getDeviceAndUserName();
                          await saveFile(
                              bytes: valueCTr.plain,
                              fileName:
                                  "dectyptedAES $deviceInfo ${DateTime.now()}.${valueCTr.fileAndExtention!.extension}"
                                      .replaceAll(':', '--'));
                          valueCTr.clearAll();
                          valueCTr.changeIsLoading();
                        },
                      ),
                      const SizedBox(height: 15),
                      valueCTr.finishTime != null
                          ? SelectableText(
                              "Finish Time: ${valueCTr.finishTime}  ms",
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
