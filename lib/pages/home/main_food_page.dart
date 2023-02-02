import 'package:flutter/material.dart';
import 'package:ifood_delivery/pages/home/food_page_body.dart';
import 'package:ifood_delivery/utils/colors.dart';
import 'package:ifood_delivery/utils/dimensions.dart';
import 'package:ifood_delivery/widgets/big_text.dart';
import 'package:ifood_delivery/widgets/small_text.dart';
import 'package:get/get.dart';
import '../../controllers/popular_product_controller.dart';
import '../../controllers/wine_product_controller.dart';
import '../../routes/route_helper.dart';


class MainFoodPage extends StatefulWidget {
  const MainFoodPage({Key? key}) : super(key: key);

  @override
  State<MainFoodPage> createState() => _MainFoodPageState();
}

class _MainFoodPageState extends State<MainFoodPage> {
  ScrollController scrollController = ScrollController();
  double _scrollPosition=0;
  double _opacity=0;
  Future<void> _loadResources(bool reload) async {
    await Get.find<PopularProductController>().getPopularProductList();
    //await Get.find<RecommendedProductController>().getRecommendedProductList();
    await Get.find<WineProductController>().getWineProductList();
    await Get.find<WineProductController>().getBrandyProductList();
    await Get.find<WineProductController>().getMixedProductList();
    await Get.find<WineProductController>().getTraditionalProductList();
    await Get.find<WineProductController>().getBeerProductList();
    await Get.find<WineProductController>().getOtherProductList();
  }
  @override
  void initState(){
    super.initState();
    _loadResources(true);
    scrollController.addListener(() {
      setState(() {
        _scrollPosition=scrollController.position.pixels;
      });
    });
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    _opacity = _scrollPosition < screenSize.height * 0.40
        ? _scrollPosition / (screenSize.height * 0.20)
        : 1;
    //this is to check if opacity is less than 0 or bigger than 1
    _opacity=_opacity<0?0:_opacity>1?1:_opacity;
    return RefreshIndicator(
      onRefresh: () async {
        await _loadResources(true);
      },
      child: Column(
      children: [
        Container(
          color: Colors.white.withOpacity(_opacity),
          child: Container(
            margin: EdgeInsets.only(
              top: Dimensions.height45,
              bottom: Dimensions.height15,
            ),
            padding: EdgeInsets.only(
              left: Dimensions.width20,
              right: Dimensions.width20,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    BigText(text: 'Rượu'.tr, color: AppColors.mainColor,),
                    Row(
                      children: [
                        SmallText(text: "Thương Hiệu", color: Colors.black54,),
                        Icon(Icons.arrow_drop_down_rounded)
                      ],
                    )
                  ],
                ),
                Center(
                  child: GestureDetector(
                    onTap: ()=>Get.toNamed(RouteHelper.getSearchPage()),
                    child: Container(
                      width: Dimensions.height45,
                      height: Dimensions.height45,
                      child: Icon(
                        Icons.search,
                        color: Colors.white,
                        size: Dimensions.iconSize24,
                      ),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(Dimensions.radius15),
                          color: AppColors.mainColor
                      ),
                    ),
                  ),
                )
                // Expanded(
                //   child: Row(
                //     children: [
                //       Expanded(
                //         child: Container(
                //           //color: Colors.white.withOpacity(0.7),
                //           margin: EdgeInsets.only(
                //             left: Dimensions.width20,
                //             right: Dimensions.width20,
                //             bottom: Dimensions.width10,
                //         ),
                //         height: Dimensions.iconBackSize,
                //         decoration: BoxDecoration(
                //             borderRadius: BorderRadius.circular(Dimensions.borderRadius15),
                //             color: Colors.blueAccent.withOpacity(0.7)
                //         ),
                //         child: GestureDetector(
                //           onTap: ()=>Get.toNamed(RouteHelper.getSearchPage()),
                //           child: Padding(
                //             padding: EdgeInsets.symmetric( horizontal:Dimensions.width10),
                //             child: Row(
                //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //               children: [
                //                 Text("Search for food"),
                //                 Icon(Icons.search),
                //               ],
                //             ),
                //           ),
                //         ),
                //       ),),
                //     ],
                //   ),
                // ),
              ],
            ),
          ),
        ),

        Expanded(
          child: SingleChildScrollView(
            child: FoodPageBody(),
          ),
        ),
      ],
    ),);
  }
}
