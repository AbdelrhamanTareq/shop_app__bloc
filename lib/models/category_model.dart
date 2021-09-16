class CategoreyModel {
  bool? status;

  Data? data;
  CategoreyModel(
    this.status,
    this.data,
  );

  CategoreyModel.fromJson(Map<String, dynamic> jsonData) {
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
  String? name;
  String? image;
  DataModel(this.id, this.image, this.name);
  DataModel.fromJson(Map<String, dynamic> jsonData) {
    id = jsonData['id'];
    name = jsonData['name'];
    image = jsonData['image'];
  }
}

// {"status":true,"data":{"data":[{"id":44,"name":"\u0627\u062c\u0647\u0632\u0647 \u0627\u0644\u0643\u062a\u0631\u0648\u0646\u064a\u0647","image":"https:\/\/student.valuxapps.com\/storage\/uploads\/categories\/16301438353uCFh.29118.jpg"},{"id":43,"name":"\u0645\u0643\u0627\u0641\u062d\u0629 \u0643\u0648\u0631\u0648\u0646\u0627","image":"https:\/\/student.valuxapps.com\/storage\/uploads\/categories\/1630142480dvQxx.3658058.jpg"},{"id":42,"name":"\u0631\u064a\u0627\u0636\u0629","image":"https:\/\/student.valuxapps.com\/storage\/uploads\/categories\/1630141824IkQpJ.sports.png"},{"id":45,"name":"Best Selling","image":"https:\/\/student.valuxapps.com\/storage\/uploads\/categories\/16301577069BVIS.600px-No_image_available.svg.png"},{"id":40,"name":"\u0627\u062f\u0648\u0627\u062a \u0627\u0644\u0627\u0646\u0627\u0631\u0647","image":"https:\/\/student.valuxapps.com\/storage\/uploads\/categories\/16300981128XWfI.Group 1548@3x.png"}]}}