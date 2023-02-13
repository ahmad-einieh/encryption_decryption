import 'package:flutter/material.dart';

class GeneralButton extends StatelessWidget {
  GeneralButton(
      {super.key, required this.buttonText, this.onPressed, this.width});
  String buttonText;
  void Function()? onPressed;
  double? width;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: 64,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all<Color>(Colors.redAccent),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        ),
        child: Text(
          buttonText,
          style: const TextStyle(color: Colors.white, fontSize: 25),
        ),
      ),
    );
  }
}
