import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:syncfusion_flutter_pdf/pdf.dart';

import '../helper/style.dart';
import 'widgets/homepage_widgets/home_page_content.dart';
import 'widgets/homepage_widgets/upper_bar.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.red,
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
              height: MediaQuery.of(context).size.height * 0.22,
            ),
            const HomePageContent(),
//             ElevatedButton(
//                 onPressed: () async {
//                   FilePickerResult? result =
//                       await FilePicker.platform.pickFiles();
//                   //Load an existing PDF document.
//                   final PdfDocument document = PdfDocument(
//                       inputBytes:
//                           File(result!.files.single.path!).readAsBytesSync());
// //Extract the text from all the pages.
//                   String text = PdfTextExtractor(document).extractText();
// //Dispose the document.
//                   print(text);
//                   document.dispose();
//                 },
//                 child: Text("Read File")),
          ],
        ),
      ),
    );
  }
}
