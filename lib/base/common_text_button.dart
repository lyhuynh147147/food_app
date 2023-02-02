import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:ifood_delivery/utils/colors.dart';
import 'package:ifood_delivery/utils/dimensions.dart';
import 'package:ifood_delivery/widgets/big_text.dart';

class CommonTextButton extends StatelessWidget {
  final String text;
  const CommonTextButton({Key? key, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(

      child: Center(
        child: BigText(
          size: 20,
          text: text.tr,
          color: Colors.white,
        ),
      ),
      padding:  EdgeInsets.all(Dimensions.padding20),
      decoration: BoxDecoration(
          color: AppColors.mainColor,
          borderRadius: BorderRadius.circular(Dimensions.padding20),
          boxShadow: [
            BoxShadow(
                offset: Offset(0, 5),
                blurRadius: 10,
                //spreadRadius: 3,
                color: AppColors.mainColor.withOpacity(0.3))
          ]),
    );
  }
}