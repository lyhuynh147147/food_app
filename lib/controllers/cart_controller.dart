import 'package:flutter/material.dart';
import 'package:ifood_delivery/models/products_model.dart';
import 'package:get/get.dart';
import '../data/repository/cart_repo.dart';
import '../models/cart_model.dart';
import '../utils/colors.dart';


class CartController extends GetxController{
  final CartRepo cartRepo;
  CartController({required this.cartRepo});
  Map<int, CartModel> _item= {};
  List<CartModel> storageItems = [];

  set setCart(List<CartModel> items){
    for(int i=0; i<storageItems.length; i++){
      _item.putIfAbsent(
          storageItems[i].product!.id,
              ()=>items[i]!
      );
    }
  }

  Map<int, CartModel> get items {
    return _item;
  }

  set setItems(Map<int, CartModel> setItems) {
    _item={};
    _item=setItems;
  }

  List<CartModel> _cartList=[];
  void clearCartList() {
    _cartList = [];
    cartRepo.addToCartList(_cartList);
    update();
  }

  void addToCarts(CartModel cart){
    _cartList.add(cart);
    Get.find<CartRepo>().addToCartList(_cartList);
  }


  List<CartModel> getCartsData(){
    setCart= Get.find<CartRepo>().getCartList();

    return storageItems;
  }

  List<CartModel> get getCarts{
    return items.entries.map((e) {
      return e.value;
    }).toList();

  }

  int _certainItems=0;
  int get certainItems=>_certainItems;

  int get itemCount{
    return _item.length;

  }
  double get totalAmount{
    var total = 0.0;
    _item.forEach((key, cartItem) {
      total += cartItem.price! * cartItem.quantity!;
    });
    return total;
  }

  int get totalItems{
    var total=0;
    _item.forEach((key, value) {
      total +=value.quantity!;

    });
    return total;
  }


  void addItem(Product product, int quantity){
    var totalQuantity = 0;
    if(_item.containsKey(product.id)){
      _item.update(
          product.id,
              (value) {
        totalQuantity = value.quantity!+quantity;
        return CartModel(
          id: value.id,
          name: value.name,
          price: value.price,
          img: value.img,
          quantity: value.quantity! + quantity,
          isExists: true,
          time: DateTime.now().toString(),
          product: product,
        );
      });

      if(totalQuantity<=0){
        _item.remove(product.id);
      }

    } else {
      if(quantity>0){
        _item.putIfAbsent(product.id, () {
          _item.forEach((key, value) {
            print("quantity is s"+ value.quantity.toString());
          });
          return CartModel(
            id: product.id,
            name: product.name,
            price: product.price,
            img: product.img,
            quantity: quantity,
            isExists: true,
            time: DateTime.now().toString(),
            product: product,
          );
        });
      } else {
        Get.snackbar(
          "Item count",
          "You should at least add an item in the cart!",
          backgroundColor: AppColors.mainColor,
          colorText: Colors.white,
        );
      }
    }
    cartRepo.addToCartList(getCarts);
    update();
  }
  void addToCartList(){
    cartRepo.addToCartList(getCarts);

  }

  Future<void> addToHistory() async {
    cartRepo.addToCartHistoryList();
    clear();
  }

  List<CartModel> getCartHistory(){
    return cartRepo.getCartHistoryList();
  }

  bool isExistInCart(Product product){

    if(_item.containsKey(product.id!)){
      _item.forEach((key, value) {
        print(key.toString());
        if(key==product.id){
          value.isExists=true;
        }
      });
      return true;
    }else{
      return false;
    }
  }

  int getQuantity(Product product){
    if(_item.containsKey(product.id!)){
      _item.forEach((key, value) {
        if(key==product.id!){
          _certainItems=int.parse(value.quantity.toString());
        }
      });
      return _certainItems;
    }else{
      return 0;
    }
  }

  void removeItem(int productId){
    _item.remove(productId);
    update();
  }

  void clear(){
    _item = {};
    update();
  }

  void removeCartSharedPreference(){
    cartRepo.removeCartSharedPreference();
  }
}