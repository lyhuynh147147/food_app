import 'package:ifood_delivery/data/api/api_client.dart';
import 'package:get/get.dart';
import 'package:ifood_delivery/utils/app_constants.dart';


class WineProductRepo extends GetxService {
  final ApiClient apiClient;
  WineProductRepo({required this.apiClient});

  Future getWineProductList() async {
    return await apiClient.getData(AppConstants.BASE_URL+AppConstants.WINE_PRODUCT_URI);
  }

  Future getBrandyProductList() async {
    return await apiClient.getData(AppConstants.BASE_URL+AppConstants.BRANDY_PRODUCT_URI);
  }

  Future getMixedProductList() async {
    return await apiClient.getData(AppConstants.BASE_URL+AppConstants.MIXED_PRODUCT_URI);
  }

  Future getTraditionalProductList() async {
    return await apiClient.getData(AppConstants.BASE_URL+AppConstants.TRADITIONAL_PRODUCT_URI);
  }

  Future getBeerProductList() async {
    return await apiClient.getData(AppConstants.BASE_URL+AppConstants.BEER_PRODUCT_URI);
  }

  Future getOtherProductList() async {
    return await apiClient.getData(AppConstants.BASE_URL+AppConstants.OTHER_PRODUCT_URI);
  }
}