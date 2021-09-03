class ProductModel {
  bool? status;
  Data? data;
  ProductModel({this.status, this.data});
  ProductModel.fromJson(Map<String, dynamic> jsonData) {
    status = jsonData['status'];
    data = jsonData['data'] != null ? Data.fromJson(jsonData['data']) : null;
  }
}

class Data {
  int? id;
  String? image;
  dynamic price;
  dynamic oldPrice;
  dynamic discount;
  String? name;
  String? description;
  bool? inFavorites;
  bool? inCart;
  List<String>? images;
  Data({
    this.id,
    this.image,
    this.price,
    this.oldPrice,
    this.discount,
    this.name,
    this.description,
    this.inFavorites,
    this.inCart,
    this.images,
  });
  Data.fromJson(Map<String, dynamic> jsonData) {
    id = jsonData['id'];
    image = jsonData['image'];
    price = jsonData['price'];
    oldPrice = jsonData['oldPrice'];
    discount = jsonData['discount'];
    name = jsonData['name'];
    description = jsonData['description'];
    inFavorites = jsonData['inFavorites'];
    inCart = jsonData['inCart'];
    inCart = jsonData['inCart'];
    images = (jsonData['images'] != null)
        ? jsonData['images'].forEach((element) {
            images!.add(jsonData['images']);
          })
        : null;
  }

  // data = jsonData['data'] != null ? Data.fromJson(jsonData['data']) : null;
}
