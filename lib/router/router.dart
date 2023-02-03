import 'package:encryption_decryption/views/homepage.dart';
import 'package:get/get.dart';
import '../views/algorithms pages/aes.dart';
import '../views/algorithms pages/rsa.dart';

List<GetPage<dynamic>> routerApp = [
  GetPage(
    name: RouterName.homepage,
    page: () => const HomePage(),
    // binding: HomepageBinding(),
  ),
  GetPage(
    name: RouterName.rsa,
    page: () => const RSAscreenPage(),
  ),
  GetPage(
    name: RouterName.aes,
    page: () => const AESscreenPage(),
  ),
];

abstract class RouterName {
  static const String homepage = "/homepage";
  static const String rsa = "/rsa";
  static const String aes = "/aes";
}
