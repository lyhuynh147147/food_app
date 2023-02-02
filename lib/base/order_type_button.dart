import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ifood_delivery/utils/dimensions.dart';
import 'package:ifood_delivery/utils/styles.dart';
import '../../controllers/order_controller.dart';


class OrderTypeButton extends StatelessWidget {
  final String value;
  final String title;
  final double amount;
  final bool isFree;

  OrderTypeButton({

    required this.value,
    required this.title,
    required this.amount,
    required this.isFree});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<OrderController>(
      builder: (orderController) {
        return InkWell(
          onTap: () => orderController.setOrderType(value),
          child: Row(
            children: [
              Radio(
                value: value,
                groupValue: orderController.orderType,
                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                onChanged: (String? value) => orderController.setOrderType(value!),
                activeColor: Theme.of(context).primaryColor,
                //onChanged: (String? value) {  },
              ),
              SizedBox(width: Dimensions.PADDING_SIZE_SMALL),

              Text(title, style: robotoRegular),
              SizedBox(width: 5),

              Text(
                '(${(value == 'Take away' || isFree) ? 'Free'.tr : amount != -1 ? '\$${amount/10}': 'calculating'.tr})',
                style: robotoMedium,
              ),

            ],
          ),
        );
      },
    );
  }
}