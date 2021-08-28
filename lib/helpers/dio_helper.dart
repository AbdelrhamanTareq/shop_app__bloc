import 'package:dio/dio.dart';

class DioHelper {
  static final url = 'https://student.valuxapps.com/api/';
  static late final Dio _dio;

  static init() async {
    _dio = Dio();
  }

  static Future<Response> postData(
      {required String endPoint, required Map data}) async {
    return await _dio.post(
      'https://student.valuxapps.com/api/$endPoint',
      data: data,
      options: Options(
        receiveDataWhenStatusError: true,
        contentType: 'application/json',
      ),
    );
  }

  static getData() async {
    await _dio
        .get(
          'https://student.valuxapps.com/api/home',
          options: Options(
            contentType: 'application/json',
            headers: {
              'lang': 'ar',
              'Authorization':
                  'b676yF4HQTAGtP9bYNM2kjAw3VZ6vd63Ar7dr7jQvhISokVKIK5K3Emr4tiPctOBgBlZhV',
            },
            receiveDataWhenStatusError: true,
          ),
        )
        .then((value) => print(value.data));
  }

  static getD() async {
    await _dio
        .post(
          'https://student.valuxapps.com/api/login',
          data: {
            'email': 'abullah@gmail.com',
            'password': '123456',
          },
          options: Options(
            contentType: 'application/json',
            // headers: {
            //   'lang': 'ar',
            //   'Authorization':
            //       'b676yF4HQTAGtP9bYNM2kjAw3VZ6vd63Ar7dr7jQvhISokVKIK5K3Emr4tiPctOBgBlZhV',
            // },
            receiveDataWhenStatusError: true,
          ),
        )
        .then((value) => print(value.data));
  }
}
