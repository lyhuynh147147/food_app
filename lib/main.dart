import 'dart:io';
import 'package:firebase_core/firebase_core.dart';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:ifood_delivery/controllers/cart_controller.dart';
import 'package:ifood_delivery/controllers/popular_product_controller.dart';
import 'package:ifood_delivery/controllers/wine_product_controller.dart';
import 'package:ifood_delivery/pages/auth/sign_in_page.dart';
import 'package:ifood_delivery/pages/home/main_food_page.dart';
import 'package:ifood_delivery/pages/splash/splash_page.dart';
import 'package:ifood_delivery/routes/route_helper.dart';
import 'package:ifood_delivery/utils/app_constants.dart';
import 'package:ifood_delivery/utils/colors.dart';
import 'package:ifood_delivery/utils/message.dart';
import 'package:ifood_delivery/utils/scroll_behavior.dart';
import 'controllers/localization_controller.dart';
import 'helper/dependencies.dart' as dep;
import 'helper/helper_notifications.dart';

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

Future<dynamic> myBackgroundMessageHandler(RemoteMessage message) async {
  print("onBackground: ${message.notification?.title}/${message.notification?.body}/${message.notification?.titleLocKey}");
  // var androidInitialize = new AndroidInitializationSettings('notification_icon');
  // var iOSInitialize = new IOSInitializationSettings();
  // var initializationsSettings = new InitializationSettings(android: androidInitialize, iOS: iOSInitialize);
  // FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
  // flutterLocalNotificationsPlugin.initialize(initializationsSettings);
  // NotificationHelper.showNotification(message, flutterLocalNotificationsPlugin, true);
}
final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  HttpOverrides.global = MyHttpOverrides();
  await Firebase.initializeApp();
  Map<String, Map<String, String>> _languages = await dep.init();

  await dep.init();

  try {
    if (GetPlatform.isMobile) {
      final RemoteMessage? remoteMessage = await FirebaseMessaging.instance.getInitialMessage();
      await HelperNotification.initialize(flutterLocalNotificationsPlugin);
      FirebaseMessaging.instance.requestPermission();
    }
  } catch (e) {
    if (kDebugMode) {
      print(e.toString());
    }
  }

  runApp(MyApp(languages: _languages));
}

class MyApp extends StatelessWidget {
  final Map<String, Map<String, String>> languages;

  MyApp({super.key, required this.languages});
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    Get.find<CartController>()./*getCartData()*/getCartsData();
    //Get.find<PopularProductController>().getPopularProductList();
    //Get.find<RecommendedProductController>().getRecommendedProductList();
    return GetBuilder<PopularProductController>(builder: (_){
      //return GetBuilder<RecommendedProductController>(builder: (_){
        return GetBuilder<LocalizationController>(builder: (localizationController){
          return GetBuilder<WineProductController>(builder: (_){
            return GetMaterialApp(
              debugShowCheckedModeBanner: false,
              scrollBehavior: AppScrollBehavior(),
              title: 'Flutter Demo',
              initialRoute: RouteHelper.getSplash(),
              getPages: RouteHelper.routes,
              theme: ThemeData(
                primaryColor: AppColors.mainColor,
                fontFamily: "Lato",
              ),
              locale: localizationController.locale,
              translations: Messages(languages: languages),
              fallbackLocale: Locale(AppConstants.languages[0].languageCode, AppConstants.languages[0].countryCode),
              defaultTransition: Transition.topLevel,
              //home: SplashScreen(),
              //home: SignInPage(),
            );
          });
        });
      //});
    });
  }
}

