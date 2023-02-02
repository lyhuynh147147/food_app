import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:ifood_delivery/base/custom_app_bar.dart';
import 'package:ifood_delivery/base/no_data_page.dart';
import 'package:ifood_delivery/controllers/auth_controller.dart';
import 'package:ifood_delivery/controllers/cart_controller.dart';
import 'package:ifood_delivery/routes/route_helper.dart';
import 'package:ifood_delivery/utils/app_constants.dart';
import 'package:ifood_delivery/utils/colors.dart';
import 'package:ifood_delivery/utils/dimensions.dart';
import 'package:ifood_delivery/widgets/account_widget.dart';
import 'package:ifood_delivery/widgets/app_icon.dart';
import 'package:ifood_delivery/widgets/big_text.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../controllers/location_controller.dart';
import '../../models/cart_model.dart';
import '../../widgets/small_text.dart';

class CartHistory extends StatelessWidget {
  const CartHistory({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    var getCartHistoryList = Get.find<CartController>()./*getCartHistoryList()*/getCartHistory().reversed.toList();
    Map<String, int> cartItemsPerOrder = {};

    for(int i = 0; i<getCartHistoryList.length; i++){
      if(cartItemsPerOrder.containsKey(getCartHistoryList[i].time)){
        //print("1");
        cartItemsPerOrder.update(getCartHistoryList[i].time!, (value) => ++value);
      }else {
        //print("3");
        cartItemsPerOrder.putIfAbsent(getCartHistoryList[i].time!, () => 1);
      }
    }

    List<int> cartItemsPerOrderToList(){
      return cartItemsPerOrder.entries.map((e) => e.value).toList();
    }

    List<String> cartOrderTimeToList(){
      return cartItemsPerOrder.entries.map((e) => e.key).toList();
    }

    //List<int> orderTimes = cartOrderTimeToList();
    List<int> itemsPerOrder = cartItemsPerOrderToList();

    var listCounter = 0;
    Widget timeWidget(int index) {
      var outputDate = DateTime.now().toString();
      if(index < getCartHistoryList.length){
        DateTime parseDate = DateFormat("yyyy-MM-dd HH:mm:ss").parse(getCartHistoryList[listCounter].time!);
        var inputDate = DateTime.parse(parseDate.toString());
        var outputFormat = DateFormat("MM/dd/yyyy hh:mm a");
        var outputDate = outputFormat.format(inputDate);
        return BigText(text: outputDate,size: 15,);
      }
      return BigText(text: outputDate);

    }
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Lịch sử ',
      ),
      body: Column(
        children: [
          // GestureDetector(
          //   onTap: (){
          //     if(Get.find<AuthController>().userLoggedIn()){
          //       Get.find<AuthController>().clearSharedData();
          //       Get.find<CartController>().clear();
          //       Get.find<CartController>()./*clearCartHistory()*/clearCartList();
          //       Get.find<LocationController>().clearAddressList();
          //       Get.offNamed(RouteHelper.getSignInPage());
          //     }else {
          //       print("You looged out");
          //       Get.offNamed(RouteHelper.getSignInPage());
          //     }
          //   },
          //   child: AccountWidget(
          //     appIcon:AppIcon(
          //       icon: Icons.logout,
          //       backgroundColor: Colors.redAccent,
          //       iconColor: Colors.white,
          //       iconSize: Dimensions.height10*5/2,
          //       size: Dimensions.height10*4,
          //     ),
          //     bigText: BigText(text: "Logout",),
          //   ),
          // ),
          GetBuilder<CartController>(builder: (_cartController) {
            return _cartController./*getCartHistoryList()*/getCartHistory().length > 0
                ? Expanded(child: Container(
                margin: EdgeInsets.only(
                  top: Dimensions.height20,
                  left: Dimensions.width20,
                  right: Dimensions.width20,
                ),
                child: ListView(
                  children: [
                    for(int i = 0; i < itemsPerOrder.length; i++)
                      Container(
                        height: Dimensions.height30*4,
                        margin: EdgeInsets.only(bottom: Dimensions.height20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            timeWidget(listCounter),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Wrap(
                                  direction: Axis.horizontal,
                                  children: List.generate(itemsPerOrder[i], (index) {
                                    if(listCounter<getCartHistoryList.length){
                                      listCounter++;
                                    }
                                    return index <= 2? SingleChildScrollView(
                                      child: Container(
                                        margin: const EdgeInsets.only(
                                            right: 10, bottom: 20, top: 5),
                                        height: Dimensions.height10*7,
                                        width: Dimensions.height10*7,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius
                                              .circular(8),
                                          image: DecorationImage(
                                            fit: BoxFit.cover,
                                            image: NetworkImage(
                                              AppConstants.BASE_URL+AppConstants.UPLOAD_URL+getCartHistoryList[listCounter-1].img!,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ): SingleChildScrollView(child: Container());
                                  }),
                                ),
                                Container(
                                  height:  Dimensions.height20*4,
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    children: [
                                      SmallText(text:"Tổng",color: AppColors.titleColor,),
                                      BigText(text: itemsPerOrder[i].toString()+" Mặt hàng",color: AppColors.titleColor,),
                                      GestureDetector(
                                        onTap: (){
                                          var orderTime = cartOrderTimeToList();
                                          Map<int,CartModel> moreOrder = {};
                                          for(int j = 0; j<getCartHistoryList.length; j++){
                                            if(getCartHistoryList[j].time == orderTime[i]) {
                                              moreOrder.putIfAbsent(getCartHistoryList[j].id!, () =>
                                                  CartModel.fromJson(jsonDecode(jsonEncode(getCartHistoryList[j]))));
                                            }
                                          }
                                          Get.find<CartController>().setItems = moreOrder;
                                          Get.find<CartController>().addToCartList();
                                          Get.toNamed(RouteHelper.getCartPage(0, "cart-history"));

                                        },
                                        child: Container(
                                          margin: EdgeInsets.symmetric(
                                            horizontal: Dimensions.width10,
                                            vertical: Dimensions.height10/2,
                                          ),
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(Dimensions.radius15/3),
                                            border: Border.all(width: 1,color: AppColors.mainColor),
                                          ),
                                          child: SmallText(text: "Một lần nữa",color: AppColors.mainColor,),
                                        ),
                                      )
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                  ],
                ),
              ),)
                : Container(
              height: MediaQuery.of(context).size.height/1.5,
              child: const Center(
                child: NoDataPage(
                text: "You didn't buy anything so far !",
                imgPath: "assets/image/empty_box.png",
                ),
              ),
            );
          }),

        ],
      ),
    );
  }
}
/**/
