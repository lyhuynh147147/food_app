import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:ifood_delivery/controllers/location_controller.dart';
import 'package:ifood_delivery/controllers/notification_controller.dart';
import 'package:ifood_delivery/controllers/order_controller.dart';
import 'package:ifood_delivery/controllers/popular_product_controller.dart';
import 'package:ifood_delivery/controllers/search_product_controller.dart';
import 'package:ifood_delivery/controllers/splash_controller.dart';
import 'package:ifood_delivery/controllers/user_controller.dart';
import 'package:ifood_delivery/data/repository/auth_repo.dart';
import 'package:ifood_delivery/data/repository/order_repo.dart';
import 'package:ifood_delivery/data/repository/popular_product_repo.dart';
import 'package:ifood_delivery/utils/app_constants.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../controllers/auth_controller.dart';
import '../controllers/cart_controller.dart';
import '../controllers/localization_controller.dart';
import '../controllers/wine_product_controller.dart';
import '../data/api/api_client.dart';
import '../data/repository/cart_repo.dart';
import '../data/repository/location_repo.dart';
import '../data/repository/notification_repo.dart';
import '../data/repository/search_product_repo.dart';
import '../data/repository/splash_repo.dart';
import '../data/repository/user_repo.dart';
import '../data/repository/wine_product_repo.dart';
import '../models/language_model.dart';

Future<Map<String, Map<String, String>>> init() async {
  final sharedPreferences = await SharedPreferences.getInstance();

  Get.lazyPut(() => sharedPreferences);

  //api client
  Get.lazyPut(() => ApiClient(appBaseUrl: AppConstants.BASE_URL, sharedPreferences: Get.find()));

  Get.lazyPut(() => SplashRepo(sharedPreferences: Get.find(), apiClient: Get.find()));

  Get.lazyPut(() => AuthRepo(apiClient: Get.find(), sharedPreferences: Get.find()));
  Get.lazyPut(() => UserRepo(apiClient: Get.find()));
  //repos
  // api client
  Get.lazyPut(() => PopularProductRepo(apiClient: Get.find()));
  //Get.lazyPut(() => RecommendedProductRepo(apiClient: Get.find()));
  Get.lazyPut(() => WineProductRepo(apiClient: Get.find()));

  Get.lazyPut(() => CartRepo(sharedPreferences: Get.find(),));
  Get.lazyPut(() => OrderRepo(apiClient: Get.find(), sharedPreferences: Get.find()));
  Get.lazyPut(() => LocationRepo(apiClient: Get.find(), sharedPreferences: Get.find(),));
  Get.lazyPut(() => NotificationRepo(apiClient: Get.find(), sharedPreferences: Get.find()));
  Get.lazyPut(() => SearchProductRepo(apiClient: Get.find(), sharedPreferences: Get.find()));




  //controllers

  Get.lazyPut(() => SplashController(splashRepo: Get.find()));
  Get.lazyPut(() => AuthController(authRepo: Get.find()));
  Get.lazyPut(() => UserController(userRepo: Get.find()));
  Get.lazyPut(() => PopularProductController(popularProductRepo: Get.find()));
  //Get.lazyPut(() => RecommendedProductController(recommendedProductRepo: Get.find()));
  Get.lazyPut(() => WineProductController(wineProductRepo: Get.find()));
  Get.lazyPut(() => LocalizationController(sharedPreferences: Get.find()));

  Get.lazyPut(() => CartController(cartRepo: Get.find()));
  Get.lazyPut(() => LocationController(locationRepo: Get.find()));
  Get.lazyPut(() => OrderController(orderRepo: Get.find()));
  Get.lazyPut(() => NotificationController(notificationRepo: Get.find()));
  Get.lazyPut(() => SearchProductController(searchProductRepo: Get.find()));

  // Retrieving localized data
  Map<String, Map<String, String>> _languages = Map();
  for(LanguageModel languageModel in AppConstants.languages) {
    String jsonStringValues = await rootBundle.loadString('assets/language/${languageModel.languageCode}.json');
    Map<String, dynamic> _mappedJson = json.decode(jsonStringValues);
    Map<String, String> _json = Map();
    _mappedJson.forEach((key, value) {
      _json[key] = value.toString();
    });
    _languages['${languageModel.languageCode}_${languageModel.countryCode}'] = _json;
  }
  return _languages;

}