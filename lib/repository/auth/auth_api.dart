// ignore_for_file: avoid_print

import 'dart:convert';

import 'package:get/get_connect.dart';
import 'package:get/get_connect/http/src/status/http_status.dart';
import 'package:get_storage/get_storage.dart';

class AuthApi extends GetConnect {
  Future getAccess(String email, String password) async {
    var postRegister = FormData({"email": email, "password": password});
    final response = await post(
      'https://kedaireka.widyarobotics.com/v1/token/',
      postRegister,
      contentType: 'multipart/form-data',
    );
    print('data postregister-------->$postRegister');

    if (response.statusCode == HttpStatus.ok) {
      final storaging = GetStorage();
      var body = response.body;
      var token = body['access'];
      var name = body['first_name'];
      print('token didapatkan === $token');
      await storaging.write('token', token);
      await storaging.write('name', name);
      return 'login sukses';
    } else if (response.statusCode == HttpStatus.networkConnectTimeoutError) {
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

  Future refreshToken(String token) async {
    var refresh = FormData({'refresh': token.trim()});
    final response = await post(
        'https://kedaireka.widyarobotics.com/v1/token/refresh/', refresh,
        contentType: 'multipart/form-data');
    //print(json.encode(refresh));

    if (response.statusCode == HttpStatus.created) {
      final storaging = GetStorage();
      var body = response.body;
      var token = body['access'];

      await storaging.remove('token');
      await storaging.write('token', token);
      print('token direfresh === $token');
      return 'refresh sukses';
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

  Future gantiNama(String nama) async {
    var postRegister = FormData({"first_name": nama});
    final storaging = GetStorage();
    var token = await storaging.read('token');

    final response = await put(
        'https://kedaireka.widyarobotics.com/v1/user/update_user/',
        postRegister,
        contentType: 'multipart/form-data',
        headers: {
          'Authorization': 'Bearer $token',
          'Connection': 'keep-alive',
        });
    if (response.statusCode == HttpStatus.ok) {
      final storaging = GetStorage();
      var body = response.body;

      var name = body['first_name'];

      await storaging.write('name', name);
      return 'ganti nama sukses';
    } else if (response.statusCode == HttpStatus.networkConnectTimeoutError) {
      return 'Harap periksa internet koneksi anda';
    } else {
      var body = response.body;
      var message = body['detail'];
      print('error message $message');
      return message.toString();
    }
  }

  Future gantiEmail(String email) async {
    var postRegister = FormData({"email": email});
    final storaging = GetStorage();
    var token = await storaging.read('token');

    final response = await put(
        'https://kedaireka.widyarobotics.com/v1/user/update_user/',
        postRegister,
        contentType: 'multipart/form-data',
        headers: {
          'Authorization': 'Bearer $token',
          'Connection': 'keep-alive',
        });
    if (response.statusCode == HttpStatus.ok) {
      final storaging = GetStorage();
      var body = response.body;

      var email = body['email'];

      await storaging.write('email', email);
      return 'ganti email sukses';
    } else if (response.statusCode == HttpStatus.networkConnectTimeoutError) {
      return 'Harap periksa internet koneksi anda';
    } else {
      var body = response.body;
      var message = body['detail'];
      print('error message $message');
      return message.toString();
    }
  }
}
