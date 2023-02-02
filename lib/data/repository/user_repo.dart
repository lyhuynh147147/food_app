import 'package:get/get.dart';
import 'package:ifood_delivery/data/api/api_client.dart';
import 'package:ifood_delivery/utils/app_constants.dart';

class UserRepo{
  final ApiClient apiClient;
  UserRepo({required this.apiClient});
  Future getUserInfo() async {
    return await apiClient.getData(AppConstants.BASE_URL+AppConstants.USER_INFO_URI);
  }
}