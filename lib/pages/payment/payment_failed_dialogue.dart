
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ifood_delivery/base/custom_button.dart';
import 'package:ifood_delivery/controllers/order_controller.dart';
import 'package:ifood_delivery/routes/route_helper.dart';
import 'package:ifood_delivery/utils/dimensions.dart';
import 'package:ifood_delivery/utils/styles.dart';
class PaymentFailedDialog extends StatelessWidget {
  final String orderID;
  PaymentFailedDialog({required this.orderID});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(Dimensions.RADIUS_SMALL)),
      insetPadding: EdgeInsets.all(30),
      clipBehavior: Clip.antiAliasWithSaveLayer,
      child: SizedBox(width: 500, child: Padding(
        padding: EdgeInsets.all(Dimensions.PADDING_SIZE_LARGE),
        child: Column(mainAxisSize: MainAxisSize.min, children: [

          Padding(
            padding: EdgeInsets.all(Dimensions.PADDING_SIZE_LARGE),
            child: Image.asset("assets/image/warning.png", width: 70, height: 70),
          ),

          Padding(
            padding: EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_LARGE),
            child: Text(
              'bạn có đồng ý với đơn hàng này không'.tr, textAlign: TextAlign.center,
              style: robotoMedium.copyWith(fontSize: Dimensions.fontSizeExtraLarge, color: Colors.red),
            ),
          ),

          Padding(
            padding: EdgeInsets.all(Dimensions.PADDING_SIZE_LARGE),
            child: Text(
              'nếu bạn không trả tiền'.tr,
              style: robotoMedium.copyWith(fontSize: Dimensions.fontSizeLarge), textAlign: TextAlign.center,
            ),
          ),
          SizedBox(height: Dimensions.PADDING_SIZE_LARGE),

          GetBuilder<OrderController>(builder: (orderController) {
            return !orderController.isLoading ? Column(children: [
              CustomButton(
                buttonText: 'chuyển sang tiền mặt khi giao hàng'.tr,
                //onPressed: () => orderController.switchToCOD(orderID),
                radius: Dimensions.RADIUS_SMALL, height: 40,
              ),
              SizedBox(width: Dimensions.PADDING_SIZE_LARGE),
              TextButton(
                onPressed: () {
                  Get.offAllNamed(RouteHelper.getInitial());
                },
                style: TextButton.styleFrom(
                  backgroundColor: Theme.of(context).disabledColor.withOpacity(0.3), minimumSize: Size(Dimensions.WEB_MAX_WIDTH, 40), padding: EdgeInsets.zero,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(Dimensions.RADIUS_SMALL)),
                ),
                child: Text('tiếp tục với đơn đặt hàng thất bại'.tr, textAlign: TextAlign.center, style: robotoBold.copyWith(color: Theme.of(context).textTheme.bodyText1?.color)),
              ),
            ]) : Center(child: CircularProgressIndicator());
          }),

        ]),
      )),
    );
  }
}