import 'package:encryption_decryption/views/algorithms%20pages/rsa%20algorithm/rsa_generate_key.dart';
import 'package:encryption_decryption/views/homepage.dart';
import 'package:get/get.dart';
import '../views/algorithms pages/aes algorithm/aes.dart';
import '../views/algorithms pages/rsa algorithm/rsa.dart';

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
  GetPage(name: RouterName.res_generate_key, page: () => RSAGenerateKey())
];

abstract class RouterName {
  static const String homepage = "/homepage";
  static const String rsa = "/rsa";
  static const String aes = "/aes";
  static const String res_generate_key = "/res_generate_key";
}
