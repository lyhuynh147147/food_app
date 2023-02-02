
import 'package:flutter/material.dart';
import 'package:ifood_delivery/controllers/cart_controller.dart';
import 'package:ifood_delivery/controllers/popular_product_controller.dart';
import 'package:ifood_delivery/pages/cart/cart_page.dart';
import 'package:ifood_delivery/pages/home/main_food_page.dart';
import 'package:ifood_delivery/routes/route_helper.dart';
import 'package:ifood_delivery/utils/app_constants.dart';
import 'package:ifood_delivery/utils/colors.dart';
import 'package:ifood_delivery/utils/dimensions.dart';
import 'package:ifood_delivery/widgets/app_colunm.dart';
import 'package:ifood_delivery/widgets/app_colunms.dart';
import 'package:ifood_delivery/widgets/app_icon.dart';
import 'package:ifood_delivery/widgets/big_text.dart';
import 'package:ifood_delivery/widgets/expandable_text_widget.dart';
import 'package:ifood_delivery/widgets/icon_and_text_widget.dart';
import 'package:ifood_delivery/widgets/small_text.dart';
import 'package:get/get.dart';

class PopularFoodDetail extends StatelessWidget {
  int pageId;
  String page;
  PopularFoodDetail({
    Key? key,
    required this.pageId,
    required this.page
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var product = Get.find<PopularProductController>().popularProductList[pageId];
    // print("Page is id"+pageId.toString());
    // print("Page name is"+product.name.toString());

    Get.find<PopularProductController>().initProduct(product,pageId, Get.find<CartController>());

    return Scaffold(
      body: Stack(
        children: [
          //backgroud image
          Positioned(
            left: 0,
            right: 0,
            child: Container(
              width: double.maxFinite,
              height: Dimensions.popularFoodImgSize,
              decoration: BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: NetworkImage(
                    AppConstants.BASE_URL+AppConstants.UPLOAD_URL+product.img!
                  ),
                ),
              ),
            ),
          ),
          //icon widgets
          Positioned(
            top: Dimensions.height45,
            left: Dimensions.width20,
            right: Dimensions.width20,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: (){
                    if(page=='cartpage'){
                      Get.toNamed(RouteHelper.getCartPage(pageId, page));
                    } else {
                      Get.toNamed(RouteHelper.getInitial());
                    }
                  },
                  child: AppIcon(icon: Icons.arrow_back_ios,backgroundColor: Colors.black.withOpacity(0.2),)),
                GetBuilder<PopularProductController>(builder:(controller) {
                  return GestureDetector(
                    onTap: (){
                      if(controller.totalItems>=1)
                        Get.toNamed(RouteHelper.getCartPage(pageId, page));
                    },
                    child: Stack(
                      children: [
                        AppIcon(icon: Icons.shopping_cart_outlined,backgroundColor: Colors.black.withOpacity(0.2),),
                        controller.totalItems>=1?
                        Positioned(
                          right: 0,
                          top: 0,
                          child: AppIcon(
                            icon: Icons.circle,
                            size: 20,
                            iconColor: Colors.transparent,
                            backgroundColor: AppColors.mainColor,
                          ),
                        )
                            : Container(),
                        Get.find<PopularProductController>().totalItems>=1?
                        Positioned(
                          right: 6,
                          top: 3,
                          child: BigText(text: Get.find<PopularProductController>().totalItems.toString(),
                            size: 12,
                            color: Colors.white,
                          ),
                        )
                            :Container(),

                      ],
                    ),
                  );
                })

              ],
            ),
          ),
          //introduction of food
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            top: Dimensions.popularFoodImgSize-20,
            child: Container(
              padding: EdgeInsets.only(
                left: Dimensions.width20,
                right: Dimensions.width20,
                top: Dimensions.width20,
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(Dimensions.radius20),
                  topLeft: Radius.circular(Dimensions.radius20),
                ),
                color: Colors.white
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppColunms(text: product.name!,
                    price: product.price,
                    stars: product.stars,
                    origin: product.origin!,
                    quantity: product.quantity,
                    size: Dimensions.font26,
                  ),
                  SizedBox(height: Dimensions.height20,),
                  // BigText(text: "Mô tả chi tiết"),
                  // SizedBox(height: Dimensions.height20,),
                  Expanded(
                    child: SingleChildScrollView(
                      child: ExpandableTextWidget(text: product.description!,),
                    ),
                  ),
                ],
              ),
            ),
          ),
          //
        ],
      ),
      bottomNavigationBar: GetBuilder<PopularProductController>(
        builder: (popularProduct){
          return Container(
            height: Dimensions.bottomHeightBar * 0.78,
            width: double.maxFinite,
            padding: EdgeInsets.only(
              top: Dimensions.height20,
              bottom: Dimensions.height20,
              left: Dimensions.height20,
              right: Dimensions.height20,
            ),
            decoration: BoxDecoration(
              color: AppColors.buttonBackgroundColor,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(Dimensions.radius20*2),
                  topRight: Radius.circular(Dimensions.radius20*2)
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: EdgeInsets.only(
                    top: Dimensions.height15,
                    bottom: Dimensions.height15,
                    left: Dimensions.width20,
                    right: Dimensions.width20,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(Dimensions.radius20),
                    color: Colors.white,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        child: Icon(
                          Icons.remove,
                          color: AppColors.signColor,
                        ),
                        onTap: (){
                          popularProduct.setQuantity(false,product);
                        },
                      ),
                      SizedBox(width: Dimensions.width10,),
                      BigText(text: popularProduct.inCartItem.toString()),
                      SizedBox(width: Dimensions.width10,),
                      GestureDetector(
                        child: Icon(
                          Icons.add,
                          color: AppColors.signColor,
                        ),
                        onTap: (){
                          popularProduct.setQuantity(true,product);
                        },
                      ),
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: (){
                    popularProduct.addItem(product);
                  },
                  child: Container(
                    //height: Dimensions.bottomHeightBar,
                    padding: EdgeInsets.only(
                      top: Dimensions.height15,
                      bottom: Dimensions.height15,
                      left: Dimensions.width20,
                      right: Dimensions.width20,
                    ),
                    child: BigText(
                      text: "| Thêm vào giỏ",
                      color: Colors.white,
                    ),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(Dimensions.radius20),
                        color: AppColors.mainColor
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
