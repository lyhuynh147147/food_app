import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ifood_delivery/base/common_text_button.dart';
import 'package:ifood_delivery/base/order_type_button.dart';
import 'package:ifood_delivery/controllers/cart_controller.dart';
import 'package:ifood_delivery/controllers/location_controller.dart';
import 'package:ifood_delivery/controllers/order_controller.dart';
import 'package:ifood_delivery/controllers/popular_product_controller.dart';
import 'package:ifood_delivery/controllers/user_controller.dart';
import 'package:ifood_delivery/pages/checkout/payment_option_button.dart';
import 'package:ifood_delivery/routes/route_helper.dart';
import 'package:ifood_delivery/utils/app_constants.dart';
import 'package:ifood_delivery/utils/dimensions.dart';
import 'package:ifood_delivery/utils/styles.dart';
import 'package:ifood_delivery/widgets/app_icon.dart';
import 'package:ifood_delivery/widgets/big_text.dart';
import 'package:ifood_delivery/widgets/small_text.dart';

import '../../base/no_data_page.dart';
import '../../base/show_custom_snackbar.dart';
import '../../controllers/auth_controller.dart';
import '../../controllers/wine_product_controller.dart';
import '../../models/cart_model.dart';
import '../../models/place_order_model.dart';
import '../../utils/colors.dart';
import '../../widgets/app_text_field.dart';
import '../home/main_food_page.dart';

class CartPage extends StatefulWidget {
  final int pageId;
  String page;
  CartPage({
    Key? key,
    required this.pageId,
    required this.page,
  }) : super(key: key);

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  @override
  Widget build(BuildContext context) {
    final TextEditingController _noteController = TextEditingController();

    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            top: Dimensions.height20+3,
            left: Dimensions.width20,
            right: Dimensions.width20,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                GestureDetector(
                  child: AppIcon(
                    icon: Icons.arrow_back_ios,
                    iconColor: Colors.white,
                    backgroundColor: Colors.black.withOpacity(0.2),
                    //iconSize: Dimensions.iconSize24,
                  ),
                  onTap: (){
                    //Get.to(()=>MainFoodPage());
                    Get.back();
                  },
                ),
                SizedBox(width: Dimensions.width20*5,),
                GestureDetector(
                  child: AppIcon(
                    icon: Icons.home_outlined,
                    iconColor: Colors.white,
                    backgroundColor: Colors.black.withOpacity(0.2),
                    //iconSize: Dimensions.iconSize24,
                  ),
                  onTap: (){
                    Get.toNamed(RouteHelper.getInitial());
                  },
                ),
              ],
            ),
          ),
          GetBuilder<CartController>(builder: (_cartController){
            return _cartController./*getItems*/getCarts.length>0
                ?Positioned(
              top: Dimensions.height20*3,
              left: Dimensions.width20,
              right: Dimensions.width20,
              bottom: 0,
              child: Container(
                margin: EdgeInsets.only(top: Dimensions.height15),
                child: MediaQuery.removePadding(
                  context: context,
                  removeTop: true,
                  child: GetBuilder<CartController>(
                    builder: (cartController){
                      var _cartList = cartController./*getItems*/getCarts;

                      return ListView.builder(
                        itemCount: _cartList.length,
                        itemBuilder: (_,index){
                          CartModel cartItem = _cartList[index];

                          return Container(
                            width: double.maxFinite,
                            height: Dimensions.height20*5,
                            child: _cartList[index].quantity! > 0?
                            Row(
                              children: [
                                GestureDetector(
                                  onTap:(){
                                    ///popu
                                    var popularIndex =Get.find<PopularProductController>().popularProductList
                                        .indexWhere((element)=>element.id == cartItem.product!.id );
                                    print("popu--"+popularIndex.toString());

                                    if(popularIndex >= 0){
                                      print("1-- "+popularIndex.toString());
                                      Get.toNamed(RouteHelper.getPopularFood(popularIndex,'cartpage'));
                                    } else {
                                      ///wine
                                      var wineIndex =Get.find<WineProductController>().wineProductList
                                          .indexWhere((element)=>element.id == cartItem.product!.id );
                                      print("wine--"+wineIndex.toString());

                                      if ( wineIndex >= 0) {
                                        Get.toNamed(RouteHelper.getWineDetail(wineIndex, 'cart_page'));

                                      } else {
                                        ///brandy
                                        var brandyIndex =Get.find<WineProductController>().brandyProductList
                                            .indexWhere((element)=>element.id == cartItem.product!.id );
                                        print("brandy--"+brandyIndex.toString());

                                        if (brandyIndex >= 0) {
                                          Get.toNamed(RouteHelper.getBrandyDetail(brandyIndex, 'cart_page'));
                                        } else {
                                          ///beer
                                          var beerIndex =Get.find<WineProductController>().beerProductList
                                              .indexWhere((element)=>element.id == cartItem.product!.id );
                                          print("beer--"+beerIndex.toString());

                                          if (beerIndex >= 0) {
                                            Get.toNamed(RouteHelper.getBeerDetail(beerIndex, 'cart_page'));

                                          } else {
                                            ///mixed
                                            var mixedIndex =Get.find<WineProductController>().mixedProductList
                                                .indexWhere((element)=>element.id == cartItem.product!.id );
                                            print("mixed--"+mixedIndex.toString());

                                            if (mixedIndex >= 0) {
                                              Get.toNamed(RouteHelper.getMixedDetail(mixedIndex, 'cart_page'));

                                            } else {
                                              ///other
                                              var otherIndex =Get.find<WineProductController>().otherProductList
                                                  .indexWhere((element)=>element.id == cartItem.product!.id );
                                              print("other--"+otherIndex.toString());

                                              if (otherIndex >= 0) {
                                                Get.toNamed(RouteHelper.getOtherDetail(otherIndex, 'cart_page'));

                                              } else {
                                                ///traditional
                                                var traditionalIndex =Get.find<WineProductController>().traditionalProductList
                                                    .indexWhere((element)=>element.id == cartItem.product!.id );
                                                print("traditional--"+traditionalIndex.toString());

                                                if (traditionalIndex >= 0) {
                                                  Get.toNamed(RouteHelper.getTraditionalDetail(traditionalIndex, 'cart_page'));
                                                }
                                              }
                                            }
                                          }
                                        }

                                      }

                                    }

                                    // var popularIndex = Get.find<PopularProductController>()
                                    //     .popularProductList
                                    //     .indexOf(_cartList[index].product!);
                                    // if(popularIndex>=0){
                                    //   print("popu "+popularIndex.toString());
                                    //   Get.toNamed(RouteHelper.getPopularFood(0,'cartpage'));
                                    // }
                                    // else {
                                    //   var wineIndex = Get.find<RecommendedProductController>()
                                    //       .recommendedProductList
                                    //       .indexOf(_cartList[index].product!);
                                    //   print("wine "+wineIndex.toString());
                                    //   if(wineIndex < 0) {
                                    //     Get.snackbar(
                                    //       "History product",
                                    //       "Product review is not availble for history products",
                                    //       backgroundColor: AppColors.mainColor,
                                    //       colorText: Colors.white,
                                    //     );
                                    //   } else {
                                    //     Get.toNamed(RouteHelper.getRecommendedFood(0,'cartpage'));
                                    //   }
                                    // }
                                  },
                                  child: Container(
                                    width: Dimensions.height20*5,
                                    height: Dimensions.height20*5,
                                    margin: EdgeInsets.only(
                                        bottom: Dimensions.height10
                                    ),
                                    decoration: BoxDecoration(
                                        image: DecorationImage(
                                          fit: BoxFit.cover,
                                          image: NetworkImage(
                                              AppConstants.BASE_URL+AppConstants.UPLOAD_URL+cartController./*getItems*/getCarts[index].img!
                                          ),
                                        ),
                                        borderRadius: BorderRadius.circular(Dimensions.radius20),
                                        color: Colors.white
                                    ),
                                  ),
                                ),
                                SizedBox(width: Dimensions.width10,),
                                Expanded(
                                  child: Container(
                                    height: Dimensions.height20*5,
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                      children: [
                                        BigText(text: cartController./*getItems*/getCarts[index].name!,),
                                        //SmallText(text: cartController./*getItems*/getCarts[index].s,),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            BigText(
                                              text: cartController./*getItems*/getCarts[index]!.price!.toStringAsFixed(0),
                                              color: Colors.redAccent,
                                            ),
                                            Container(
                                              padding: EdgeInsets.only(
                                                bottom: Dimensions.height10,
                                                left: Dimensions.height10,
                                                right: Dimensions.height10,
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
                                                            cartController.addItem(_cartList[index].product!, -1);
                                                          },
                                                        ),
                                                        SizedBox(width: Dimensions.width10,),
                                                        BigText(text: _cartList[index].quantity.toString()),//popularProduct.inCartItem.toString()),
                                                        SizedBox(width: Dimensions.width10,),
                                                        GestureDetector(
                                                          child: Icon(
                                                            Icons.add,
                                                            color: AppColors.signColor,
                                                          ),
                                                          onTap: (){
                                                            cartController.addItem(_cartList[index].product!, 1);
                                                          },
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            )
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            )
                                :Container(),
                          );
                        },
                      );
                    },
                  ),
                ),
              ),
            )
                :NoDataPage(text: "Giỏ hàng trống",);
          })
        ],
      ),
      bottomNavigationBar: GetBuilder<OrderController>(builder: (orderController){
         _noteController.text = orderController.foodNote!;
          return GetBuilder<CartController>(
            builder: (cartController){
              return Container(
                  height: Dimensions.bottomHeightBar +50,
                  width: double.maxFinite,
                  padding: EdgeInsets.only(
                    top: Dimensions.height10,
                    bottom: Dimensions.height10,
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
                  child: cartController./*getItems*/getCarts.length > 0
                      ? Column(
                    children: [
                      InkWell(
                        onTap: ()=> showModalBottomSheet(
                          backgroundColor: Colors.transparent,
                          context: context,
                          builder: (_){
                            return Column(
                              children: [
                                Expanded(
                                  child: SingleChildScrollView(
                                    child: Container(
                                      height: MediaQuery.of(context).size.height*0.9,
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(Dimensions.radius20),
                                            topRight: Radius.circular(Dimensions.radius20),
                                          )
                                      ),
                                      child: Column(
                                        children: [
                                          Container(
                                            height: 520,
                                            padding: EdgeInsets.only(
                                              left: Dimensions.width20,
                                              right: Dimensions.width20,
                                              top: Dimensions.height20,
                                            ),
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                PaymentOptionButton(
                                                  index: 0,
                                                  icon: Icons.money,
                                                  title: 'Thanh toán khi giao hàng',
                                                  subtitle: 'Bạn thanh toán sau khi nhận hàng',
                                                ),
                                                SizedBox(height: Dimensions.height10/2,),
                                                PaymentOptionButton(
                                                  index: 1,
                                                  icon: Icons.paypal_outlined,
                                                  title: 'Thanh toán ví tiện tử',
                                                  subtitle: 'Cách thanh toán an toàn hơn và nhanh hơn',
                                                ),
                                                SizedBox(height: Dimensions.height30,),
                                                Text('Tùy chọn giao hàng', style: robotoMedium,),
                                                SizedBox(height: Dimensions.height10/2,),
                                                OrderTypeButton(
                                                  value: 'delivery'.tr,
                                                  title: 'Giao hàng tận nhà',
                                                  amount: double.parse(Get.find<CartController>().totalAmount.toString()),
                                                  isFree: false,
                                                ),
                                                SizedBox(height: Dimensions.height10/2,),
                                                OrderTypeButton(
                                                  value: 'take away'.tr,
                                                  title: 'Nhận hàng tại cửa hàng',
                                                  amount: 10.0,
                                                  isFree: true,
                                                ),
                                                BigText(text: "Ghi chú "),
                                                AppTextField(
                                                  textController: _noteController,
                                                  hintText: '',
                                                  icon: Icons.note,
                                                  maxLines: true,
                                                )
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            );
                          },
                        ).whenComplete(() => orderController.setFoodNote(_noteController.text.trim())),
                        child: Container(
                          width: double.maxFinite,
                          child: CommonTextButton(text:"Lựa chọn thanh toán"),
                        ),
                      ),
                      SizedBox(height: Dimensions.height10,),
                      Row(
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

                                SizedBox(width: Dimensions.width10,),
                                BigText(text: "\$ "+cartController.totalAmount.toStringAsFixed(0)),
                                SizedBox(width: Dimensions.width10,),

                              ],
                            ),
                          ),
                          GestureDetector(
                            onTap: (){
                              //popularProduct.addItem(product);
                              //print(Get.find<AuthController>().userLoggedIn());
                              if(Get.find<AuthController>().userLoggedIn()){
                                Get.find<AuthController>().updateToken();
                                print("logged in?");
                                //cartController.addToHistory();
                                if(Get.find<LocationController>().addressList.isEmpty){
                                  Get.toNamed(RouteHelper.getAddressPage());
                                } else {
                                  var location = Get.find<LocationController>().getUserAddress();
                                  var cart = Get.find<CartController>().getCarts;
                                  var user = Get.find<UserController>().userModel;
                                  PlaceOrderBody placeOrder = PlaceOrderBody(
                                    cart: cart,
                                    orderAmount: 100.0,
                                    orderNote: orderController.foodNote!,
                                    address: location.address,
                                    latitude: location.latitude,
                                    longitude: location.longitude,
                                    contactPersonNumber: user!.phone,
                                    contactPersonName: user!.name,
                                    distance: 10.0,
                                    scheduleAt: '',
                                    orderType: orderController.orderType,
                                    paymentMethod: orderController.paymentMethodIndex == 0
                                        ? 'cash_on_delivery'.tr
                                        : 'digital_payment'.tr
                                  );
                                   //print("Test");
                                   print(placeOrder.toJson());
                                   //return;

                                  Get.find<OrderController>().placeOrder(
                                      placeOrder,_callback
                                  );

                                  //Get.offNamed(RouteHelper.getInitial());
                                  //Get.offNamed(RouteHelper.getPaymentPage("100128", Get.find<UserController>().userModel!.id!));
                                }
                              } else {

                                Get.toNamed(RouteHelper.getSignInPage());
                              }

                            },
                            child: CommonTextButton(text: 'Thanh toán',),
                          ),
                        ],
                      ),
                    ],
                  ): NoDataPage(text: "")
              );
            },
          );
        },
      ),

    );


  }

  void _callback(bool isSuccess, String message, String orderID){
    if(isSuccess){
      Get.find<CartController>().clear();
      Get.find<CartController>().removeCartSharedPreference();
      Get.find<CartController>().addToHistory();
      if(Get.find<OrderController>().paymentMethodIndex==0){
        Get.offNamed(RouteHelper.getOrderSuccessPage(orderID, "success"));
      } else {
        Get.offNamed(RouteHelper.getPaymentPage(orderID, Get.find<UserController>().userModel!.id!));
      }
    } else {
      showCustomSnackBar(message);
    }
  }
}
