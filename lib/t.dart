import 'package:encrypt/encrypt.dart';

Future<void> main(List<String> args) async {
  final plainText = 'Lorem ipsum dolor sit amet, consectetur adipiscing elit';
  final Key key = Key.fromSecureRandom(24); // 16 , 24 , 32
  final IV iv = IV.fromSecureRandom(16);
  print(iv.base16);
  // print(key);
  // var x = Key.fromBase64('fPHApSMEDdx/CW2ATQfL81oZf0UHPYEf');
  // print(x);

  final encrypter = Encrypter(AES(key, mode: AESMode.ecb));

  final Encrypted encrypted = encrypter.encrypt(plainText, iv: iv);
  String sse = encrypted.base16;
  print(sse);

  // // // print(encrypted);
  // final String decrypted = encrypter.decrypt(encrypted, iv: iv);
  // print(decrypted);

  // print(decrypted); // Lorem ipsum dolor sit amet, consectetur adipiscing elit
  // print(encrypted
  //     .base64); // R4PxiU3h8YoIRqVowBXm36ZcCeNeZ4s1OvVBTfFlZRdmohQqOpPQqD1YecJeZMAop/hZ4OxqgC1WtwvX/hP9mw==
}
