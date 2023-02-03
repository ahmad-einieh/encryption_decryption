import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class GeneralCard extends StatelessWidget {
  const GeneralCard({
    super.key,
    required this.title,
    required this.svgPath,
    required this.color,
    required this.function,
  });

  final String title;
  final String svgPath;
  final Color color;
  final Function()? function;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: function,
      child: Card(
        color: Colors.cyan,
        child: SizedBox(
            width: 332,
            height: 332,
            child: Column(
              children: [
                SvgPicture.asset(
                  svgPath,
                  height: 222,
                  width: 222,
                  colorFilter: ColorFilter.mode(color, BlendMode.srcIn),
                ),
                Text(
                  title,
                  style: TextStyle(color: color, fontSize: 55),
                ),
              ],
            )),
      ),
    );
  }
}
