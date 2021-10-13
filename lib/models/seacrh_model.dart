class SeacrhModel {
  bool? status;
  Data? data;
  SeacrhModel(this.status, this.data);

  SeacrhModel.fromJson(Map<String, dynamic> jsonData) {
    status = jsonData['status'];
    data = jsonData['data'] != null ? Data.fromJson(jsonData['data']) : null;
  }
}

class Data {
  List<DataModel> dataModel = [];
  Data(this.dataModel);

  Data.fromJson(Map<String, dynamic> jsonData) {
    // dataModel = List<DataModel>.from(jsonData['data']).toList();
    for (var x in jsonData['data']) {
      DataModel d = DataModel.fromJson(x);
      dataModel.add(d);
    }
  }
}

class DataModel {
  int? id;
  String? image;
  String? name;
  String? description;
  dynamic price;
  bool? inFav;
  bool? inCart;
  List<String>? images;

  DataModel(
    this.id,
    this.image,
    this.images,
    this.inCart,
    this.inFav,
    this.description,
    this.name,
    this.price,
  );
  DataModel.fromJson(Map<String, dynamic> jsonData) {
    id = jsonData['id'];
    image = jsonData['image'];
    inCart = jsonData['in_cart'];
    inFav = jsonData['in_favorites'];
    description = jsonData['description'];
    name = jsonData['name'];
    price = jsonData['price'];
    // images = List<String>.from(jsonData['images']).toList();
    images = List.castFrom<dynamic, String>(jsonData['images']);
  }
}
