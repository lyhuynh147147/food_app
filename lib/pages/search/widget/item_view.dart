import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ifood_delivery/controllers/search_product_controller.dart';
import 'package:ifood_delivery/routes/route_helper.dart';
import 'package:ifood_delivery/utils/app_constants.dart';
import 'package:ifood_delivery/utils/colors.dart';
import 'package:ifood_delivery/utils/dimensions.dart';
import 'package:ifood_delivery/widgets/big_text.dart';
import 'package:ifood_delivery/widgets/icon_and_text_widget.dart';
import 'package:ifood_delivery/widgets/text_widget.dart';


class ItemView extends StatelessWidget {
  final bool isRestaurant;
  ItemView({required this.isRestaurant});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<SearchProductController>(builder: (searchController) {
        return SingleChildScrollView(
          child: Center(child: SizedBox(width: Dimensions.WEB_MAX_WIDTH, child: ListView.builder(
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            padding:  EdgeInsets.only(top: Dimensions.padding10),
            itemCount: searchController.searchProductList?.length,
            itemBuilder: (context, index) {

              return GestureDetector(
                  onTap: (){
                    Get.toNamed(RouteHelper.getPopularFood(index, "popular"));
                  },
                  child:  Container(
                    margin:  EdgeInsets.only(left: Dimensions.appMargin, right: Dimensions.appMargin, bottom: 15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          width: Dimensions.listViewImg,
                          height: Dimensions.listViewImg,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(Dimensions.padding20),
                              image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image: NetworkImage(
                                      AppConstants.UPLOADS_URL+searchController.searchProductList![index].img
                                  )
                              )
                          ),
                        ),
                        Expanded(
                          child: Container(
                            padding: Dimensions.isWeb?EdgeInsets.only(left: Dimensions.PADDING_SIZE_SMALL, right: Dimensions.PADDING_SIZE_SMALL):EdgeInsets.all(0),
                            height: Dimensions.listViewCon,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.only(
                                    topRight: Radius.circular(Dimensions.padding20),
                                    bottomRight: Radius.circular(Dimensions.padding20)
                                )
                            ),
                            child:Padding(
                              padding:  EdgeInsets.only(left: Dimensions.padding10, right: Dimensions.padding10),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  BigText(text: searchController.searchProductList![index].name,/* element.value,*/
                                      color: Colors.black87),
                                  SizedBox(height: Dimensions.padding10,),
                                  BigText(text: "Xuất xứ: "+searchController.searchProductList![index].origin.toString(), color: AppColors.textColor,size: 18,),

                                  SizedBox(height: Dimensions.padding10,),
                                  TextWidget(text: searchController.searchProductList![index].description, color: AppColors.textColor),
                                  SizedBox(height: Dimensions.padding10,),
                                  // Row(
                                  //   mainAxisAlignment:MainAxisAlignment.spaceBetween,
                                  //   children: [
                                  //     IconAndTextWidget(text: "Normal", color: AppColors.textColor, icon: Icons.circle, iconColor: AppColors.iconColor1,),
                                  //
                                  //     IconAndTextWidget(text: "17km",color: AppColors.textColor, icon: Icons.location_on, iconColor: AppColors.mainColor,),
                                  //
                                  //     IconAndTextWidget(text: "32min",color:AppColors.textColor, icon: Icons.access_time_rounded, iconColor: AppColors.iconColor2,)
                                  //   ],
                                  // )
                                ],
                              ),
                            ),
                          ),

                        )
                      ],
                    ),
                  )
              );
            },
          ))),
        );
      }),
    );
  }
}