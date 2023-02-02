import 'dart:convert';

import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:ifood_delivery/controllers/cart_controller.dart';
import 'package:ifood_delivery/models/products_model.dart';
import 'package:http/http.dart' as http;
import 'package:ifood_delivery/utils/colors.dart';

import '../data/repository/wine_product_repo.dart';
import '../models/cart_model.dart';

class WineProductController extends GetxController  {
  final WineProductRepo wineProductRepo;
  WineProductController({
    required this.wineProductRepo,
  });

  List<Product> _wineProductList = [] ;
  List<Product> _brandyProductList = [] ;
  List<Product> _mixedProductList = [] ;
  List<Product> _traditionalProductList = [] ;
  List<Product> _beerProductList = [] ;
  List<Product> _otherProductList = [] ;
  List<Product> get wineProductList => _wineProductList;
  List<Product> get brandyProductList => _brandyProductList;
  List<Product> get mixedProductList => _mixedProductList;
  List<Product> get traditionalProductList => _traditionalProductList;
  List<Product> get beerProductList => _beerProductList;
  List<Product> get otherProductList => _otherProductList;
  late CartController _cart;



  bool _isLoaded = false;
  bool get isloaded => _isLoaded;

  int _quantity = 0;
  int get quantity => _quantity;

  int _inCartItems = 0;
  int get inCartItem => _inCartItems+_quantity;

  Future<void> getWineProductList() async {

    http.Response response = await wineProductRepo.getWineProductList();
    print(response.statusCode);

    if(response.statusCode == 200) {
      _wineProductList =  [];
      _wineProductList.addAll(ProductModel.fromJson(jsonDecode(response.body)).products);
      _isLoaded = true;
      update();
    }else {
      print("Error " + response.statusCode.toString());
    }
  }

  Future<void> getBrandyProductList() async {

    http.Response response = await wineProductRepo.getBrandyProductList();

    print(response.statusCode);

    if(response.statusCode == 200) {
      _brandyProductList =  [];
      _brandyProductList.addAll(ProductModel.fromJson(jsonDecode(response.body)).products);
      _isLoaded = true;
      update();
    }else {
      print("Error " + response.statusCode.toString());
    }
  }

  Future<void> getMixedProductList() async {

    http.Response response = await wineProductRepo.getMixedProductList();

    print(response.statusCode);

    if(response.statusCode == 200) {
      _mixedProductList =  [];
      _mixedProductList.addAll(ProductModel.fromJson(jsonDecode(response.body)).products);
      _isLoaded = true;
      update();
    }else {
      print("Error " + response.statusCode.toString());
    }
  }

  Future<void> getTraditionalProductList() async {

    http.Response response = await wineProductRepo.getTraditionalProductList();

    print(response.statusCode);

    if(response.statusCode == 200) {
      _traditionalProductList =  [];
      _traditionalProductList.addAll(ProductModel.fromJson(jsonDecode(response.body)).products);
      _isLoaded = true;
      update();
    }else {
      print("Error " + response.statusCode.toString());
    }
  }

  Future<void> getBeerProductList() async {

    http.Response response = await wineProductRepo.getBeerProductList();

    print(response.statusCode);

    if(response.statusCode == 200) {
      _beerProductList =  [];
      _beerProductList.addAll(ProductModel.fromJson(jsonDecode(response.body)).products);
      _isLoaded = true;
      update();
    }else {
      print("Error " + response.statusCode.toString());
    }
  }

  Future<void> getOtherProductList() async {

    http.Response response = await wineProductRepo.getOtherProductList();

    print(response.statusCode);

    if(response.statusCode == 200) {
      _otherProductList =  [];
      _otherProductList.addAll(ProductModel.fromJson(jsonDecode(response.body)).products);
      _isLoaded = true;
      update();
    }else {
      print("Error " + response.statusCode.toString());
    }
  }


  void showBottomLoader() {
    _isLoaded = true;
    update();
  }

  void setQuantity(bool isIncrement, Product product){
    if(isIncrement) {
      print("increment");
      _quantity = checkQuantity(_quantity + 1);
      print("number og item "+_quantity.toString());
    } else {
      _quantity = checkQuantity(_quantity - 1);
      print("decrement "+_quantity.toString());
    }
    update();
  }

  int checkQuantity(int quantity ){
    if((_inCartItems+quantity)<0){
      Get.snackbar(
        "item_count".tr,
        "you_can't_reduce_more".tr,
        backgroundColor: AppColors.mainColor,
        colorText: Colors.white,
      );
      if(_inCartItems>0){
        _quantity = -_inCartItems;
        return _quantity;
      }
      return 0;
    } else if((_inCartItems+quantity) > 99) {
      Get.snackbar(
        "item_count".tr,
        "you_can't_add_more".tr,
        backgroundColor: AppColors.mainColor,
        colorText: Colors.white,
      );
      return 99;
    } else {
      return quantity;
    }
  }

  void initProduct(Product product, int pageId, CartController cart){
    _quantity = 0;
    _inCartItems = 0;
    _cart = cart;
    var exist = false;
    exist = _cart.isExistInCart(product);
    if(exist){
      _inCartItems = _cart.getQuantity(product);
    }else{
      _inCartItems=0;
    }
  }

  void addItem(Product product){
    print(product.quantity);
    if (_quantity == 0) {
      Get.snackbar("item_count".tr, "add_some_quantity".tr,
          backgroundColor: AppColors.mainColor, colorText: Colors.white);
    }/**/ if (_quantity > product.quantity) {
      Get.snackbar("item_count".tr, "quantity_not_enough".tr,
          backgroundColor: AppColors.mainColor, colorText: Colors.white);/**/
    } else {
      _cart.addItem(product, _quantity);
      _quantity = 0;
      _inCartItems= _cart.getQuantity(product);
      _cart.items.forEach((key, value) {
        print("The id is "+ value.id.toString()+ "The quantity is "+value.quantity.toString());
      });
    }



    update();

  }

  int get totalItems{
    return _cart.totalItems;
  }

  List<CartModel> get getItems{
    return _cart./*getItems*/getCarts;
  }
  List<Product> _items = [];

  List<Product> get items{
    return [..._items];
  }
  Product findProductById(int id){
    return _items.firstWhere((element) => element.id == id);
  }
}