import 'package:ifood_delivery/utils/app_constants.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:get/get.dart';
import '../api/api_client.dart';

class SearchProductRepo{
  final ApiClient apiClient;
  final SharedPreferences sharedPreferences;
  SearchProductRepo({required this.apiClient, required this.sharedPreferences});

  Future getSearchData(String query) async {
    return await apiClient.getData2('${AppConstants.SEARCH_URI}?name=$query');
  }

}