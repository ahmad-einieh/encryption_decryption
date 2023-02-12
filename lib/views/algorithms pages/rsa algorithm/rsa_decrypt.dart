import 'package:auto_size_widget/auto_size_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controllers/rsa_decrypt_ctr.dart';
import '../../../helper/constant.dart';
import '../../../helper/style.dart';
import '../../widgets/homepage_widgets/upper_bar.dart';

class RSADecrypt extends StatelessWidget {
  RSADecrypt({super.key});
  var plainTextController = TextEditingController();
  var publicKeyController = TextEditingController();

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
            const Text(
              "RSA Decrypt Page",
              style: TextStyle(
                  color: Colors.cyan,
                  fontSize: 32,
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.1,
            ),
            SingleChildScrollView(
              child: GetBuilder<AESDecryptctr>(
                init: AESDecryptctr(),
                builder: (valueCTr) {
                  return Column(
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.5,
                        height: 64,
                        child: TextFormField(
                          controller: plainTextController,
                          readOnly: valueCTr.isGetPrivateFromFile,
                          decoration: InputDecoration(
                              hintText: "Text to decrypt",
                              suffixIconColor: Colors.white,
                              hintStyle: const TextStyle(
                                color: Colors.white,
                              ),
                              fillColor: Colors.redAccent,
                              filled: true,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                    color: Colors.white, width: 1.0),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              suffixIcon: Padding(
                                padding:
                                    const EdgeInsetsDirectional.only(end: 12.0),
                                child: IconButton(
                                  icon: const Icon(
                                    Icons.file_open_outlined,
                                    color: Colors.white,
                                  ),
                                  onPressed: () async {
                                    var x = await selectFile();
                                    // String privateKey = await x!.readAsString();
                                    String? privateKey;
                                    if (x.isEmpty) {
                                      Get.snackbar("Error", "No file selected",
                                          snackPosition: SnackPosition.BOTTOM,
                                          backgroundColor: Colors.red,
                                          colorText: Colors.white);
                                      return;
                                    }
                                    if (x[1] == 'pdf') {
                                      privateKey = readPDFile(x[0]);
                                    } else {
                                      privateKey = await x[0].readAsString();
                                    }
                                    // valueCTr.changePlainText(text);
                                    valueCTr.changeCyperText(privateKey);
                                  },
                                ),
                              )),
                        ),
                      ),
                      valueCTr.isGetTextFromFile
                          ? const Text(
                              "text from file",
                              style: TextStyle(color: Colors.white),
                            )
                          : const SizedBox(),
                      const SizedBox(
                        height: 8,
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.5,
                        height: 64,
                        child: TextFormField(
                          controller: publicKeyController,
                          readOnly: valueCTr.isGetPrivateFromFile,
                          decoration: InputDecoration(
                              hintText: "Private Key",
                              suffixIconColor: Colors.white,
                              hintStyle: const TextStyle(
                                color: Colors.white,
                              ),
                              fillColor: Colors.redAccent,
                              filled: true,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                    color: Colors.white, width: 1.0),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              suffixIcon: Padding(
                                padding:
                                    const EdgeInsetsDirectional.only(end: 12.0),
                                child: IconButton(
                                  icon: const Icon(
                                    Icons.file_open_outlined,
                                    color: Colors.white,
                                  ),
                                  onPressed: () async {
                                    var x = await selectFile();
                                    // String publicKey = await x!.readAsString();
                                    String? publicKey;
                                    if (x.isEmpty) {
                                      Get.snackbar("Error", "No file selected",
                                          snackPosition: SnackPosition.BOTTOM,
                                          backgroundColor: Colors.red,
                                          colorText: Colors.white);
                                      return;
                                    }
                                    if (x[1] == 'pdf') {
                                      publicKey = readPDFile(x[0]);
                                    } else {
                                      publicKey = await x[0].readAsString();
                                    }
                                    // valueCTr.changePlainText(text);
                                    valueCTr.changePrivateKey(publicKey);
                                  },
                                ),
                              )),
                        ),
                      ),
                      valueCTr.isGetPrivateFromFile
                          ? const Text(
                              "Public Key from file",
                              style: TextStyle(color: Colors.white),
                            )
                          : const SizedBox(),
                      const SizedBox(
                        height: 8,
                      ),
                      SizedBox(
                        width: 246,
                        height: 64,
                        child: ElevatedButton(
                          onPressed: () async {
                            if (valueCTr.isGetTextFromFile == false) {
                              valueCTr.changeCyperText(plainTextController.text,
                                  isFromButton: false);
                            }
                            if (valueCTr.isGetPrivateFromFile == false) {
                              valueCTr.changePrivateKey(
                                  publicKeyController.text,
                                  isFromFile: false);
                            }
                            if (valueCTr.cyperText != null &&
                                valueCTr.privateKey != null &&
                                (valueCTr.cyperText!.isEmpty ||
                                    valueCTr.privateKey!.isEmpty)) {
                              Get.snackbar("Error", "Please fill all fields",
                                  snackPosition: SnackPosition.BOTTOM,
                                  backgroundColor: Colors.red,
                                  colorText: Colors.white,
                                  // padding: const EdgeInsets.only(bottom: 10),
                                  margin: const EdgeInsets.only(
                                      bottom: 16, right: 16, left: 16),
                                  duration: const Duration(seconds: 5));
                              return;
                            }
                            if (valueCTr.cyperText != null &&
                                valueCTr.privateKey != null) {
                              var x = await valueCTr.decrypt(
                                  valueCTr.cyperText!, valueCTr.privateKey!);
                              if (x) {
                                String fileName =
                                    "decrpted ${DateTime.now()}.txt"
                                        .replaceAll(':', '.');
                                var isSaved =
                                    await saveFile(valueCTr.plain, fileName);
                                if (isSaved) {
                                  Get.snackbar(
                                      "Success", "File saved as $fileName",
                                      snackPosition: SnackPosition.BOTTOM,
                                      backgroundColor: Colors.green,
                                      colorText: Colors.white,
                                      // padding: const EdgeInsets.only(bottom: 10),
                                      margin: const EdgeInsets.only(
                                          bottom: 16, right: 16, left: 16),
                                      duration: const Duration(seconds: 5));
                                  valueCTr.clearAll();
                                } else {
                                  valueCTr.changeIsShowText();
                                  valueCTr.clearAll(isClearText: false);
                                }
                              }
                            }
                            plainTextController.clear();
                            publicKeyController.clear();
                          },
                          style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all<Color>(
                                  Colors.redAccent),
                              shape: MaterialStateProperty.all<
                                      RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ))),
                          child: const Text("Decrypt"),
                        ),
                      ),
                      valueCTr.isShowText
                          ? Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                const SizedBox(
                                  height: 16,
                                ),
                                AutoSizeWidget(
                                    initialWidth:
                                        MediaQuery.of(context).size.width * 0.8,
                                    initialHeight: 222,
                                    maxWidth:
                                        MediaQuery.of(context).size.width * 0.8,
                                    showIcon: false,
                                    maxHeight: 222,
                                    boxDecoration: BoxDecoration(
                                      border: Border.all(
                                          width: 1, color: Colors.grey),
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                    child:
                                        SelectableText(valueCTr.plain ?? "")),
                              ],
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
