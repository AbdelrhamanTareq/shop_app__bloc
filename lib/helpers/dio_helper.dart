import 'package:dio/dio.dart';

import '/shared/component.dart';

class DioHelper {
  static final url = 'https://student.valuxapps.com/api/';
  static late final Dio _dio;

  static init() async {
    _dio = Dio(
      BaseOptions(headers: {
        'Authorization': token ?? "",
        'lang': isArabic1 ? 'ar' : 'en',
      }),
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
        // headers: {
        //   'Authorization': token ?? '',
        //   'lang': isArabic1 ? 'ar' : 'en',
        // }
      ),
    );
  }

  static Future<Response> getData({required String endPoint}) async {
    return await _dio.get(
      'https://student.valuxapps.com/api/$endPoint',
      options: Options(
        receiveDataWhenStatusError: true,
        contentType: 'application/json',
        // headers: {
        //   'Authorization': token,
        //   'lang': isArabic1 ? 'ar' : 'en',
        // }
      ),
    );
  }

  static Future<Response> deleteData({required String endPoint}) async {
    return await _dio.delete(
      'https://student.valuxapps.com/api/$endPoint',
      options: Options(
        receiveDataWhenStatusError: true,
        contentType: 'application/json',
        // headers: {
        //   'Authorization': token,
        //   'lang': isArabic1 ? 'ar' : 'en',
        // }
      ),
    );
  }

  static Future<Response> updateData(
      {required String endPoint, required Map<String, dynamic> data}) async {
    return await _dio.put('https://student.valuxapps.com/api/$endPoint',
        options: Options(
          receiveDataWhenStatusError: true,
          contentType: 'application/json',
          // headers: {
          //   'Authorization': token,
          //   'lang': isArabic1 ? 'ar' : 'en',
          // }
        ),
        data: data);
  }
}
