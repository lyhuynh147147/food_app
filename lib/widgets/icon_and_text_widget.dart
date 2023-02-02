import 'package:flutter/material.dart';
import 'package:ifood_delivery/widgets/small_text.dart';

import '../utils/dimensions.dart';

class IconAndTextWidget extends StatelessWidget {
  final IconData icon;
  final String text;
  final Color color;
  final Color iconColor;

  const IconAndTextWidget({
    Key? key,
    required this.icon,
    required this.text,
    this.color=const Color(0xFF76c5bb),
    this.iconColor= const Color(0xFF93ddd4),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          icon,
          color: iconColor,
          size: Dimensions.iconSize24,
        ),
        SizedBox(width: 5),
        SmallText(text: text),
      ],
    );
  }
}