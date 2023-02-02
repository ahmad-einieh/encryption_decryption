import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'router/router.dart';
import 'views/homepage.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
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
