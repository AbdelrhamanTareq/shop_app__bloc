class HomeModel {
  bool? status;
  HomeData? data;

  HomeModel({this.status, this.data});

  HomeModel.fromJson(Map<String, dynamic> jsonData) {
    status = jsonData['status'];
    data =
        jsonData['data'] != null ? HomeData.fromJson(jsonData['data']) : null;
  }
}

class HomeData {
  List<Banners> banners = [];
  List<Products> products = [];
  HomeData({required this.banners, required this.products});

  HomeData.fromJson(Map<String, dynamic> jsonData) {
    if (jsonData['banners'] != null) {
      // banners = [];
      jsonData['banners'].forEach((element) {
        banners.add(Banners.fromJson(element));
      });
    }
    if (jsonData['products'] != null) {
      // products = [];
      jsonData['products'].forEach((element) {
        products.add(Products.fromJson(element));
      });
    }
  }
}

class Banners {
  int? id;
  String? image;

  Banners({this.id, this.image});

  Banners.fromJson(Map<String, dynamic> jsonData) {
    id = jsonData['id'];
    image = jsonData['image'];
  }
}

class Products {
  int? id;
  String? image;
  dynamic price;
  dynamic oldPrice;
  dynamic discount;
  String? name;
  bool? inFavorites;
  bool? inCart;
  Products({
    this.id,
    this.image,
    this.price,
    this.oldPrice,
    this.discount,
    this.name,
    this.inFavorites,
    this.inCart,
  });

  Products.fromJson(Map<String, dynamic> jsonData) {
    id = jsonData['id'];
    image = jsonData['image'];
    price = jsonData['price'];
    oldPrice = jsonData['old_price'];
    discount = jsonData['discount'];
    name = jsonData['name'];
    inFavorites = jsonData['in_favorites'];
    inCart = jsonData['in_cart'];
  }
}
