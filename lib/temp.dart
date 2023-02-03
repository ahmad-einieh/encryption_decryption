import 'package:fast_rsa/fast_rsa.dart';

Future<void> main(List<String> args) async {
  var result = await RSA.generate(2048);
  print(result.privateKey);
  print(result.publicKey);
}
