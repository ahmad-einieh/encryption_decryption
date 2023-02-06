import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:encryption_decryption/controllers/rsa_key_ctr.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:share_plus/share_plus.dart';

import '../../../helper/constant.dart';
import '../../../helper/style.dart';
import '../../widgets/homepage_widgets/upper_bar.dart';

class RSAGenerateKey extends StatelessWidget {
  RSAGenerateKey({super.key});
  final List<int> items = [256, 512, 1024, 2048, 4096];
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
              height: MediaQuery.of(context).size.height * 0.1,
            ),
            Column(
              children: [
                const Text(
                  "RSA Generate Key",
                  style: TextStyle(
                      color: Colors.cyan,
                      fontSize: 32,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.2,
                ),
                GetBuilder<RSAKeyCtr>(
                  init: RSAKeyCtr(),
                  builder: (valueCTR) {
                    return Column(
                      children: [
                        DropdownButtonHideUnderline(
                          child: DropdownButton2(
                            isExpanded: true,
                            hint: Row(
                              children: const [
                                Icon(
                                  Icons.list,
                                  size: 16,
                                  color: Colors.white,
                                ),
                                SizedBox(
                                  width: 4,
                                ),
                                Expanded(
                                  child: Text(
                                    'Select type',
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ],
                            ),
                            items: items
                                .map((item) => DropdownMenuItem<int>(
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
                                    ))
                                .toList(),
                            value: valueCTR.selectedValue,
                            onChanged: (value) {
                              valueCTR.changeSelectedValue(value);
                              if (kDebugMode) {
                                print(valueCTR.selectedValue);
                              }
                            },
                            icon: const Icon(
                              Icons.arrow_forward_ios_outlined,
                            ),
                            iconSize: 14,
                            iconEnabledColor: Colors.white,
                            iconDisabledColor: Colors.grey,
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
                            // offset: const Offset(-20, 0),
                          ),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.05,
                        ),
                        SizedBox(
                          width: 246,
                          height: 64,
                          child: ElevatedButton(
                            onPressed: () {
                              valueCTR.generateKey();
                            },
                            style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all<Color>(
                                        Colors.redAccent),
                                shape: MaterialStateProperty.all<
                                        RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ))),
                            child: const Text("Generate Key"),
                          ),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.05,
                        ),
                        valueCTR.publicKey.isEmpty
                            ? const SizedBox()
                            : Column(
                                // mainAxisAlignment:
                                //     MainAxisAlignment.spaceEvenly,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      SizedBox(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.5,
                                        height: 64,
                                        child: TextFormField(
                                          initialValue: valueCTR.publicKey,
                                          readOnly: true,
                                          decoration: InputDecoration(
                                              suffixIconColor: Colors.white,
                                              hintStyle: const TextStyle(
                                                color: Colors.white,
                                              ),
                                              fillColor: Colors.redAccent,
                                              filled: true,
                                              border: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                              ),
                                              focusedBorder: OutlineInputBorder(
                                                borderSide: const BorderSide(
                                                    color: Colors.white,
                                                    width: 1.0),
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                              ),
                                              suffixIcon: Padding(
                                                padding:
                                                    const EdgeInsetsDirectional
                                                        .only(end: 12.0),
                                                child: IconButton(
                                                  icon: const Icon(
                                                    Icons.copy_outlined,
                                                    color: Colors.white,
                                                  ),
                                                  onPressed: () async {
                                                    await Clipboard.setData(
                                                        ClipboardData(
                                                            text: valueCTR
                                                                .publicKey));
                                                    Get.snackbar("copied",
                                                        "public key copied to clipboard");
                                                  },
                                                ),
                                              )),
                                        ),
                                      ),
                                      IconButton(
                                        onPressed: () {
                                          Share.share(valueCTR.publicKey);
                                        },
                                        icon: const Icon(
                                          Icons.share_outlined,
                                          color: Colors.white,
                                        ),
                                      ),
                                      IconButton(
                                        onPressed: () {
                                          saveFile(
                                              valueCTR.publicKey, "publicKey");
                                        },
                                        icon: const Icon(
                                          Icons.save_outlined,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      SizedBox(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.5,
                                        height: 64,
                                        child: TextFormField(
                                          initialValue: valueCTR.privateKey,
                                          readOnly: true,
                                          obscureText: !valueCTR.isOpend,
                                          decoration: InputDecoration(
                                              suffixIconColor: Colors.white,
                                              hintStyle: const TextStyle(
                                                color: Colors.white,
                                              ),
                                              fillColor: Colors.redAccent,
                                              filled: true,
                                              border: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                              ),
                                              focusedBorder: OutlineInputBorder(
                                                borderSide: const BorderSide(
                                                    color: Colors.white,
                                                    width: 1.0),
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                              ),
                                              suffixIcon: Padding(
                                                padding:
                                                    const EdgeInsetsDirectional
                                                        .only(end: 12.0),
                                                child: GestureDetector(
                                                  child: valueCTR.isOpend
                                                      ? const Icon(
                                                          Icons.visibility_off,
                                                        )
                                                      : const Icon(
                                                          Icons.visibility,
                                                        ),
                                                  onTap: () {
                                                    valueCTR.changeOpenEye();
                                                  },
                                                ),
                                              )),
                                        ),
                                      ),
                                      IconButton(
                                        onPressed: () async {
                                          await Clipboard.setData(ClipboardData(
                                              text: valueCTR.privateKey));
                                          Get.snackbar(
                                              "copied", "private key copied");
                                        },
                                        icon: const Icon(
                                          Icons.copy_outlined,
                                          color: Colors.white,
                                        ),
                                      ),
                                      IconButton(
                                        onPressed: () {
                                          saveFile(valueCTR.privateKey,
                                              "privatekey");
                                        },
                                        icon: const Icon(
                                          Icons.save_outlined,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
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
