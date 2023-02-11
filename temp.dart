import 'package:encrypt/encrypt.dart';

void main(List<String> args) {
  final plainText = 'Lorem ipsum dolor sit amet, consectetur adipiscing elit';
  final key = Key.fromSecureRandom(16);
  // final iv = IV.fromLength(16);

  final encrypter = Encrypter(AES(key, mode: AESMode.ctr));

  final encrypted = encrypter.encrypt(plainText);
  final decrypted = encrypter.decrypt(encrypted);

  print(decrypted); // Lorem ipsum dolor sit amet, consectetur adipiscing elit
  print(encrypted.base64); // R4PxiU3h8Yo
}
