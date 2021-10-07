class ProfileModel {
  bool? status;
  String? message;
  Data? data;

  ProfileModel({this.status, this.message, this.data});

  ProfileModel.fromJson(Map<String, dynamic> jsonData) {
    status = jsonData['status'];
    message = jsonData['message'];
    data = jsonData['data'] != null ? Data.fromJson(jsonData['data']) : null;
  }
}

class Data {
  int? id;
  String? name;
  String? email;
  String? phone;
  String? image;
  String? token;
  int? point;
  int? credit;

  Data({
    this.id,
    this.name,
    this.email,
    this.phone,
    this.image,
    this.token,
    this.point,
    this.credit,
  });

  Data.fromJson(Map<String, dynamic> jsonData) {
    id = jsonData['id'];
    name = jsonData['name'];
    email = jsonData['email'];
    phone = jsonData['phone'];
    image = jsonData['image'];
    token = jsonData['token'];
    point = jsonData['point'];
    credit = jsonData['credit'];
  }
}

class EditProfileModel {
  bool? status;
  String? message;
  Data? data;

  EditProfileModel({this.status, this.message, this.data});

  EditProfileModel.fromJson(Map<String, dynamic> jsonData) {
    status = jsonData['status'];
    message = jsonData['message'];
    data = jsonData['data'] != null ? Data.fromJson(jsonData['data']) : null;
  }
}

class DataModel {
  int? id;
  String? name;
  String? email;
  String? phone;
  String? image;
  String? token;
  int? point;
  int? credit;

  DataModel({
    this.id,
    this.name,
    this.email,
    this.phone,
    this.image,
    this.token,
    this.point,
    this.credit,
  });

  DataModel.fromJson(Map<String, dynamic> jsonData) {
    id = jsonData['id'];
    name = jsonData['name'];
    email = jsonData['email'];
    phone = jsonData['phone'];
    image = jsonData['image'];
    token = jsonData['token'];
    point = jsonData['point'];
    credit = jsonData['credit'];
  }
}
