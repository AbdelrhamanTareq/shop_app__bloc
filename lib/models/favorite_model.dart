class FavoriteModel {
  bool? status;
  Data? data;
  FavoriteModel({this.data, this.status});
  FavoriteModel.fromJson(Map<String, dynamic> jsonData) {
    status = jsonData['status'];
    data = jsonData['data'] != null ? Data.fromJson(jsonData['data']) : null;
  }
}

class Data {
  List<DataModel>? dataModel;

  Data(
    this.dataModel,
  );
  Data.fromJson(Map<String, dynamic> jsonData) {
    dataModel =
        List.from(jsonData['data']).map((e) => DataModel.fromJson(e)).toList();
  }
}

class DataModel {
  int? id;
  Product? products;
  DataModel({
    this.id,
    this.products,
  });
  DataModel.fromJson(Map<String, dynamic> jsonData) {
    id = jsonData['id'];

    products = jsonData['product'] != null
        ? Product.fromJson(jsonData['product'])
        : null;
  }
}

class Product {
  int? id;
  int? price;
  dynamic oldPrice;
  int? discount;
  String? image;
  String? name;
  String? description;

  Product({
    this.id,
    this.price,
    this.oldPrice,
    this.discount,
    this.image,
    this.name,
    this.description,
  });
  Product.fromJson(Map<String, dynamic> jsonData) {
    id = jsonData['id'];
    price = jsonData['price'];
    oldPrice = jsonData['old_price'];
    discount = jsonData['discount'];
    image = jsonData['image'];
    name = jsonData['name'];
    description = jsonData['description'];
  }
}
