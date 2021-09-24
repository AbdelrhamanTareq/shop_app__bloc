class CategoryDetailsModel {
  bool? status;
  Data? data;
  CategoryDetailsModel({this.data, this.status});
  CategoryDetailsModel.fromJson(Map<String, dynamic> jsonData) {
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
  String? image;
  dynamic price;
  dynamic oldPrice;
  dynamic discount;
  String? name;
  String? description;
  bool? inFavorites;
  bool? inCart;
  List<String>? images;
  DataModel({
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
  DataModel.fromJson(Map<String, dynamic> jsonData) {
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
    images = (jsonData['images'] as List<dynamic>).cast<String>();
  }
}

// class CategoryDetailsModel {
//   CategoryDetailsModel({
//     required this.status,
//     this.message,
//     required this.data,
//   });
//   late final bool status;
//   late final Null message;
//   late final Data data;

//   CategoryDetailsModel.fromJson(Map<String, dynamic> json) {
//     status = json['status'];
//     message = null;
//     data = Data.fromJson(json['data']);
//   }
// }

// class Data {
//   Data({
//     required this.currentPage,
//     required this.data,
//     required this.firstPageUrl,
//     required this.from,
//     required this.lastPage,
//     required this.lastPageUrl,
//     this.nextPageUrl,
//     required this.path,
//     required this.perPage,
//     this.prevPageUrl,
//     required this.to,
//     required this.total,
//   });
//   late final int currentPage;
//   late final List<Data> data;
//   late final String firstPageUrl;
//   late final int from;
//   late final int lastPage;
//   late final String lastPageUrl;
//   late final Null nextPageUrl;
//   late final String path;
//   late final int perPage;
//   late final Null prevPageUrl;
//   late final int to;
//   late final int total;

//   Data.fromJson(Map<String, dynamic> json) {
//     currentPage = json['current_page'];
//     data = List.from(json['data']).map((e) => Data.fromJson(e)).toList();
//     firstPageUrl = json['first_page_url'];
//     from = json['from'];
//     lastPage = json['last_page'];
//     lastPageUrl = json['last_page_url'];
//     nextPageUrl = null;
//     path = json['path'];
//     perPage = json['per_page'];
//     prevPageUrl = null;
//     to = json['to'];
//     total = json['total'];
//   }
// }
