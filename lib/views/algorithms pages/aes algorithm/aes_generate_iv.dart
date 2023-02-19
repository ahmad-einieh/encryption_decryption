// under build
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:encryption_decryption/controllers/aes_iv_ctr.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../helper/methods.dart';
import '../../../helper/style.dart';
import '../../widgets/homepage_widgets/upper_bar.dart';

class AESGenerateIV extends StatelessWidget {
  AESGenerateIV({super.key});

  final List<int> items = [128, 192, 256];
  final List values = [16, 24, 32];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: mainDecoration,
        child: Column(
          children: [
            const UpperBar(),
            SizedBox(height: MediaQuery.of(context).size.height * 0.1),
            const Text("AES Generate Key Page", style: mainTextStyle),
            SizedBox(height: MediaQuery.of(context).size.height * 0.1),
            GetBuilder<AESIVCtr>(
              init: AESIVCtr(),
              builder: (valueCTR) {
                return Column(
                  children: [
                    const Text("Select Initialization vector Size",
                        style: selectListLabelSytle),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.01),
                    DropdownButtonHideUnderline(
                      child: DropdownButton2(
                        isExpanded: true,
                        items: items
                            .map(
                              (item) => DropdownMenuItem<int>(
                                value: values[items.indexOf(item)],
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
                        itemPadding: const EdgeInsets.only(left: 14, right: 14),
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
                    SizedBox(height: MediaQuery.of(context).size.height * 0.05),
                    SizedBox(
                      width: 246,
                      height: 64,
                      child: ElevatedButton(
                        onPressed: () async {
                          await valueCTR.generateIV();
                          var isSaved = await saveFile(
                              text: valueCTR.IVgenerated,
                              fileName:
                                  "Initialization vector AES ${DateTime.now()}.pem"
                                      .replaceAll(':', '--'));
                          isSaved
                              ? Get.snackbar("Success",
                                  "Initialization Vector saved successfully",
                                  snackPosition: SnackPosition.BOTTOM,
                                  backgroundColor: Colors.green,
                                  colorText: Colors.white)
                              : Get.snackbar("Error",
                                  "Something went wrong while saving Initialization Vector",
                                  snackPosition: SnackPosition.BOTTOM,
                                  backgroundColor: Colors.red,
                                  colorText: Colors.white);
                        },
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(
                              Colors.redAccent),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                        ),
                        child: const Text("Generate Initialization Vector"),
                      ),
                    ),
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}