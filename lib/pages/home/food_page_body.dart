
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:ifood_delivery/controllers/popular_product_controller.dart';
import 'package:ifood_delivery/controllers/wine_product_controller.dart';
import 'package:ifood_delivery/routes/route_helper.dart';
import 'package:ifood_delivery/utils/app_constants.dart';
import 'package:ifood_delivery/utils/colors.dart';
import 'package:ifood_delivery/utils/dimensions.dart';
import 'package:ifood_delivery/widgets/app_colunm.dart';
import 'package:ifood_delivery/widgets/big_text.dart';
import 'package:ifood_delivery/widgets/icon_and_text_widget.dart';
import 'package:ifood_delivery/widgets/small_text.dart';
import 'package:get/get.dart';

import '../../models/products_model.dart';



class FoodPageBody extends StatefulWidget {
  const FoodPageBody({Key? key}) : super(key: key);

  @override
  State<FoodPageBody> createState() => _FoodPageBodyState();
}

class _FoodPageBodyState extends State<FoodPageBody> {
  PageController pageController = PageController(viewportFraction: 0.85);
  var _currPageValue = 0.0;
  double _scaleFactor = 0.8;
  double _height = Dimensions.pageViewContainer;

  @override
  void initState(){
    super.initState();
    pageController.addListener(() {
      setState(() {
        _currPageValue = pageController.page!;
        //print("Current value is "+_currPageValue.toString());
      });
    });
  }

  @override
  void dispose(){
    pageController.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Column(
      children: [
        GetBuilder<PopularProductController>(builder: (popularProducts){
            return popularProducts.isloaded
                ? Container(
              //color: Colors.redAccent,
              height: Dimensions.pageView,
              child: GestureDetector(
                child: PageView.builder(
                  controller: pageController,
                  itemCount: popularProducts.popularProductList.length,
                  itemBuilder: (context, position){
                    return _buildPageItem(position, popularProducts.popularProductList[position]);
                  },
                ),
              ),
            ) :CircularProgressIndicator(color: AppColors.mainColor,);
          },
        ),
        ///dot
        GetBuilder<PopularProductController>(builder: (popularProducts){
            return DotsIndicator(
              dotsCount: popularProducts.popularProductList.isEmpty
                  ? 1
                  : popularProducts.popularProductList.length,
              position: _currPageValue,
              decorator: DotsDecorator(
                activeColor: AppColors.mainColor,
                size: const Size.square(9.0),
                activeSize: const Size(18.0, 9.0),
                activeShape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5.0),
                ),
              ),
            );
          },
        ),


        SizedBox(height: Dimensions.height30,),
        // ///
        // Container(
        //   margin: EdgeInsets.only(left: Dimensions.width30,right: Dimensions.width30),
        //   child: Row(
        //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //     //crossAxisAlignment: CrossAxisAlignment.end,
        //     children: [
        //       BigText(text: "Rượu vang"),
        //       SizedBox(height: Dimensions.height10,),
        //       Container(
        //         margin: const EdgeInsets.only(bottom: 3),
        //         child: BigText(text: ".", color: Colors.black26,),
        //       ),
        //       SizedBox(height: Dimensions.height10,),
        //       Container(
        //         margin: const EdgeInsets.only(bottom: 2),
        //         child: SmallText(text: "tất cả",),
        //       ),
        //     ],
        //   ),
        // ),
        //
        // GetBuilder<PopularProductController>(builder: (popularProducts){
        //   return popularProducts.isloaded
        //       ? Container(
        //     margin: EdgeInsets.only(left: Dimensions.width20,),
        //     width: size.width,
        //     height: size.height / 4.5,
        //     child: ListView.builder(
        //         physics: const BouncingScrollPhysics(),
        //         itemCount: popularProducts.popularProductList.length,
        //         scrollDirection: Axis.horizontal,
        //         itemBuilder: (ctx, index) {
        //           return GestureDetector(
        //             onTap: (){
        //               Get.toNamed(RouteHelper.getPopularFood(index,"home"));
        //             },
        //             child: Column(
        //               children: [
        //                 Container(
        //                   margin: const EdgeInsets.all(6),
        //                   width: Dimensions.listViewImgSize,
        //                   height: Dimensions.listViewImgSize,
        //                   decoration: BoxDecoration(
        //                       borderRadius: BorderRadius.circular(20),
        //                       image: DecorationImage(
        //                           image: NetworkImage(AppConstants.BASE_URL+ AppConstants.UPLOAD_URL
        //                               +popularProducts
        //                                   .popularProductList[index].img),
        //                           fit: BoxFit.cover)),
        //                 ),
        //                 Column(
        //                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //                   children: [
        //                     Container(
        //                       width: Dimensions.listViewImgSize,
        //                       child: BigText(
        //                         text:popularProducts.popularProductList[index].name,
        //                         size: Dimensions.font26/2,
        //                       ),
        //                     ),
        //                     Container(
        //                       width: Dimensions.listViewImgSize,
        //                       child: BigText(
        //                         text:"\$${popularProducts.popularProductList[index].price}",
        //                         size: Dimensions.font26/2,
        //                       ),
        //                     ),
        //                   ]
        //                 ),
        //               ],
        //             ),
        //           );
        //         }),)
        //       :CircularProgressIndicator(color: AppColors.mainColor,);
        //   },
        // ),
        SizedBox(height: Dimensions.height20,),
        ///wine
        Container(
          margin: EdgeInsets.only(left: Dimensions.width30,right: Dimensions.width30),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              BigText(text: "wine".tr),
              SizedBox(height: Dimensions.height10,),
              Container(
                margin: const EdgeInsets.only(bottom: 3),
                child: BigText(text: ".", color: Colors.black26,),
              ),
              SizedBox(height: Dimensions.height10,),
              Container(
                margin: const EdgeInsets.only(bottom: 2),
                child: SmallText(text: "all".tr,),
              ),
            ],
          ),
        ),

        GetBuilder<WineProductController>(builder: (wineProducts){
          return wineProducts.isloaded
              ? Container(
            margin: EdgeInsets.only(left: Dimensions.width20,),
            width: size.width,
            height: size.height / 4.5,
            child: ListView.builder(
                physics: const BouncingScrollPhysics(),
                itemCount: wineProducts.wineProductList.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (ctx, index) {
                  return GestureDetector(
                    onTap: (){
                      Get.toNamed(RouteHelper.getWineDetail(index,"home"));
                    },
                    child: Column(
                      children: [
                        Container(
                          margin: const EdgeInsets.all(6),
                          width: Dimensions.listViewImgSize,
                          height: Dimensions.listViewImgSize,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              image: DecorationImage(
                                  image: NetworkImage(AppConstants.BASE_URL+ AppConstants.UPLOAD_URL
                                      +wineProducts
                                          .wineProductList[index].img),
                                  fit: BoxFit.cover)),
                        ),
                        Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                width: Dimensions.listViewImgSize,
                                child: BigText(
                                  text: wineProducts.wineProductList[index].name,
                                  size: Dimensions.font26/2,
                                ),
                              ),
                              Container(
                                width: Dimensions.listViewImgSize,
                                child: BigText(
                                  text:"\$ ${wineProducts.wineProductList[index].price.toStringAsFixed(0)} VNĐ",
                                  size: Dimensions.font26/2,
                                ),
                              ),
                            ]
                        ),
                      ],
                    ),
                  );
                }),)
              :CircularProgressIndicator(color: AppColors.mainColor,);
        },
        ),

        ///brandy
        SizedBox(height: Dimensions.height20,),
        Container(
          margin: EdgeInsets.only(left: Dimensions.width30,right: Dimensions.width30),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              BigText(text: "brandy".tr),
              SizedBox(height: Dimensions.height10,),
              Container(
                margin: const EdgeInsets.only(bottom: 3),
                child: BigText(text: ".", color: Colors.black26,),
              ),
              SizedBox(height: Dimensions.height10,),
              Container(
                margin: const EdgeInsets.only(bottom: 2),
                child: SmallText(text: "all".tr,),
              ),
            ],
          ),
        ),

        GetBuilder<WineProductController>(builder: (products){
          return products.isloaded
              ? Container(
            margin: EdgeInsets.only(left: Dimensions.width20,),
            width: size.width,
            height: size.height / 4.5,
            child: ListView.builder(
                physics: const BouncingScrollPhysics(),
                itemCount: products.brandyProductList.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (ctx, index) {
                  return GestureDetector(
                    onTap: (){
                      Get.toNamed(RouteHelper.getBrandyDetail(index,"home"));
                    },
                    child: Column(
                      children: [
                        Container(
                          margin: const EdgeInsets.all(6),
                          width: Dimensions.listViewImgSize,
                          height: Dimensions.listViewImgSize,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              image: DecorationImage(
                                  image: NetworkImage(AppConstants.BASE_URL+ AppConstants.UPLOAD_URL
                                      +products
                                          .brandyProductList[index].img),
                                  fit: BoxFit.cover)),
                        ),
                        Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                width: Dimensions.listViewImgSize,
                                child: BigText(
                                  text: products.brandyProductList[index].name,
                                  size: Dimensions.font26/2,
                                ),
                              ),
                              Container(
                                width: Dimensions.listViewImgSize,
                                child: BigText(
                                  text:"\$ ${products.brandyProductList[index].price.toStringAsFixed(0)} VNĐ",
                                  size: Dimensions.font26/2,
                                ),
                              ),
                            ]
                        ),
                      ],
                    ),
                  );
                }),)
              :CircularProgressIndicator(color: AppColors.mainColor,);
        },
        ),
        SizedBox(height: Dimensions.height20,),
        ///mixed
        Container(
          margin: EdgeInsets.only(left: Dimensions.width30,right: Dimensions.width30),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              BigText(text: "mixed".tr),
              SizedBox(height: Dimensions.height10,),
              Container(
                margin: const EdgeInsets.only(bottom: 3),
                child: BigText(text: ".", color: Colors.black26,),
              ),
              SizedBox(height: Dimensions.height10,),
              Container(
                margin: const EdgeInsets.only(bottom: 2),
                child: SmallText(text: "all".tr,),
              ),
            ],
          ),
        ),

        GetBuilder<WineProductController>(builder: (products){
          return products.isloaded
              ? Container(
            margin: EdgeInsets.only(left: Dimensions.width20,),
            width: size.width,
            height: size.height / 4.5,
            child: ListView.builder(
                physics: const BouncingScrollPhysics(),
                itemCount: products.mixedProductList.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (ctx, index) {
                  return GestureDetector(
                    onTap: (){
                      Get.toNamed(RouteHelper.getMixedDetail(index,"home"));
                    },
                    child: Column(
                      children: [
                        Container(
                          margin: const EdgeInsets.all(6),
                          width: Dimensions.listViewImgSize,
                          height: Dimensions.listViewImgSize,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              image: DecorationImage(
                                  image: NetworkImage(AppConstants.BASE_URL+ AppConstants.UPLOAD_URL
                                      +products
                                          .mixedProductList[index].img),
                                  fit: BoxFit.cover)),
                        ),
                        Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                width: Dimensions.listViewImgSize,
                                child: BigText(
                                  text: products.mixedProductList[index].name,
                                  size: Dimensions.font26/2,
                                ),
                              ),
                              Container(
                                width: Dimensions.listViewImgSize,
                                child: BigText(
                                  text:"\$ ${products.mixedProductList[index].price.toStringAsFixed(0)} VNĐ",
                                  size: Dimensions.font24/2,
                                ),
                              ),
                            ]
                        ),
                      ],
                    ),
                  );
                }),)
              :CircularProgressIndicator(color: AppColors.mainColor,);
        },
        ),
        SizedBox(height: Dimensions.height20,),
        ///traditional
        Container(
          margin: EdgeInsets.only(left: Dimensions.width30,right: Dimensions.width30),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              BigText(text: "traditional".tr),
              SizedBox(height: Dimensions.height10,),
              Container(
                margin: const EdgeInsets.only(bottom: 3),
                child: BigText(text: ".", color: Colors.black26,),
              ),
              SizedBox(height: Dimensions.height10,),
              Container(
                margin: const EdgeInsets.only(bottom: 2),
                child: SmallText(text: "all".tr),
              ),
            ],
          ),
        ),

        GetBuilder<WineProductController>(builder: (products){
          return products.isloaded
              ? Container(
            margin: EdgeInsets.only(left: Dimensions.width20,),
            width: size.width,
            height: size.height / 4.5,
            child: ListView.builder(
                physics: const BouncingScrollPhysics(),
                itemCount: products.traditionalProductList.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (ctx, index) {
                  return GestureDetector(
                    onTap: (){
                      Get.toNamed(RouteHelper.getTraditionalDetail(index,"home"));
                    },
                    child: Column(
                      children: [
                        Container(
                          margin: const EdgeInsets.all(6),
                          width: Dimensions.listViewImgSize,
                          height: Dimensions.listViewImgSize,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              image: DecorationImage(
                                  image: NetworkImage(AppConstants.BASE_URL+ AppConstants.UPLOAD_URL
                                      +products
                                          .traditionalProductList[index].img),
                                  fit: BoxFit.cover)),
                        ),
                        Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                width: Dimensions.listViewImgSize,
                                child: BigText(
                                  text: products.traditionalProductList[index].name,
                                  size: Dimensions.font26/2,
                                ),
                              ),
                              Container(
                                width: Dimensions.listViewImgSize,
                                child: BigText(
                                  text:"\$ ${products.traditionalProductList[index].price.toStringAsFixed(0)} VNĐ",
                                  size: Dimensions.font26/2,
                                ),
                              ),
                            ]
                        ),
                      ],
                    ),
                  );
                }),)
              :CircularProgressIndicator(color: AppColors.mainColor,);
        },
        ),
        SizedBox(height: Dimensions.height20,),
        ///beer
        Container(
          margin: EdgeInsets.only(left: Dimensions.width30,right: Dimensions.width30),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              BigText(text: "Rượu bia"),
              SizedBox(height: Dimensions.height10,),
              Container(
                margin: const EdgeInsets.only(bottom: 3),
                child: BigText(text: ".", color: Colors.black26,),
              ),
              SizedBox(height: Dimensions.height10,),
              Container(
                margin: const EdgeInsets.only(bottom: 2),
                child: SmallText(text: "tất cả",),
              ),
            ],
          ),
        ),

        GetBuilder<WineProductController>(builder: (products){
          return products.isloaded
              ? Container(
            margin: EdgeInsets.only(left: Dimensions.width20,),
            width: size.width,
            height: size.height / 4.5,
            child: ListView.builder(
                physics: const BouncingScrollPhysics(),
                itemCount: products.beerProductList.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (ctx, index) {
                  return GestureDetector(
                    onTap: (){
                      Get.toNamed(RouteHelper.getBeerDetail(index,"home"));
                    },
                    child: Column(
                      children: [
                        Container(
                          margin: const EdgeInsets.all(6),
                          width: Dimensions.listViewImgSize,
                          height: Dimensions.listViewImgSize,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              image: DecorationImage(
                                  image: NetworkImage(AppConstants.BASE_URL+ AppConstants.UPLOAD_URL
                                      +products
                                          .beerProductList[index].img),
                                  fit: BoxFit.cover)),
                        ),
                        Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                width: Dimensions.listViewImgSize,
                                child: BigText(
                                  text: products.beerProductList[index].name,
                                  size: Dimensions.font26/2,
                                ),
                              ),
                              Container(
                                width: Dimensions.listViewImgSize,
                                child: BigText(
                                  text:"\$ ${products.beerProductList[index].price.toStringAsFixed(0)}",
                                  size: Dimensions.font26/2,
                                ),
                              ),
                            ]
                        ),
                      ],
                    ),
                  );
                }),)
              :CircularProgressIndicator(color: AppColors.mainColor,);
        },
        ),
        SizedBox(height: Dimensions.height20,),
        ///other
        Container(
          margin: EdgeInsets.only(left: Dimensions.width30,right: Dimensions.width30),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              BigText(text: "other".tr),
              SizedBox(height: Dimensions.height10,),
              Container(
                margin: const EdgeInsets.only(bottom: 3),
                child: BigText(text: ".", color: Colors.black26,),
              ),
              SizedBox(height: Dimensions.height10,),
              Container(
                margin: const EdgeInsets.only(bottom: 2),
                child: SmallText(text: "all".tr,),
              ),
            ],
          ),
        ),

        GetBuilder<WineProductController>(builder: (products){
          return products.isloaded
              ? Container(
            margin: EdgeInsets.only(left: Dimensions.width20,),
            width: size.width,
            height: size.height / 4.5,
            child: ListView.builder(
                physics: const BouncingScrollPhysics(),
                itemCount: products.otherProductList.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (ctx, index) {
                  return GestureDetector(
                    onTap: (){
                      Get.toNamed(RouteHelper.getOtherDetail(index,"home"));
                    },
                    child: Column(
                      children: [
                        Container(
                          margin: const EdgeInsets.all(6),
                          width: Dimensions.listViewImgSize,
                          height: Dimensions.listViewImgSize,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              image: DecorationImage(
                                  image: NetworkImage(AppConstants.BASE_URL+ AppConstants.UPLOAD_URL
                                      +products
                                          .otherProductList[index].img),
                                  fit: BoxFit.cover)),
                        ),
                        Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                width: Dimensions.listViewImgSize,
                                child: BigText(
                                  text: products.otherProductList[index].name,
                                  size: Dimensions.font26/2,
                                ),
                              ),
                              Container(
                                width: Dimensions.listViewImgSize,
                                child: BigText(
                                  text:"\$ ${products.otherProductList[index].price.toStringAsFixed(0)} VNĐ",
                                  size: Dimensions.font26/2,
                                ),
                              ),
                            ]
                        ),
                      ],
                    ),
                  );
                }),)
              :CircularProgressIndicator(color: AppColors.mainColor,);
        },
        ),





        ///
        SizedBox(height: Dimensions.height30,),

        // Container(
        //   margin: EdgeInsets.only(left: Dimensions.width30,),
        //   child: Row(
        //     crossAxisAlignment: CrossAxisAlignment.end,
        //     children: [
        //       BigText(text: "Recommended"),
        //       SizedBox(height: Dimensions.height10,),
        //       Container(
        //         margin: const EdgeInsets.only(bottom: 3),
        //         child: BigText(text: ".", color: Colors.black26,),
        //       ),
        //       SizedBox(height: Dimensions.height10,),
        //       Container(
        //         margin: const EdgeInsets.only(bottom: 2),
        //         child: SmallText(text: "Food pairing",),
        //       ),
        //     ],
        //   ),
        // ),

        // GetBuilder<RecommendedProductController>(builder: (recommendedProduct){
        //   return recommendedProduct.isLoaded
        //       ? ListView.builder(
        //     physics: NeverScrollableScrollPhysics(),
        //     shrinkWrap: true,
        //     itemCount: recommendedProduct.recommendedProductList.length,
        //     itemBuilder: (context, index) {
        //       return GestureDetector(
        //           onTap: () {
        //             // Get.toNamed(RouteHelper.getRecommendedFoodDetail(
        //             //    index, "initial"));
        //
        //             Get.toNamed(RouteHelper.getRecommendedFood(index,"home"));
        //             //print(RouteHelper.getRecommendedFood());
        //           },
        //           child: Container(
        //             margin: EdgeInsets.only(
        //               left: Dimensions.width20,
        //               right: Dimensions.width20,
        //               top: Dimensions.height10,
        //             ),
        //             child: Row(
        //               children: [
        //                 Container(
        //                   width: Dimensions.listViewImgSize,
        //                   height: Dimensions.listViewImgSize,
        //                   decoration: BoxDecoration(
        //                       borderRadius: BorderRadius.circular(Dimensions.radius20),
        //                       color: Colors.white,
        //                       image: DecorationImage(
        //                         fit: BoxFit.cover,
        //                         image: NetworkImage(
        //                               AppConstants.BASE_URL+ AppConstants.UPLOAD_URL
        //                                   +recommendedProduct
        //                                   .recommendedProductList[index].img!,
        //                           ),
        //                       ),
        //                   ),
        //                 ),
        //                 Expanded(
        //                   child: Container(
        //                     height: Dimensions.listViewTextContSize,
        //                     decoration: BoxDecoration(
        //                       borderRadius: BorderRadius.only(
        //                         topRight: Radius.circular(Dimensions.radius20),
        //                         bottomRight: Radius.circular(Dimensions.radius20),
        //                       ),
        //                       color: Colors.white,
        //                     ),
        //                     child: Padding(
        //                       padding: EdgeInsets.only(left: Dimensions.width10),
        //                       child: Column(
        //                         crossAxisAlignment: CrossAxisAlignment.start,
        //                         mainAxisAlignment: MainAxisAlignment.center,
        //                         children: [
        //                           BigText(text: recommendedProduct.recommendedProductList[index].name!),
        //                           SizedBox(height: Dimensions.height10,),
        //                           Expanded(
        //                             child: SmallText(
        //                                 text: recommendedProduct
        //                                     .recommendedProductList[index]
        //                                     .description!),
        //                           ),
        //                           SizedBox(height: Dimensions.height10,),
        //                           Row(
        //                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //                             children: [
        //                               IconAndTextWidget(
        //                                 icon: Icons.crib_sharp,
        //                                 text: "Normal",
        //                                 iconColor: AppColors.iconColor1,
        //                               ),
        //                               IconAndTextWidget(
        //                                 icon: Icons.location_on,
        //                                 text: "1.7km",
        //                                 iconColor: AppColors.iconColor1,
        //                               ),
        //                               IconAndTextWidget(
        //                                 icon: Icons.access_time_rounded,
        //                                 text: "32min",
        //                                 iconColor: AppColors.iconColor1,
        //                               )
        //                             ],
        //                           )
        //                         ],
        //                       ),
        //                     ),
        //                   ),
        //                 )
        //               ],
        //             ),
        //           ),
        //         );
        //       },)
        //       : CircularProgressIndicator(color: AppColors.mainColor,);
        //   }),
      ],
    );
  }

  Widget _buildPageItem(int index, Product popularProduct){
    Matrix4 matrix = new Matrix4.identity();
    if(index == _currPageValue.floor()){
      var currScale = 1-(_currPageValue-index)*(1-_scaleFactor);
      var currTrans = _height*(1-currScale)/2;
      matrix = Matrix4.diagonal3Values(1, currScale, 1)..setTranslationRaw(0, currTrans, 0);

    } else if (index == _currPageValue.floor()+1){
      var currScale = _scaleFactor+(_currPageValue-index+1)*(1-_scaleFactor);
      var currTrans = _height*(1-currScale)/2;
      matrix = Matrix4.diagonal3Values(1, currScale, 1);
      matrix = Matrix4.diagonal3Values(1, currScale, 1)..setTranslationRaw(0, currTrans, 0);

    } else if (index == _currPageValue.floor()-1){
      var currScale = _scaleFactor+(_currPageValue-index+1)*(1-_scaleFactor);
      var currTrans = _height*(1-currScale)/2;
      matrix = Matrix4.diagonal3Values(1, currScale, 1);
      matrix = Matrix4.diagonal3Values(1, currScale, 1)..setTranslationRaw(0, currTrans, 0);

    } else {
      var currScale = 0.8;
      matrix = Matrix4.diagonal3Values(1, currScale, 1)..setTranslationRaw(0, _height*(1-_scaleFactor)/2, 1);
    }
    return Transform(
      transform: matrix,
      child: Stack(
        children: [
          GestureDetector(
            onTap: () {
              Get.toNamed(RouteHelper.getPopularFood(index,"home"));
            },
            child: Container(
              height: Dimensions.pageViewContainer,
              margin: EdgeInsets.only(
                left: Dimensions.width10,
                right: Dimensions.width10,
              ),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(Dimensions.radius30),
                  color: index.isEven? Color(0xFF69c5df) : Color(0xFF9294cc),
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: NetworkImage(
                        AppConstants.BASE_URL+ AppConstants.UPLOAD_URL+popularProduct.img!
                    ),
                  ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: Dimensions.pageViewTextContainer,
              margin: EdgeInsets.only(
                left: Dimensions.width30,
                right: Dimensions.width30,
                bottom: Dimensions.width30,
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(Dimensions.radius20),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Color(0xFFe8e8e8),
                    blurRadius: 1.0,
                    offset: Offset( 0, 1),
                  ),
                  BoxShadow(
                      color: Colors.white,
                      blurRadius: 1.0,
                      offset: Offset( -1, 0),
                  ),
                  BoxShadow(
                      color: Color(0xFFe8e8e8),
                      blurRadius: 1.0,
                      offset: Offset( 1, 0)
                  ),
                ]
              ),
              child: Container(
                padding: EdgeInsets.only(
                  top: Dimensions.height15,
                  left: Dimensions.height15,
                  right: Dimensions.height15,),
                child: AppColunm(
                  text: popularProduct.name!,
                  price: popularProduct.price,
                  stars: popularProduct.stars,
                  size: Dimensions.font26,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
