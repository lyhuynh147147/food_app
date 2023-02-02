import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:ifood_delivery/base/show_custom_snackbar.dart';
import 'package:ifood_delivery/models/signup_body_model.dart';
import 'package:ifood_delivery/utils/colors.dart';
import 'package:ifood_delivery/utils/dimensions.dart';
import 'package:ifood_delivery/widgets/app_text_field.dart';
import 'package:ifood_delivery/widgets/big_text.dart';
import 'package:get/get.dart';

import '../../base/custom_loader.dart';
import '../../controllers/auth_controller.dart';
import '../../routes/route_helper.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var emailController = TextEditingController();
    var passwordController = TextEditingController();
    var nameController = TextEditingController();
    var phoneController = TextEditingController();
    var signUpImages = [
      "t.png",
      "f.png",
      "g.png"
    ];

    void _registration(AuthController authController) {
      //var authController = Get.find<AuthController>();
      String name  = nameController.text.trim();
      String phone = phoneController.text.trim();
      String email = emailController.text.trim();
      String password = passwordController.text.trim();

      if(name.isEmpty){
        showCustomSnackBar("enter_your_first_name".tr, title: "Tên");
      } else if(phone.isEmpty){
        showCustomSnackBar("enter_phone_number".tr, title: "Số điện thoại");
      } else if(email.isEmpty){
        showCustomSnackBar("enter_email_address".tr, title: "Email");
      } else if(!GetUtils.isEmail(email)){
        showCustomSnackBar("enter_a_valid_email_address".tr, title: "Địa chỉ email hợp lệ");
      } else if(password.isEmpty){
        showCustomSnackBar("Nhập mật khẩu của bạn", title: "Mật khẩu");
      } else if(password.length < 6){
        showCustomSnackBar("Mật khẩu không được ít hơn 6 ký tự", title: "Mật khẩu");
      } else {
        showCustomSnackBar("Tạo tài khoản thành công", title: "Thông báo");
        SignUpBody signUpBody = SignUpBody(
          name: name,
          phone: phone,
          email: email,
          password: password,
        );
        authController.registration(signUpBody).then((status){
          if(status.isSuccess){
            print("Success");
            Get.offNamed(RouteHelper.getInitial());
          } else {
            showCustomSnackBar(status.message);
          }
        });
        print(signUpBody.toString());
      }
    }





    return Scaffold(
      backgroundColor: Colors.white,
      body: GetBuilder<AuthController>(builder: (_authController){
        return !_authController.isLoading
            ?SingleChildScrollView(
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
              AppTextField(
                textController: emailController,
                hintText: 'email'.tr,
                icon: Icons.email,
              ),
              SizedBox(height: Dimensions.height20,),
              AppTextField(
                textController: passwordController,
                hintText: 'password'.tr,
                icon: Icons.password_outlined,
                isObscure: true,
              ),
              SizedBox(height: Dimensions.height20,),
              AppTextField(
                textController: nameController,
                hintText: 'first_name'.tr,
                icon: Icons.person,
              ),
              SizedBox(height: Dimensions.height20,),
              AppTextField(
                textController: phoneController,
                hintText: 'phone'.tr,
                icon: Icons.phone,
              ),
              SizedBox(height: Dimensions.height20,),

              GestureDetector(
                onTap: () {
                  _registration(_authController);
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
                      text: "sign_up".tr,
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
                    text: "have_an_account".tr,
                    style: TextStyle(
                        color: Colors.grey[500],
                        fontSize: Dimensions.font20
                    )
                ),
              ),
              SizedBox(height: Dimensions.screenHeight*0.05,),
              RichText(
                text: TextSpan(
                  recognizer: TapGestureRecognizer()..onTap=()=>Get.back(),
                  text: "sign_up_method".tr,
                  style: TextStyle(
                      color: Colors.grey[500],
                      fontSize: Dimensions.font20
                  ),
                ),
              ),
              Wrap(
                children: List.generate(3, (index) => Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CircleAvatar(
                    radius: Dimensions.radius30,
                    backgroundImage: AssetImage(
                        "assets/image/"+signUpImages[index]
                    ),
                  ),
                )),
              )
            ],
          ),
        )
            : const CustomLoader();
      },),
    );


  }
}
