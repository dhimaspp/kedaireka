// ignore_for_file: avoid_print

import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:get_storage/get_storage.dart';

class AuthApi {
  Dio? _dio;
  final String mainUrl = 'https://kedaireka.widyarobotics.com';
  BaseOptions options = BaseOptions(
      baseUrl: 'https://kedaireka.widyarobotics.com',
      receiveDataWhenStatusError: true,
      connectTimeout: 30 * 1000, // 60 seconds
      receiveTimeout: 30 * 1000 // 60 seconds
      );

  Future getAccess(String email, String password) async {
    _dio = Dio(options);
    var postAccess = FormData.fromMap({"email": email, "password": password});
    try {
      Response response = await _dio!.post(
        'https://kedaireka.widyarobotics.com/v1/token/',
        data: postAccess,
      );

      final storaging = GetStorage();
      var body = response.data;
      var token = body['access'];
      var name = body['first_name'];
      print('token didapatkan === $token');
      await storaging.write('token', token);
      await storaging.write('name', name);
      return 'login sukses';
    } on DioError catch (error, stackTrace) {
      print("Exception occured: $error stackTrace: $stackTrace");
      if (error.type == DioErrorType.response) {
        print(error.response!.data);
        var errorBody = error.response!.data;
        var message = errorBody['detail'];
        return message;
      } else if (error.type == DioErrorType.connectTimeout) {
        return 'Koneksi terhenti, Harap periksa internet koneksi anda';
      } else {
        return error.response!.data;
      }
    }
  }

  Future userRegistration(String email, String password, String nama) async {
    _dio = Dio(options);
    var postRegistration = FormData.fromMap(
        {'email': email, 'password': password, 'first_name': nama});
    try {
      Response response = await _dio!.post(
        mainUrl + '/v1/user/create_user/',
        data: postRegistration,
      );
      final storaging = GetStorage();
      var body = response.data;
      var token = body['access'];
      var name = body['first_name'];
      print('token didapatkan === $token');
      await storaging.write('token', token);
      await storaging.write('name', name);
      return 'register sukses';
    } on DioError catch (error, stackTrace) {
      print("Exception occured: $error stackTrace: $stackTrace");
      if (error.type == DioErrorType.response) {
        print(error.response!.data);
        var errorBody = error.response!.data;
        var message = errorBody['detail'];
        var email = errorBody;
        return message ?? errorBody.toString();
      } else if (error.type == DioErrorType.connectTimeout) {
        return 'Koneksi terhenti, Harap periksa internet koneksi anda';
      } else {
        return error.response!.data;
      }
    }
  }

  Future gantiNama(String nama) async {
    _dio = Dio(options);
    var postNama = FormData.fromMap({"first_name": nama});
    try {
      final storaging = GetStorage();
      var token = await storaging.read('token');
      Response response = await _dio!.put(mainUrl + '/v1/user/update_user/',
          data: postNama,
          options: Options(headers: {
            'Authorization': 'Bearer $token',
            'Connection': 'keep-alive',
          }));
      var body = response.data;
      var name = body['first_name'];

      await storaging.write('name', name);
      return 'ganti nama sukses';
    } on DioError catch (error, stackTrace) {
      print("Exception occured: $error stackTrace: $stackTrace");
      if (error.type == DioErrorType.response) {
        print(error.response!.data);
        var errorBody = error.response!.data;
        var message = errorBody['detail'];

        return message;
      } else if (error.type == DioErrorType.connectTimeout) {
        return 'Koneksi terhenti, Harap periksa internet koneksi anda';
      } else {
        return error.response!.data;
      }
    }
  }

  Future gantiEmail(String email) async {
    _dio = Dio(options);
    var postNama = FormData.fromMap({"email": email});
    try {
      final storaging = GetStorage();
      var token = await storaging.read('token');
      Response response = await _dio!.put(mainUrl + '/v1/user/update_user/',
          data: postNama,
          options: Options(headers: {
            'Authorization': 'Bearer $token',
            'Connection': 'keep-alive',
          }));
      var body = response.data;
      var email = body['email'];

      await storaging.write('email', email);
      return 'ganti email sukses';
    } on DioError catch (error, stackTrace) {
      print("Exception occured: $error stackTrace: $stackTrace");
      if (error.type == DioErrorType.response) {
        print(error.response!.data);
        var errorBody = error.response!.data;
        var message = errorBody['detail'];

        return message;
      } else if (error.type == DioErrorType.connectTimeout) {
        return 'Koneksi terhenti, Harap periksa internet koneksi anda';
      } else {
        return error.response!.data;
      }
    }
  }

  Future gantiPassword(String password) async {
    _dio = Dio(options);
    var postPassword = FormData.fromMap({"new_password": password});
    try {
      final storaging = GetStorage();
      var token = await storaging.read('token');
      Response response = await _dio!.put(mainUrl + '/v1/user/change_password/',
          data: postPassword,
          options: Options(headers: {
            'Authorization': 'Bearer $token',
            'Connection': 'keep-alive',
          }));
      return 'ganti password sukses';
    } on DioError catch (error, stackTrace) {
      print("Exception occured: $error stackTrace: $stackTrace");
      if (error.type == DioErrorType.response) {
        print(error.response!.data);
        var errorBody = error.response!.data;
        var message = errorBody['detail'];

        return message;
      } else if (error.type == DioErrorType.connectTimeout) {
        return 'Koneksi terhenti, Harap periksa internet koneksi anda';
      } else {
        return error.response!.data;
      }
    }
  }
}
