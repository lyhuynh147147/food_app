import 'package:ifood_delivery/data/api/api_client.dart';
import 'package:get/get.dart';
import 'package:ifood_delivery/utils/app_constants.dart';


class PopularProductRepo extends GetxService {
  final ApiClient apiClient;
  PopularProductRepo({required this.apiClient});

  Future getPopularProductList() async {
    return await apiClient.getData(AppConstants.BASE_URL+AppConstants.POPULAR_PRODUCT_URI);
  }
}