import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/response/response.dart';
import 'package:ifood_delivery/models/place_order_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../utils/app_constants.dart';
import '../api/api_client.dart';


class OrderRepo {
  final ApiClient apiClient;
  final SharedPreferences sharedPreferences;
  OrderRepo({required this.apiClient, required this.sharedPreferences});

  Future placeOrder(PlaceOrderBody placeOrder) async {
    return await apiClient.postData(AppConstants.BASE_URL+AppConstants.PLACE_ORDER_URI, placeOrder.toJson());
  }
  Future placeOrder2(PlaceOrderBody placeOrder) async {
    return await apiClient.postData2(AppConstants.PLACE_ORDER_URI, placeOrder.toJson());
  }

  Future getOrderList() async {
    return await apiClient.getData2(AppConstants.ORDER_LIST_URI);
  }

  //
  Future getOrderDetails(String orderID) async {
    return await apiClient.getData2('${AppConstants.ORDER_DETAILS_URI}$orderID');
  }

  Future cancelOrder(String orderID) async {
    return await apiClient.postData(AppConstants.BASE_URL+AppConstants.ORDER_CANCEL_URI, {'_method': 'put', 'order_id': orderID});
  }

  Future trackOrder(String orderID) async {
    return await apiClient.getData2('${AppConstants.TRACK_URI}$orderID');
  }

}