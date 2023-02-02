import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ifood_delivery/base/custom_button.dart';
import 'package:ifood_delivery/pages/payment/payment_failed_dialogue.dart';
import 'package:ifood_delivery/routes/route_helper.dart';
import 'package:ifood_delivery/utils/colors.dart';
import 'package:ifood_delivery/utils/styles.dart';

import '../../utils/dimensions.dart';

class OrderSuccessPage extends StatelessWidget {
  final String orderID;
  final int status;
  OrderSuccessPage({required this.orderID, required this.status});

  @override
  Widget build(BuildContext context) {
    if(status == 0) {
      Future.delayed(Duration(seconds: 1), () {
        Get.dialog(PaymentFailedDialog(orderID: orderID), barrierDismissible: false);
      });
    }
    return Scaffold(

      body: Center(child: SizedBox(width: Dimensions.WEB_MAX_WIDTH, child:
      Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        Icon(

          status==1? Icons.check_circle_outline:Icons.warning_amber_outlined,
          size:100.0,
          color: AppColors.mainColor,
        ),

        SizedBox(height: Dimensions.PADDING_SIZE_LARGE),

        Text(
          status == 1 ? 'Bạn đã đặt hàng thành công' : 'Đặt hàng của bạn không thành công',
          style: robotoMedium.copyWith(fontSize: Dimensions.fontSizeLarge),
        ),
        SizedBox(height: Dimensions.PADDING_SIZE_SMALL),

        Padding(
          padding: EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_LARGE,
              vertical: Dimensions.PADDING_SIZE_SMALL),
          child: Text(
            status == 1 ? 'Đặt hàng thành công' : 'Đặt hàng không thành công',
            style: robotoMedium.copyWith(fontSize: Dimensions.fontSizeSmall,
                color: Theme.of(context).disabledColor),
            textAlign: TextAlign.center,
          ),
        ),
        SizedBox(height: 30),

        Padding(
          padding: EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
          child: CustomButton(buttonText: 'Trở về'.tr, onPressed:
              () => Get.offAllNamed(RouteHelper.getInitial())),
        ),
      ]))),
    );
  }
}