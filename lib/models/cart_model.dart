import 'package:ifood_delivery/models/products_model.dart';

class CartModel {
  int? id;
  String? name;
  double? price;
  String? img;
  int? quantity;
  bool? isExists;
  String? time;
  Product? product;

  CartModel({
    required id,
    required name,
    required price,
    required img,
    required quantity,
    required isExists,
    required time,
    required product,
  }) {
    this.id = id;
    this.name = name;
    this.price = price;
    this.img = img;
    this.quantity = quantity;
    this.isExists = isExists;
    this.time = time;
    this.product = product;
  }

  CartModel.fromJson(Map<String, dynamic> json) {
    this.id = json['id'];
    this.name = json['name'];

    this.price = json['price'];

    this.img = json['img'];
    this.quantity = json['quantity'];
    this.isExists = json['isExists'];
    this.time = json['time'];
    this.product = Product.fromJson(json['product']);
  }

  Map<String, dynamic> toJson() {
    return {
      "id":this.id,
      "name":this.name,
      "price":this.price,
      "img":this.img,
      "quantity":this.quantity,
      "isExist":this.isExists,
      "time":this.time,
      "product":this.product!.toJson()
    };
  }


}



// class CartModel {
//   String id;
//   String title;
//   int quantity;
//   double price;
//   bool isExist;
//   String img;
//   String time;
//   Product product;
//
//   CartModel({ required this.id,
//     required this.title,
//     required this.quantity,
//     required this.price,
//     this.isExist = false,
//     required this.img,
//     required this.time,
//     required this.product
//   });
//
//   factory CartModel.fromJson(Map<String, dynamic> json){
//     return CartModel(
//         id: json['id'],
//         title: json['title'],
//         quantity: json['quantity'],
//         price: json['price'],
//         isExist: json['isExist'],
//         img:json['img']??"img/food0.png",
//         time:json['time'],
//         product: Product.fromJson(json['product'])
//     );
//   }
//   //Convert object to string like
//   Map<String, dynamic> toJson() {
//     return {
//
//       "id": this.id,
//       "title": this.title,
//       "quantity": this.quantity,
//       "price": this.price,
//       "isExist": this.isExist,
//       'img':this.img,
//       'time':this.time,
//       //this part we need for accessing the product model
//       //so we will this part later
//       'product':this.product.toJson()
//     };
//   }
// }