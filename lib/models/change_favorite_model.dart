class ChangeFavorite {
  bool? status;
  String? message;

  ChangeFavorite({this.status, this.message});

  ChangeFavorite.fromJson(Map<String, dynamic> jsonData) {
    status = jsonData['status'];
    message = jsonData['message'];
  }
}
