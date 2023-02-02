import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ifood_delivery/base/show_custom_snackbar.dart';
import 'package:ifood_delivery/controllers/splash_controller.dart';
import 'package:ifood_delivery/controllers/user_controller.dart';
import 'package:ifood_delivery/data/api/api_checker.dart';
import 'package:ifood_delivery/data/repository/order_repo.dart';
import 'package:ifood_delivery/models/order_model.dart';
import 'package:ifood_delivery/models/response_model.dart';
import 'package:ifood_delivery/routes/route_helper.dart';
import 'package:http/http.dart' as http;
import '../models/order_detail_model.dart';
import '../models/place_order_model.dart';

class OrderController extends GetxController implements GetxService {
  final OrderRepo orderRepo;
  OrderController({required this.orderRepo});

  late List<OrderDetailsModel> _orderDetails;
  late List<OrderModel> _runningOrderList;
  late List<OrderModel> _historyOrderList;
  List<OrderDetailsModel> get orderDetails => _orderDetails;
  int _paymentMethodIndex = 0;
  OrderModel? _trackModel;
  ResponseModel? _responseModel;
  bool _isLoading = false;
  bool _showCancelled = false;
  String _orderType = 'delivery'.tr;

  double? _distance;

  List<OrderModel> get runningOrderList => _runningOrderList;
  List<OrderModel> get historyOrderList => _historyOrderList;
  int get paymentMethodIndex => _paymentMethodIndex;
  OrderModel? get trackModel => _trackModel;
  ResponseModel? get responseModel => _responseModel;
  bool get isLoading => _isLoading;
  bool get showCancelled => _showCancelled;
  String get orderType => _orderType;

  double get distance => _distance??0.0;
  String? _foodNote=" ";
  String? get foodNote =>_foodNote;


  Future<List<OrderDetailsModel>> getOrderDetails(String orderID) async {

    _orderDetails = [];
    _isLoading = true;
    _showCancelled = false;

    Response response = await orderRepo.getOrderDetails(orderID);
    _isLoading = false;
    if (response.statusCode == 200) {
      print("getOrderDetails = true");
      _orderDetails = [];
      response.body.forEach((orderDetail) => _orderDetails.add(OrderDetailsModel.fromJson(orderDetail)));
    } else {
      ApiChecker.checkApi(response);
    }
    update();
    return _orderDetails;
  }


  Future<ResponseModel?> trackOrder(String orderID, OrderModel? orderModel, bool fromTracking) async {
    _trackModel = null;
    _responseModel = null;
    if(!fromTracking) {
      _orderDetails = [];
    }
    _showCancelled = false;
    if(orderModel == null) {
      _isLoading = true;
      Response response = await orderRepo.trackOrder(orderID);
      if (response.statusCode == 200) {
        print("trackOrder = true");
        _trackModel = OrderModel.fromJson(response.body);
        _responseModel = ResponseModel(true, response.body.toString());
      } else {
        _responseModel = ResponseModel(false, response.statusText!);
        ApiChecker.checkApi(response);
      }
      _isLoading = false;
      update();
    }else {
      _trackModel = orderModel;
      _responseModel = ResponseModel(true, 'Successful');
    }
    return _responseModel;
  }



  Future<void> placeOrder(PlaceOrderBody placeOrder, Function callback) async {
    _isLoading = true;
    //update();

    http.Response response = await orderRepo.placeOrder(placeOrder);

    print("sadsad"+placeOrder.toString());
    if (response.statusCode == 200) {
      Map json = jsonDecode(response.body);

      _isLoading = false;
      String message = json['message'];
      String orderID = json['order_id'].toString();
      callback(true, message, orderID);
      print('-------- Order placed successfully $orderID ----------');
      print(message);
      print("placeOrder = true");
    } else {
      print('My status is '+response.statusCode!.toString());
      callback(false, response.statusCode!.toString(), '-1');
    }
    //_isLoading = false;
    update();
  }


  Future<void> getOrderList() async {
    _isLoading=true;
    Response response = await orderRepo.getOrderList();
    print("Get order list "+response.statusCode.toString());
    if (response.statusCode == 200) {
      _runningOrderList = [];
      _historyOrderList = [];
      response.body.forEach((order) {
        OrderModel orderModel = OrderModel.fromJson(order);
        if(orderModel.orderStatus == 'chưa giải quyết'
            || orderModel.orderStatus == 'accepted'
            || orderModel.orderStatus == 'đã xác nhận'
            || orderModel.orderStatus == 'processing'
            || orderModel.orderStatus == 'handover'
            || orderModel.orderStatus == 'picked_up') {
          _runningOrderList.add(orderModel);
        }else {
          _historyOrderList.add(orderModel);
        }
      });

      print("getOrderList = true");
    }else{
      _runningOrderList = [];
      _historyOrderList = [];
    }
    _isLoading=false;
    print("The length of the orders"+_runningOrderList.length.toString());
    print("The length of the orders"+_historyOrderList.length.toString());

    update();
  }


  void setPaymentMethod(int index) {
    _paymentMethodIndex = index;
    update();
  }

  void stopLoader() {
    _isLoading = false;
    update();
  }
  //
  void clearPrevData() {

    _paymentMethodIndex = Get.find<SplashController>().configModel!.cashOnDelivery! ? 0 :1;

    _distance = null;
  }

  void cancelOrder(int orderID) async {
    _isLoading = true;
    update();
    http.Response response = await orderRepo.cancelOrder(orderID.toString());
    _isLoading = false;
    Get.back();
    if (response.statusCode == 200) {
      late OrderModel orderModel;
      print("cancelOrder = true");
      for(OrderModel order in _runningOrderList) {
        if(order.id == orderID) {
          orderModel = order;
          break;
        }
      }
      _runningOrderList.remove(orderModel);
      _showCancelled = true;
      //showCustomSnackBar(response.body['message'], isError: false);
      Get.snackbar("message", "Error");
    } else {
      print(response.statusCode);
    }
    update();
  }

  void setOrderType(String type, {bool notify = true}) {
    _orderType = type;
    if(notify) {
      update();
    }
  }


  void setFoodNote(String note){
    _foodNote=note;
    update();
  }






}