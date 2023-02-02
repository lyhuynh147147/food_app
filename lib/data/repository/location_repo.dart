import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:ifood_delivery/data/api/api_client.dart';
import 'package:ifood_delivery/models/address_model.dart';
import 'package:ifood_delivery/utils/app_constants.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/response/response.dart';

class LocationRepo {
  final ApiClient apiClient;
  final SharedPreferences sharedPreferences;
  LocationRepo({required this.apiClient, required this.sharedPreferences,});

  Future getAddressFromGeocode(LatLng latlng) async {
    return await apiClient.getData('${AppConstants.BASE_URL+AppConstants.GEOCODE_URI}'
        '?lat=${latlng.latitude}&lng=${latlng.longitude}'
    );
  }

  String getUserAddress() {
    return sharedPreferences.getString(AppConstants.USER_ADDRESS)??"";
  }

  Future addAddress(AddressModel addressModel) async {
    return await apiClient.postData(
      AppConstants.BASE_URL + AppConstants.ADD_USER_ADDRESS,
      addressModel.toJson()
    );
  }

  Future getAllAddress() async {
    return await apiClient.getData2(AppConstants.ADDRESS_LIST_URI);
  }

  Future<bool> saveUserAddress(String address) async {
    apiClient.updateHeader(sharedPreferences.getString(AppConstants.TOKEN)!);
    return await sharedPreferences.setString(AppConstants.USER_ADDRESS, address);
  }

  Future getZone(String lat, String lng) async {
    return await apiClient.getData('${AppConstants.BASE_URL+AppConstants.ZONE_URI}?lat=$lat&lng=$lng');
  }

  Future updateAddress(AddressModel addressModel, int addressId) async {
    return await apiClient.postData('${AppConstants.BASE_URL+AppConstants.UPDATE_ADDRESS_URI}$addressId', addressModel.toJson());
  }

  Future searchLocation(String text) async {
    return await apiClient.getData2('${AppConstants.SEARCH_LOCATION_URI}?search_text=$text');
  }

  Future<Response> getPlaceDetails(String placeID) async {
    return await apiClient.getData2('${AppConstants.PLACE_DETAILS_URI}?placeid=$placeID');
  }

}