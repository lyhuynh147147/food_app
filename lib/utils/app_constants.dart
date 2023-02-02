
import 'package:ifood_delivery/models/language_model.dart';
import 'package:ifood_delivery/utils/images.dart';

class AppConstants {
  static const String APP_NAME = "DBFood";
  static const int APP_VERSION = 1;
  static const String BASE_URL = "http://127.0.0.1:8000";
  static const String POPULAR_PRODUCT_URI = "/api/v1/products/popular";
  static const String RECOMMENDED_PRODUCT_URI = "/api/v1/products/recommended";
  ///wine
  static const String WINE_PRODUCT_URI = "/api/v1/products/wine";

  static const String BRANDY_PRODUCT_URI = "/api/v1/products/brandy";

  static const String MIXED_PRODUCT_URI = "/api/v1/products/mixed-wine";

  static const String TRADITIONAL_PRODUCT_URI = "/api/v1/products/traditional";

  static const String BEER_PRODUCT_URI = "/api/v1/products/beer";

  static const String OTHER_PRODUCT_URI = "/api/v1/products/other";
  ///
  //static const String IMAGE_UPLOADS_URL = "http://mvs.bslmeiyu.com/uploads/";
  static const String UPLOAD_URL = '/uploads/';
  static const String DRINKS_URI = "/api/v1/products/drinks";

  //auth end points
  static const String REGISTRATION_URI ="/api/v1/auth/register";
  static const String LOGIN_URI ="/api/v1/auth/login";
  static const String USER_INFO_URI ="/api/v1/customer/info";
  //new
  static const String USER_ADDRESS ="user_address";
  static const String ADD_USER_ADDRESS ="/api/v1/customer/address/add";
  static const String ADDRESS_LIST_URI ="/api/v1/customer/address/list";
  static const String UPDATE_ADDRESS_URI = '/api/v1/customer/address/update/';


  static const String GEOCODE_URI='/api/v1/config/geocode-api';
  static const String ZONE_URI= '/api/v1/config/get-zone-id';

  static const String TOKEN = "";
  static const String PHONE = "";
  static const String PASSWORD = "";

  static const String CART_LIST = 'cart-list';
  static const String CART_HISTORY_LIST = 'cart-history-list';

///


  static const String REGISTER_URI = '/api/v1/auth/register';
  static const String TOPIC = 'all_zone_customer';
  static const String ZONE_ID = 'zoneId';
  static  String UPLOADS_URL = BASE_URL+'/uploads/';
  static const String SEARCH_URI = '/api/v1/products/search';
  static const String USER_PASSWORD = 'user_password';
  static const String USER_NUMBER = 'user_number';
  static const String USER_COUNTRY_CODE = 'user_country_code';
  static const String UPDATE_ACCOUNT_URI = '/api/v1/customer/update-profile';
  static const String CUSTOMER_INFO_URI = '/api/v1/customer/info';
  static const String REMOVE_ADDRESS_URI = '/api/v1/customer/address/delete?address_id=';
  static const String ADD_ADDRESS_URI = '/api/v1/customer/address/add';
  static const String PLACE_DETAILS_URI = '/api/v1/config/place-api-details';
  static const String PLACE_ORDER_URI = '/api/v1/customer/order/place';

  static const String RECOMMENDED_PRODUCT_URI_TEST = '/api/v1/products/test';
  static const String ORDER_LIST_URI = '/api/v1/customer/order/list';
  static const String ORDER_CANCEL_URI = '/api/v1/customer/order/cancel';
  static const String COD_SWITCH_URL = '/api/v1/customer/order/payment-method';
  static const String ORDER_DETAILS_URI = '/api/v1/customer/order/details?order_id=';
  static const String TRACK_URI = '/api/v1/customer/order/track?order_id=';
  static const String SEARCH_LOCATION_URI = '/api/v1/config/place-api-autocomplete';
  static const String CONFIG_URI = '/api/v1/config';

  /*
  Localization data
   */
  static const String COUNTRY_CODE = 'country_code';
  static const String LANGUAGE_CODE = 'language_code';
  static const String INTRO = 'introduction';

  /*
  Notification
   */
  static const String NOTIFICATION_URI = '/api/v1/customer/notifications';
  static const String NOTIFICATION = 'notification';
  static const String NOTIFICATION_COUNT = 'notification_count';
  static const String TOKEN_URI = '/api/v1/customer/cm-firebase-token';

  static List<LanguageModel> languages = [
    LanguageModel(imageUrl: Images.bengali, languageName: 'VietNam', countryCode: 'BD', languageCode: 'vn'),
    LanguageModel(imageUrl: Images.english, languageName: 'English', countryCode: 'US', languageCode: 'en'),

  ];


}