import 'package:flutter/material.dart';
import 'package:ifood_delivery/base/custom_app_bar.dart';
import 'package:ifood_delivery/base/custom_loader.dart';
import 'package:ifood_delivery/controllers/auth_controller.dart';
import 'package:ifood_delivery/controllers/cart_controller.dart';
import 'package:ifood_delivery/controllers/location_controller.dart';
import 'package:ifood_delivery/controllers/user_controller.dart';
import 'package:ifood_delivery/routes/route_helper.dart';
import 'package:ifood_delivery/utils/colors.dart';
import 'package:ifood_delivery/utils/dimensions.dart';
import 'package:ifood_delivery/widgets/app_icon.dart';
import 'package:ifood_delivery/widgets/big_text.dart';
import 'package:get/get.dart';
import '../../widgets/account_widget.dart';

class AccountPage extends StatelessWidget {
  const AccountPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool _userLoggedIn = Get.find<AuthController>().userLoggedIn();
    if(_userLoggedIn){
      Get.find<UserController>().getUserInfo();
      print("User has logged in");
    }
    return Scaffold(
      appBar: CustomAppBar(
        title: "profile".tr,
      ),
      body: GetBuilder<UserController>(builder: (userController){
        return _userLoggedIn
            ?(userController.isLoading ?Container(
          width: double.maxFinite,
          margin: EdgeInsets.only(top: Dimensions.height20),
          child: Column(
            children: [
              //profile icon
              AppIcon(
                icon: Icons.person,
                backgroundColor: AppColors.mainColor,
                iconColor: Colors.white,
                iconSize: Dimensions.height45+Dimensions.height30,
                size: Dimensions.height15*10,
              ),
              SizedBox(height: Dimensions.height30,),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      //name
                      AccountWidget(
                        appIcon:AppIcon(
                          icon: Icons.person,
                          backgroundColor: AppColors.mainColor,
                          iconColor: Colors.white,
                          iconSize: Dimensions.height10*5/2,
                          size: Dimensions.height10*4,
                        ),
                        bigText: BigText(text: userController.userModel!.name,),
                      ),
                      SizedBox(height: Dimensions.height20,),
                      //phone
                      AccountWidget(
                        appIcon:AppIcon(
                          icon: Icons.phone,
                          backgroundColor: AppColors.yellowColor,
                          iconColor: Colors.white,
                          iconSize: Dimensions.height10*5/2,
                          size: Dimensions.height10*4,
                        ),
                        bigText: BigText(text: userController.userModel!.phone,),
                      ),
                      SizedBox(height: Dimensions.height20,),
                      //email
                      AccountWidget(
                        appIcon:AppIcon(
                          icon: Icons.email,
                          backgroundColor: AppColors.yellowColor,
                          iconColor: Colors.white,
                          iconSize: Dimensions.height10*5/2,
                          size: Dimensions.height10*4,
                        ),
                        bigText: BigText(text: userController.userModel!.email,),
                      ),
                      SizedBox(height: Dimensions.height20,),
                      //address
                      GetBuilder<LocationController>(
                        builder: (locationController){
                          if(_userLoggedIn&& locationController.addressList.isEmpty){
                            return GestureDetector(
                              onTap: (){
                                Get.offNamed(RouteHelper.getAddressPage());
                              },
                              child: AccountWidget(
                                appIcon:AppIcon(
                                  icon: Icons.location_on,
                                  backgroundColor: AppColors.mainColor,
                                  iconColor: Colors.white,
                                  iconSize: Dimensions.height10*5/2,
                                  size: Dimensions.height10*4,
                                ),
                                bigText: BigText(text: "Điền địa chỉ của bạn",),
                              ),
                            );
                          } else {
                            return GestureDetector(
                              onTap: (){
                                Get.offNamed(RouteHelper.getAddressPage());
                              },
                              child: AccountWidget(
                                appIcon:AppIcon(
                                  icon: Icons.location_on,
                                  backgroundColor: AppColors.mainColor,
                                  iconColor: Colors.white,
                                  iconSize: Dimensions.height10*5/2,
                                  size: Dimensions.height10*4,
                                ),
                                bigText: BigText(text: "Địa chỉ",),
                              ),
                            );
                          }
                        },
                      ),
                      SizedBox(height: Dimensions.height20,),

                      AccountWidget(
                        appIcon:AppIcon(
                          icon: Icons.message_outlined,
                          backgroundColor: AppColors.mainColor,
                          iconColor: Colors.white,
                          iconSize: Dimensions.height10*5/2,
                          size: Dimensions.height10*4,
                        ),
                        bigText: BigText(text: "Tin nhắn",),
                      ),
                      SizedBox(height: Dimensions.height20,),

                      //message
                      GestureDetector(
                        onTap: (){
                          if(Get.find<AuthController>().userLoggedIn()){
                            Get.find<AuthController>().clearSharedData();
                            Get.find<CartController>().clear();
                            Get.find<CartController>()./*clearCartHistory()*/clearCartList();
                            Get.find<LocationController>().clearAddressList();
                            Get.offNamed(RouteHelper.getSignInPage());
                          }else {
                            print("You looged out");
                            Get.offNamed(RouteHelper.getSignInPage());
                          }
                        },
                        child: AccountWidget(
                          appIcon:AppIcon(
                            icon: Icons.logout,
                            backgroundColor: Colors.redAccent,
                            iconColor: Colors.white,
                            iconSize: Dimensions.height10*5/2,
                            size: Dimensions.height10*4,
                          ),
                          bigText: BigText(text: "Đăng xuất",),
                        ),
                      ),
                      SizedBox(height: Dimensions.height20,),
                    ],
                  ),
                ),
              ), //SizedBox(height: Dimensions.height20,),
            ],
          ),
        ) :CustomLoader())
            :Container(
          child: Center(
            child:Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: double.maxFinite,
                  height: Dimensions.height20*8,
                  margin: EdgeInsets.only(
                      left: Dimensions.width20,
                      right: Dimensions.width20
                  ),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(Dimensions.radius20),
                      image: DecorationImage(
                          fit: BoxFit.cover,
                          image: AssetImage(
                              "assets/image/signintocontinue.png"
                          )
                      )
                  ),
                ),
                GestureDetector(
                  onTap: (){
                    Get.toNamed(RouteHelper.getSignInPage());
                  },
                  child: Container(
                    width: double.maxFinite,
                    height: Dimensions.height20*5,
                    margin: EdgeInsets.only(
                        left: Dimensions.width20,
                        right: Dimensions.width20
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.mainColor,
                        borderRadius: BorderRadius.circular(Dimensions.radius20)
                    ),
                    child: Center(child: BigText(text: "Đăng nhập",color: Colors.white,size: Dimensions.font26,)),
                  ),
                ),
              ],
            ),
          ),
        );
      },),
    );
  }
}
