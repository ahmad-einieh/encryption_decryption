import 'package:encrypt/encrypt.dart';

final List<AESMode> modes = [
  AESMode.cbc,
  AESMode.cfb64,
  AESMode.ctr,
  AESMode.ecb,
  AESMode.ofb64Gctr,
  AESMode.ofb64,
  AESMode.sic,
];

final List<String> modesString = [
  "CBC",
  "CFB64",
  "CTR",
  "ECB",
  "OFB64GCTR",
  "OFB64",
  "SIC",
];

final List<int> items = [256, 512, 1024, 2048, 4096];

final List<int> itemsAES = [128, 192, 256];
final List valuesAES = [16, 24, 32];
