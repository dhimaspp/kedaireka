// ignore_for_file: avoid_print

import 'dart:convert';

import 'package:get/get_connect.dart';
import 'package:get/get_connect/http/src/status/http_status.dart';
import 'package:get_storage/get_storage.dart';

class AuthApi extends GetConnect {
  // @override
  // void onInit() {
  //   httpClient.baseUrl = 'https://kedaireka.widyarobotics.com';
  // }

  Future getAccess(String email, String password) async {
    Map<String, String> postRegister = {
      'username': email,
      'password': password
    };
    final response = await post(
      'https://kedaireka.widyarobotics.com/v1/token/',
      json.encode(postRegister),
      contentType: 'application/json',
    );

    if (response.statusCode == HttpStatus.ok) {
      final storaging = GetStorage();
      var body = response.body;
      var token = body['access'];
      print('token didapatkan === $token');
      await storaging.write('token', token);
      return 'login sukses';
    } else if (response.statusCode == HttpStatus.requestTimeout) {
      return 'Harap periksa internet koneksi anda';
    } else {
      var body = response.body;
      var message = body['detail'];
      print('error message $message');
      return message.toString();
    }
  }

  Future userRegistration(String email, String password, String nama) async {
    Map<String, String> postRegister = {
      'email': email,
      'password': password,
      'first_name': nama
    };
    final response = await post(
      'https://kedaireka.widyarobotics.com/v1/user/create_user/',
      json.encode(postRegister),
    );
    print(json.encode(postRegister));

    if (response.statusCode == HttpStatus.created) {
      final storaging = GetStorage();
      var body = response.body;
      var email = body['email'];
      var name = body['first_name'];
      await storaging.write('email', email);
      await storaging.write('name', name);
      print('email dan nama tersimpan === $email & $name');
      return 'register sukses';
    } else if (response.statusCode == HttpStatus.requestTimeout) {
      return 'Harap periksa internet koneksi anda';
    } else {
      var body = response.body;
      var message = body['detail'];
      var email = body;
      // var email = 'email sudah dipakai \nharap gunakan email lain';
      print('error message $message');
      return message ?? email.toString();
    }
  }
}
