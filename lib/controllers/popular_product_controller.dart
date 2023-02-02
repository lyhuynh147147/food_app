import 'dart:convert';

import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:ifood_delivery/controllers/cart_controller.dart';
import 'package:ifood_delivery/data/repository/popular_product_repo.dart';
import 'package:ifood_delivery/models/products_model.dart';
import 'package:http/http.dart' as http;
import 'package:ifood_delivery/utils/colors.dart';

import '../models/cart_model.dart';

class PopularProductController extends GetxController  {
  final PopularProductRepo popularProductRepo;
  PopularProductController({
    required this.popularProductRepo,
  });

  List<Product> _popularProductList = [] ;
  List<Product> get popularProductList => _popularProductList;
  late CartController _cart;



  bool _isLoaded = false;
  bool get isloaded => _isLoaded;

  int _quantity = 0;
  int get quantity => _quantity;

  int _inCartItems = 0;
  int get inCartItem => _inCartItems+_quantity;

  Future<void> getPopularProductList() async {

    http.Response response = await popularProductRepo.getPopularProductList();
    if(response.statusCode == 200) {
      _popularProductList =  [];
      _popularProductList.addAll(ProductModel.fromJson(jsonDecode(response.body)).products);
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
      _quantity = checkQuantity(_quantity + 1);
    } else {
      _quantity = checkQuantity(_quantity - 1);
    }
    update();
  }

  int checkQuantity(int quantity){
    if((_inCartItems+quantity)<0){
      Get.snackbar(
        "Item count",
        "You can't reduce more",
        backgroundColor: AppColors.mainColor,
        colorText: Colors.white,
      );
      if(_inCartItems>0){
        _quantity = -_inCartItems;
        return _quantity;
      }
      return 0;
    } else if((_inCartItems+quantity) > 20) {
      Get.snackbar(
        "Item count",
        "You can't add more",
        backgroundColor: AppColors.mainColor,
        colorText: Colors.white,
      );
      return 20;
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
      _cart.addItem(product, _quantity);
      _quantity = 0;
      _inCartItems= _cart.getQuantity(product);
    update();

  }

  int get totalItems{
    return _cart.totalItems;
  }

  List<CartModel> get getItems{
    return _cart.getCarts;
  }
  List<Product> _items = [];

  List<Product> get items{
    return [..._items];
  }
  Product findProductById(int id){
    return _items.firstWhere((element) => element.id == id);
  }


}