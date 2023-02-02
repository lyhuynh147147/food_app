import 'dart:async';

import 'package:flutter/material.dart';
import 'package:ifood_delivery/controllers/auth_controller.dart';
import 'package:ifood_delivery/controllers/popular_product_controller.dart';
import 'package:ifood_delivery/controllers/wine_product_controller.dart';
import 'package:ifood_delivery/routes/route_helper.dart';
import 'package:get/get.dart';
import 'package:ifood_delivery/utils/dimensions.dart';


class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with TickerProviderStateMixin{

  late Animation<double> animation;
  late AnimationController controller;

  Future<void> _loadResource() async {
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
    Get.find<AuthController>().updateToken();
    _loadResource();
    controller =  new AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2)
    )..forward();
    animation = new CurvedAnimation(
      parent: controller,
      curve: Curves.linear,
    );

    Timer(
      const Duration(seconds: 3),
        ()=>Get.offNamed(RouteHelper.getInitial())
    );

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ScaleTransition(
            scale: animation,
            child: Center(
              child: Image.asset(
                "assets/image/logo part 1.png",
                width: Dimensions.splashImg,),
            ),
          ),
        ],
      ),
    );
  }
}
