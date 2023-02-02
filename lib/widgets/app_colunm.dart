import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ifood_delivery/utils/colors.dart';
import 'package:ifood_delivery/utils/dimensions.dart';
import 'package:ifood_delivery/widgets/big_text.dart';
import 'package:ifood_delivery/widgets/icon_and_text_widget.dart';
import 'package:ifood_delivery/widgets/small_text.dart';

class AppColunm extends StatelessWidget {
  final String text;
  final double? price;
  final int? stars;
  double size;
  AppColunm({
    Key? key,
    required this.text,
    this.price,
    required this.size,
    this.stars ,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        BigText(
          text: text,
          size: size,
        ),
        SizedBox(height: Dimensions.height10,),
        Row(
          children: [
            Wrap(
                children: List.generate(stars!, (index)  {
                  return Icon( Icons.star,
                    color: AppColors.mainColor,
                    size: 15,
                  );
                })
            ),
            SizedBox(width: 10,),
            SmallText(text: stars.toString()),
            SizedBox(width: 10,),
            SmallText(text: "1287"),
            SizedBox(width: 10,),
            SmallText(text: "review".tr),
          ],
        ),
        SizedBox(height: Dimensions.height20,),
        BigText(
          text: "\$ ${price!.toStringAsFixed(0)} VNĐ",
          size: Dimensions.font26,
        )
        // Row(
        //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //   children: [
        //     IconAndTextWidget(
        //       icon: Icons.crib_sharp,
        //       text: "Normal",
        //       iconColor: AppColors.iconColor1,
        //     ),
        //     IconAndTextWidget(
        //       icon: Icons.location_on,
        //       text: "1.7km",
        //       iconColor: AppColors.iconColor1,
        //     ),
        //     IconAndTextWidget(
        //       icon: Icons.access_time_rounded,
        //       text: "32min",
        //       iconColor: AppColors.iconColor1,
        //     )
        //   ],
        // )
      ],
    );
  }
}
// SizedBox(height: Dimensions.height20,),
// BigText(
// text: "origin".tr + origin!,
// size: Dimensions.font26,
// ),