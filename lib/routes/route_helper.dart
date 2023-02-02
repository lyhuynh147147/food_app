import 'package:ifood_delivery/pages/address/add_address_page.dart';
import 'package:ifood_delivery/pages/cart/cart_page.dart';
import 'package:ifood_delivery/pages/detail/popular_food_detail.dart';
import 'package:ifood_delivery/pages/detail/recommended_food_detail.dart';
import 'package:ifood_delivery/pages/home/home_page.dart';
import 'package:get/get.dart';
import 'package:ifood_delivery/pages/payment/order_successful_page.dart';
import 'package:ifood_delivery/pages/payment/payment_page.dart';
import 'package:ifood_delivery/pages/search/seach_product_page.dart';
import '../controllers/wine_product_controller.dart';
import '../models/order_model.dart';
import '../pages/address/pick_address_map.dart';
import '../pages/auth/sign_in_page.dart';
import '../pages/detail/wine_detail.dart';
import '../pages/language/language_page.dart';
import '../pages/order/order_detail_screen.dart';
import '../pages/splash/splash_page.dart';

class RouteHelper {
  static const String splash = '/splash-page';
  static const String initial = '/';
  static const String popularFood = '/popular-food';
  static const String recommendedFood = '/recommended-food';

  static const String wineDetail = '/wine-detail';
  static const String brandyDetail = '/brandy-detail';
  static const String mixedDetail = '/mixed-detail';
  static const String traditionDetail = '/traditional-detail';
  static const String beerDetail = '/beer-detail';
  static const String otherDetail = '/other-detail';

  /*
  language
   */
  static const String language = '/language';

  static const String cartPage = '/cart-page';
  static const String signIn = '/sign-in';
  static const String signUp='/sign-up';

  static const String addAddress = "/add-address";
  static const String pickAddressMap = "/pick-address";
  static const String payment = '/payment';
  static const String orderSuccess = '/order-successful';

  static const String orderDetails = '/order-details';
  static const String search ='/search';


  static String getSplash() => '$splash';
  static String getInitial() => '$initial';
  static String getPopularFood(int pageId, String page)=>'$popularFood?pageId=$pageId&page=$page';
  //static String getRecommendedFood(int pageId ,String page)=>'$recommendedFood?pageId=$pageId&page=$page';

  static String getWineDetail(int pageId, String page)=>'$wineDetail?pageId=$pageId&page=$page';
  static String getBrandyDetail(int pageId, String page)=>'$brandyDetail?pageId=$pageId&page=$page';
  static String getMixedDetail(int pageId, String page)=>'$mixedDetail?pageId=$pageId&page=$page';
  static String getTraditionalDetail(int pageId, String page)=>'$traditionDetail?pageId=$pageId&page=$page';
  static String getBeerDetail(int pageId, String page)=>'$beerDetail?pageId=$pageId&page=$page';
  static String getOtherDetail(int pageId, String page)=>'$otherDetail?pageId=$pageId&page=$page';


  static String getCartPage(int pageId, String page)=>'$cartPage?id=$pageId&page=$page';
  static String getSignInPage()=>'$signIn';
  static String getAddressPage()=>'$addAddress';
  static String getPickAddressPage(String page, bool canRoute)=>'$pickAddressMap?page=$page&route=${canRoute.toString()}';
  static String getPaymentPage(String id, int userID)=>'$payment?id=$id&userID=$userID';
  static String getOrderSuccessPage(String orderID, String status)=>'$orderSuccess?id=$orderID&status=$status';
  static String getSearchPage()=>'$search';
  static String getLanguagePage(String page) => '$language?page=$page';
  static String getOrderDetailsPage(int orderID) {
    return '$orderDetails?id=$orderID';
  }

  static List<GetPage> routes = [
    GetPage(name: pickAddressMap, page: () {
      PickAddressMap _pickAddress = Get.arguments;
      bool _fromAddress = Get.parameters['page'] == 'add-address';
      return (_fromAddress && _pickAddress == null)
          ? SignInPage()
          : _pickAddress != null ? _pickAddress
          : PickAddressMap(
        fromSignup: Get.parameters['page'] == signUp,
        fromAddress: _fromAddress,
        route: Get.parameters['page']??"",
        canRoute: Get.parameters['route'] == 'true',
      );
    }),

    GetPage(name: initial,
      page: () {
      return HomePage();
      },
      transition: Transition.fade
    ),

    GetPage(name: signIn, page: () {
      return SignInPage();
    },transition: Transition.fadeIn,),

    GetPage(name: popularFood, page: () {
      var pageId = Get.parameters['pageId'];
      var page = Get.parameters['page'];
      return PopularFoodDetail(pageId:int.parse(pageId!), page:page!);
    },
      transition: Transition.fadeIn,
    ),

    // GetPage(
    //   name: recommendedFood,
    //   page: () {
    //   var pageId = Get.parameters['pageId'];
    //   var page = Get.parameters['page'];
    //   return RecommendedFoodDetail(pageId: int.parse(pageId!), page: page!,);
    // },
    //   transition: Transition.fadeIn,
    // ),

    GetPage(name: wineDetail, page: () {
      var pageId = Get.parameters['pageId'];
      var page = Get.parameters['page'];
      var product = Get.find<WineProductController>().wineProductList[int.parse(pageId!)];
      return WineDetail(pageId:int.parse(pageId!), page:page!,product: product,);
    },
      transition: Transition.fadeIn,
    ),

    GetPage(name: beerDetail, page: () {
      var pageId = Get.parameters['pageId'];
      var page = Get.parameters['page'];
      var product = Get.find<WineProductController>().beerProductList[int.parse(pageId!)];
      return WineDetail(pageId:int.parse(pageId!), page:page!,product: product,);
    },
      transition: Transition.fadeIn,
    ),

    GetPage(name: mixedDetail, page: () {
      var pageId = Get.parameters['pageId'];
      var page = Get.parameters['page'];
      var product = Get.find<WineProductController>().mixedProductList[int.parse(pageId!)];
      return WineDetail(pageId:int.parse(pageId!), page:page!,product: product,);
    },
      transition: Transition.fadeIn,
    ),

    GetPage(name: traditionDetail, page: () {
      var pageId = Get.parameters['pageId'];
      var page = Get.parameters['page'];
      var product = Get.find<WineProductController>().traditionalProductList[int.parse(pageId!)];
      return WineDetail(pageId:int.parse(pageId!), page:page!,product: product,);
    },
      transition: Transition.fadeIn,
    ),

    GetPage(name: otherDetail, page: () {
      var pageId = Get.parameters['pageId'];
      var page = Get.parameters['page'];
      var product = Get.find<WineProductController>().otherProductList[int.parse(pageId!)];
      return WineDetail(pageId:int.parse(pageId!), page:page!,product: product,);
    },
      transition: Transition.fadeIn,
    ),
    GetPage(name: brandyDetail, page: () {
      var pageId = Get.parameters['pageId'];
      var page = Get.parameters['page'];
      var product = Get.find<WineProductController>().brandyProductList[int.parse(pageId!)];
      return WineDetail(pageId:int.parse(pageId!), page:page!,product: product,);
    },
      transition: Transition.fadeIn,
    ),


    GetPage(
      name: cartPage,
      page: () {
      return CartPage(pageId:int.parse(Get.parameters['id']!), page:Get.parameters['page']!);
    },
      transition: Transition.fadeIn,
    ),

    GetPage(name: splash, page: () => SplashScreen()),

    GetPage(name: addAddress, page:() {
      return AddAddressPage();
    }),
    
    GetPage(name: payment, page: ()=>PaymentPage(
      orderModel: OrderModel(
        id: int.parse(Get.parameters['id']!),
        userId: int.parse(Get.parameters['userID']!),

      ),
    )),

    GetPage(name: orderSuccess, page: ()=>OrderSuccessPage(
      orderID: Get.parameters['id']!,
      status: Get.parameters["status"].toString().contains("success")?1:0,
    )),
    GetPage(name: search, page: () => SearchPage()),

    GetPage(name: language, page: () => LanguagePage(fromMenu: Get.parameters['page'] == 'update')),

    GetPage(name: orderDetails, page: () {
      return  OrderDetailPage(orderId: int.parse(Get.parameters['id'] ?? '0'), orderModel: null);
    }),



    //GetPage(name: initial, page: () => HomePage()),
    // GetPage(
    //     name: recommendedFood,
    //     page: () {
    //       var pageId = Get.parameters['pageId'];
    //       return RecommendedFoodDetail(
    //         pageId: int.parse(pageId!),
    //       );
    //     }),
    // GetPage(
    //   name: popularFood,
    //   page: () {
    //     var pageId = Get.parameters['pageId'];
    //     var page = Get.parameters['page'];
    //     return PopularFoodDetail(pageId: int.parse(pageId!), page: page!);
    //   },
    //   transition: Transition.fadeIn,
    // ),
    // GetPage(
    //     name: cartPage,
    //     page: () {
    //       return CartPage();
    //     },
    //     transition: Transition.fadeIn),

  ];
}