import 'package:encryption_decryption/views/algorithms%20pages/aes%20algorithm/aes_generate_iv.dart';
import 'package:encryption_decryption/views/algorithms%20pages/rsa%20algorithm/rsa_generate_key.dart';
import 'package:encryption_decryption/views/algorithms%20pages/rsa%20algorithm/rsa_verify.dart';
import 'package:encryption_decryption/views/homepage.dart';
import 'package:get/get.dart';
import '../views/algorithms pages/aes algorithm/aes.dart';
import '../views/algorithms pages/aes algorithm/aes_decrypt.dart';
import '../views/algorithms pages/aes algorithm/aes_encrypt.dart';
import '../views/algorithms pages/aes algorithm/aes_generate_key.dart';
import '../views/algorithms pages/rsa algorithm/rsa.dart';
import '../views/algorithms pages/rsa algorithm/rsa_decrypt.dart';
import '../views/algorithms pages/rsa algorithm/rsa_encrypt.dart';
import '../views/algorithms pages/rsa algorithm/rsa_sign.dart';

List<GetPage<dynamic>> routerApp = [
  GetPage(
    name: RouterName.homepage,
    page: () => const HomePage(),
  ),
  GetPage(
    name: RouterName.rsa,
    page: () => const RSAscreenPage(),
  ),
  GetPage(
    name: RouterName.aes,
    page: () => const AESscreenPage(),
  ),
  GetPage(
    name: RouterName.resGeneratekey,
    page: () => RSAGenerateKey(),
  ),
  GetPage(
    name: RouterName.resEncrypt,
    page: () => const RSAEncrypt(),
  ),
  GetPage(
    name: RouterName.resDecrypt,
    page: () => const RSADecrypt(),
  ),
  GetPage(
    name: RouterName.aesGenerateKey,
    page: () => AESGenerateKey(),
  ),
  GetPage(
    name: RouterName.aesEncrypt,
    page: () => const AESEncrypt(),
  ),
  GetPage(
    name: RouterName.aesDecrypt,
    page: () => const AESDecrypt(),
  ),
  GetPage(
    name: RouterName.sign,
    page: () => const RSASign(),
  ),
  GetPage(
    name: RouterName.verify,
    page: () => const RSAVerify(),
  ),
  GetPage(
    name: RouterName.aesGenerateIV,
    page: () => AESGenerateIV(),
  ),
];

abstract class RouterName {
  static const String homepage = "/homepage";
  static const String rsa = "/rsa";
  static const String aes = "/aes";
  static const String resGeneratekey = "/res_generate_key";
  static const String resEncrypt = "/res_encrypt";
  static const String resDecrypt = "/res_decrypt";
  static const String aesGenerateKey = "/aes_generate_key";
  static const String aesEncrypt = "/aes_encrypt";
  static const String aesDecrypt = "/aes_decrypt";
  static const String sign = "/rsa_sign";
  static const String verify = "/rsa_verify";
  static const String aesGenerateIV = "/aes_generate_iv";
}
