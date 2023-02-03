import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import 'router/router.dart';

Future<void> main() async {
  await GetStorage.init();
  await GetStorage.init('general');
  WidgetsFlutterBinding.ensureInitialized();
  doWhenWindowReady(() {
    const initialSize = Size(1100, 666);
    appWindow.minSize = initialSize;
    appWindow.size = initialSize;
    appWindow.title = "encryption_decryption";
    appWindow.alignment = Alignment.center;
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
