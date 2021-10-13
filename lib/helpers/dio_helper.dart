import 'package:dio/dio.dart';
import 'package:shop_app_bloc/shared/component.dart';

class DioHelper {
  static final url = 'https://student.valuxapps.com/api/';
  static late final Dio _dio;

  static init() async {
    _dio = Dio(
        // BaseOptions(
        //   connectTimeout: 5000,
        //   receiveTimeout: 3000,
        // ),
        );
  }

  static Future<Response> postData(
      {required String endPoint, required Map data, String? token}) async {
    return await _dio.post(
      'https://student.valuxapps.com/api/$endPoint',
      data: data,
      options: Options(
          receiveDataWhenStatusError: true,
          contentType: 'application/json',
          headers: {'Authorization': token ?? '', 'lang': 'en'}),
    );
  }

  static Future<Response> getData({required String endPoint}) async {
    return await _dio.get(
      'https://student.valuxapps.com/api/$endPoint',
      options: Options(
          receiveDataWhenStatusError: true,
          contentType: 'application/json',
          headers: {'Authorization': token, 'lang': 'en'}),
    );
  }

  static Future<Response> deleteData({required String endPoint}) async {
    return await _dio.delete(
      'https://student.valuxapps.com/api/$endPoint',
      options: Options(
          receiveDataWhenStatusError: true,
          contentType: 'application/json',
          headers: {'Authorization': token, 'lang': 'en'}),
    );
  }

  static Future<Response> updateData(
      {required String endPoint, required Map<String, dynamic> data}) async {
    return await _dio.put('https://student.valuxapps.com/api/$endPoint',
        options: Options(
            receiveDataWhenStatusError: true,
            contentType: 'application/json',
            headers: {'Authorization': token, 'lang': 'en'}),
        data: data);
  }

  // static Future<Response> search() async {
  //   return await _dio.post(
  //     'https://student.valuxapps.com/api/products/search',
  //     data: {"text": "phone"},
  //     options: Options(
  //         receiveDataWhenStatusError: true,
  //         contentType: 'application/json',
  //         headers: {'Authorization': token, 'lang': 'en'}),
  //   );
  // }
}
