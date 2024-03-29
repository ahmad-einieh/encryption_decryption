import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'router/router.dart';
// import 'package:dcdg/dcdg.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  doWhenWindowReady(() {
    const initialSize = Size(1100, 700);
    appWindow.minSize = initialSize;
    appWindow.title = "encryption_decryption";
    appWindow.alignment = Alignment.center;
    appWindow.maximize();
    appWindow.show();
  });
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Material App',
      initialRoute: RouterName.homepage,
      getPages: routerApp,
    );
  }
}
