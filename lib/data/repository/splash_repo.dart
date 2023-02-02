import 'package:get/get.dart' ;

import 'package:http/http.dart' as http;

import 'package:shared_preferences/shared_preferences.dart';

import '../../utils/app_constants.dart';
import '../api/api_client.dart';

class SplashRepo {
  ApiClient apiClient;
  final SharedPreferences sharedPreferences;
  SplashRepo({required this.sharedPreferences, required this.apiClient});

  Future getConfigData() async {

    http.Response _response = await apiClient.getData(AppConstants.BASE_URL+AppConstants.CONFIG_URI);
    return _response;
  }

  Future<bool> initSharedData() {

    if(!sharedPreferences.containsKey(AppConstants.CART_LIST)) {
      sharedPreferences.setStringList(AppConstants.CART_LIST, []);
    }
    if(!sharedPreferences.containsKey(AppConstants.INTRO)) {
      sharedPreferences.setBool(AppConstants.INTRO, true);
    }
    return Future.value(true);
  }

  bool? showIntro() {
    return sharedPreferences.getBool(AppConstants.INTRO);
  }

}