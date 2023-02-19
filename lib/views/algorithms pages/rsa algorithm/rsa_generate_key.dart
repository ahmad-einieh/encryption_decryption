import 'dart:io';

import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:encryption_decryption/controllers/rsa_key_ctr.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';

import '../../../helper/methods.dart';
import '../../../helper/style.dart';
import '../../widgets/general/general_button.dart';
import '../../widgets/homepage_widgets/upper_bar.dart';

class RSAGenerateKey extends StatelessWidget {
  RSAGenerateKey({super.key});
  final List<int> items = [256, 512, 1024, 2048, 4096];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: mainDecoration,
        child: Column(
          children: [
            const UpperBar(),
            SizedBox(height: MediaQuery.of(context).size.height * 0.1),
            Column(
              children: [
                const Text("RSA Generate Key", style: mainTextStyle),
                SizedBox(height: MediaQuery.of(context).size.height * 0.2),
                GetBuilder<RSAKeyCtr>(
                  init: RSAKeyCtr(),
                  builder: (valueCTR) {
                    return Column(
                      children: [
                        const Text("Select Key Size",
                            style: selectListLabelSytle),
                        SizedBox(
                            height: MediaQuery.of(context).size.height * 0.01),
                        DropdownButtonHideUnderline(
                          child: DropdownButton2(
                            isExpanded: true,
                            items: items
                                .map(
                                  (item) => DropdownMenuItem<int>(
                                    value: item,
                                    child: Text(
                                      "$item",
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
                            value: valueCTR.selectedValue,
                            onChanged: (value) async {
                              await valueCTR.changeSelectedValue(value);
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
                        SizedBox(
                            height: MediaQuery.of(context).size.height * 0.05),
                        GeneralButton(
                          buttonText: "Generate Keys",
                          onPressed: () async {
                            valueCTR.changeIsLoading();
                            await valueCTR.generateKey();
                            String? selectedDirectory =
                                await FilePicker.platform.getDirectoryPath(
                              dialogTitle: "Select Directory To Save File",
                              lockParentWindow: true,
                            );
                            var time =
                                "${DateTime.now()}".replaceAll(':', '--');
                            var deviceInfo = await getDeviceAndUserName();
                            File file = File(
                                '$selectedDirectory/privatekeyRSA ${valueCTR.selectedValue} $deviceInfo $time.pem');
                            await file.writeAsString(valueCTR.privateKey!);

                            File file2 = File(
                                '$selectedDirectory/publicKeyRSA ${valueCTR.selectedValue} $deviceInfo $time.pem');
                            await file2.writeAsString(valueCTR.publicKey!);
                            valueCTR.changeIsLoading();
                          },
                          width: 246,
                        ),
                        SizedBox(
                            height: MediaQuery.of(context).size.height * 0.05),
                        valueCTR.isLoading
                            ? const SpinKitPouringHourGlass(
                                color: Colors.white,
                                size: 66.6,
                              )
                            : const SizedBox(),
                      ],
                    );
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
