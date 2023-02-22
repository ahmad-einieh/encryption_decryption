import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:encryption_decryption/controllers/aes_key_ctr.dart';
import 'package:encryption_decryption/helper/constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';

import '../../../helper/methods.dart';
import '../../../helper/style.dart';
import '../../widgets/homepage_widgets/upper_bar.dart';

class AESGenerateKey extends StatelessWidget {
  const AESGenerateKey({super.key});

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
            GetBuilder<AESKeyCtr>(
              init: AESKeyCtr(),
              builder: (valueCTR) {
                return Column(
                  children: [
                    const Text("Select Key Size", style: selectListLabelSytle),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.01),
                    DropdownButtonHideUnderline(
                      child: DropdownButton2(
                        isExpanded: true,
                        items: itemsAES
                            .map(
                              (item) => DropdownMenuItem<int>(
                                value: valuesAES[itemsAES.indexOf(item)],
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
                          valueCTR.changeIsLoading();
                          await valueCTR.generateKey();
                          var deviceInfo = await getDeviceAndUserName();
                          var isSaved = await saveFile(
                              text: valueCTR.privateKey,
                              fileName:
                                  "secure key ${valueCTR.selectedValue} $deviceInfo ${DateTime.now()}.pem"
                                      .replaceAll(':', '--'));
                          isSaved
                              ? Get.snackbar(
                                  "Success", "Key saved successfully",
                                  snackPosition: SnackPosition.BOTTOM,
                                  backgroundColor: Colors.green,
                                  colorText: Colors.white)
                              : Get.snackbar("Error",
                                  "Something went wrong while saving key",
                                  snackPosition: SnackPosition.BOTTOM,
                                  backgroundColor: Colors.red,
                                  colorText: Colors.white);
                          valueCTR.changeIsLoading();
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
                        child: const Text("Generate Key"),
                      ),
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.01),
                    SizedBox(
                      width: 246,
                      height: 64,
                      child: ElevatedButton(
                        onPressed: () async {
                          valueCTR.changeIsLoading();
                          await valueCTR.generateIV();
                          var deviceInfo = await getDeviceAndUserName();
                          var isSaved = await saveFile(
                              text: valueCTR.IVgenerated,
                              fileName: "IV $deviceInfo ${DateTime.now()}.pem"
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
                          valueCTR.changeIsLoading();
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
                    SizedBox(height: MediaQuery.of(context).size.height * 0.05),
                    valueCTR.isLoading
                        ? const SpinKitPouringHourGlass(
                            color: Colors.white,
                            size: 66.6,
                          )
                        : Container(),
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
