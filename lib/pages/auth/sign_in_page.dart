import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:ifood_delivery/base/custom_loader.dart';
import 'package:ifood_delivery/pages/auth/sign_up_page.dart';
import 'package:ifood_delivery/routes/route_helper.dart';
import 'package:ifood_delivery/utils/colors.dart';
import 'package:ifood_delivery/utils/dimensions.dart';
import 'package:ifood_delivery/widgets/app_text_field.dart';
import 'package:ifood_delivery/widgets/big_text.dart';
import 'package:get/get.dart';


import '../../base/show_custom_snackbar.dart';
import '../../controllers/auth_controller.dart';

class SignInPage extends StatelessWidget {
  const SignInPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var phoneController = TextEditingController();
    var passwordController = TextEditingController();

    void _login(AuthController authController) {
      //var authController = Get.find<AuthController>();
      String phone = phoneController.text.trim();
      String password = passwordController.text.trim();

      if(phone.isEmpty){
        showCustomSnackBar("Nhập điện thoại của bạn", title: "Số điện thoại");
      } /*else if(!GetUtils.isEmail(email)){
        showCustomSnackBar("Type in a valid email address ", title: "Valid email address");
      }*/ else if(password.isEmpty){
        showCustomSnackBar("Nhập mật khẩu của bạn", title: "Mật khầu");
      } else if(password.length < 6){
        showCustomSnackBar("Mật khẩu không được ít hơn sáu ký tự", title: "Mật khầu");
      } else {

        authController.login(phone, password).then((status){
          if(status.isSuccess){
            print("Success");
            print(status.isSuccess);
            Get.toNamed(RouteHelper.getInitial());
            //Get.toNamed(RouteHelper.getCartPage());
          } else {
            print(" not Success");
            print(status.isSuccess);
            showCustomSnackBar(status.message);
          }
        });
      }
    }





    return Scaffold(
      backgroundColor: Colors.white,
      body: GetBuilder<AuthController>(builder: (authController){
        return !authController.isLoading
            ? SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            children: [
              SizedBox(height: Dimensions.screenHeight*0.05,),
              Container(
                height: Dimensions.screenHeight*0.25,
                child: Center(
                  child: CircleAvatar(
                    backgroundColor: Colors.white,
                    radius: 80,
                    backgroundImage: AssetImage(
                      "assets/image/logo part 1.png",
                    ),
                  ),
                ),
              ),

              Container(
                margin: EdgeInsets.only(left: Dimensions.width20),
                width: double.maxFinite,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "helo".tr,
                      style: TextStyle(
                        fontSize: Dimensions.font20*3+Dimensions.font20/2,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      "sign_into_your_account".tr,
                      style: TextStyle(
                          fontSize: Dimensions.font20,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey[500]
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: Dimensions.height20,),
              AppTextField(
                textController: phoneController,
                hintText: 'Số điện thoại',
                icon: Icons.phone,
              ),
              SizedBox(height: Dimensions.height20,),
              AppTextField(
                textController: passwordController,
                hintText: 'Mật khẩu',
                icon: Icons.password_outlined,
                isObscure: true,
              ),
              SizedBox(height: Dimensions.height20,),
              Row(
                children: [
                  Expanded(child: Container()),
                  RichText(
                    text: TextSpan(
                      //recognizer: TapGestureRecognizer()..onTap=()=>Get.back(),
                        text: "sign_into_your_account".tr,
                        style: TextStyle(
                            color: Colors.grey[500],
                            fontSize: Dimensions.font20
                        )
                    ),
                  ),
                  SizedBox(width: Dimensions.width20,)
                ],
              ),
              SizedBox(height: Dimensions.screenHeight*0.05,),
              GestureDetector(
                onTap: () {
                  _login(authController);
                },
                child: Container(
                  width: Dimensions.screenWidth/2,
                  height: Dimensions.screenHeight/13,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(Dimensions.radius30),
                    color: AppColors.mainColor,
                  ),
                  child: Center(
                    child: BigText(
                      text: "sign_in".tr,
                      size: Dimensions.font20+Dimensions.font20/2,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              SizedBox(height: Dimensions.height10,),

              RichText(
                text: TextSpan(
                    recognizer: TapGestureRecognizer()..onTap=()=>Get.back(),
                    text: "dont_have_an_account".tr,
                    style: TextStyle(
                        color: Colors.grey[500],
                        fontSize: Dimensions.font20
                    ),
                    children: [
                      TextSpan(
                        recognizer: TapGestureRecognizer()..onTap=()=>Get.to(()=>SignUpPage(),transition: Transition.fade),
                        text: "create".tr,
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.grey[500],
                            fontSize: Dimensions.font16
                        ),
                      )
                    ]
                ),
              ),
            ],
          ),
        )
            : CustomLoader();
      },),
    );
  }
}
