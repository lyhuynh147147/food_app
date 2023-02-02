
class ProductModel {
  late int _totalSize;
  late  int _typeId;
  late int _offset;
  late List<Product> _products;

  ProductModel(
      {required int totalSize,
        required int typeId,
        required int offset,
        required List<Product> products}) {
    this._totalSize = totalSize;
    this._typeId = typeId;
    this._offset = offset;
    this._products = products;
  }

  int get totalSize => _totalSize;
  int get typeId => _typeId;
  int get offset => _offset;
  List<Product> get products => _products;

  ProductModel.fromJson(Map<String, dynamic> json) {
    _totalSize = json['total_size'];
    _typeId = json['type_id']??0;
    _offset = json['offset'];
    if (json['products'] != null) {
      _products = [];
      json['products'].forEach((v) {
        _products.add(new Product.fromJson(v));
      });
    }
  }

}

class Product{
  int id;
  String name;
  String sub_title;
  int? stars;
  String img;
  String description;
  double price;
  bool isFavourite;
  double quantity;
  String? origin;

  Product({
    required this.id,
    required this.name,
    required this.sub_title,
    required this.img,
    required this.description,
    required this.price,
    this.stars,
    this.isFavourite = false,
    this.quantity = 0.0,
    this.origin
  });

  factory  Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id : json['id'],
      name : json['name'].toString(),
      sub_title : json['sub_title'].toString(),
      img:json['img']??"img/food0.png",
      description:json['description']??'',
      price:double.parse(json['price'].toString()),
      isFavourite:json['isFavourtie']??false,
      stars:json['stars'],
      origin: json['location'],
      quantity: double.parse(json['quantity'].toString())
    );}
  //Convert object to string like
  Map<String, dynamic> toJson() {
    return {

      "id": this.id,
      "name": this.name,
      "quantity": this.quantity,
      "price": this.price,
      "isExist": '',
      'img':this.img,
      //this part we need for accessing the product model
      //so we will this part later
      'isFavourite':this.isFavourite,
      "stars": this.stars,
      "location": this.origin
    };
  }

}

/*class Product {
  int? _totalSize;
  int? _typeId;
  int? _offset;
  late List<ProductModel> _products;
  List<ProductModel> get products=>_products;

  Product({required totalSize, required typeId, required offset, required products}) {
    _totalSize=totalSize;
    _typeId=typeId;
    _offset=offset;
    _products=products;
  }

  Product.fromJson(Map<String, dynamic> json) {
    _totalSize = json['total_size'];
    _typeId = json['type_id'];
    _offset = json['offset'];
    if (json['products'] != null) {
      _products = <ProductModel>[];
      json['products'].forEach((v) {
        _products.add(ProductModel.fromJson(v));
      });
    }
  }

}

class ProductModel {
  int? id;
  String? name;
  String? description;
  int? price;
  int? stars;
  String? img;
  String? location;
  String? createdAt;
  String? updatedAt;
  int? typeId;

  ProductModel(
      {this.id,
        this.name,
        this.description,
        this.price,
        this.stars,
        this.img,
        this.location,
        this.createdAt,
        this.updatedAt,
        this.typeId});

  ProductModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
    price = json['price'];
    stars = json['stars'];
    img = json['img'];
    location = json['location'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    typeId = json['type_id'];
  }

  Map<String, dynamic> toJson() {
    return {
      "id":this.id,
      "name":this.name,
      "price":this.price,
      "img":this.img,
      "location":this.location,
      "createdAt":this.createdAt,
      "updatedAt":this.updatedAt,
      "typeId":this.typeId,
    };
  }

}*/