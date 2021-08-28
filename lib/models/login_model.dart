class LoginModel {
  String? status;
  String? message;
  Data? data;

  LoginModel({this.status, this.message, this.data});

  LoginModel.fromJson(Map<String, dynamic> jsonData) {
    status = jsonData['status'];
    message = jsonData['message'];
    data = jsonData['data'];
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
