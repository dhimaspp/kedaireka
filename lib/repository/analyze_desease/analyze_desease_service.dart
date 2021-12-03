// ignore_for_file: avoid_print

import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http_parser/http_parser.dart';
import 'package:kedaireka/model/analyze_desease_model.dart';
import 'package:path/path.dart';
import 'package:mime/mime.dart';

class AnalyzeDeseaseService {
  Dio? _dio;
  final String mainUrl = 'https://kedaireka.widyarobotics.com';
  BaseOptions options = BaseOptions(
      baseUrl: 'https://kedaireka.widyarobotics.com',
      receiveDataWhenStatusError: true,
      connectTimeout: 60 * 1000, // 30 seconds
      receiveTimeout: 60 * 1000 // 30 seconds
      );
  Future postImageObject(File file) async {
    _dio = Dio(options);
    String? mimeOutput = lookupMimeType(file.path);
    print("mime output: ${mimeOutput!.split('/').first}");
    var postImage = FormData.fromMap({
      'image': await MultipartFile.fromFile(file.path,
          filename: basename(file.path),
          contentType: MediaType(
            mimeOutput.split('/').first,
            mimeOutput.split('/').last,
          ))
    });
    try {
      final storaging = GetStorage();
      var token = await storaging.read('token');
      Response response = await _dio!.post(mainUrl + '/v1/imageProcess/',
          data: postImage,
          options: Options(
            headers: {
              'Authorization': 'Bearer $token',
              'Connection': 'keep-alive'
            },
            contentType: 'multipart/form-data',
            method: 'post',
            responseType: ResponseType.json,
          ));
      print('analisa berhasil------>>>>> ${response.data}');
      return AnalyzeDesease.fromJson(response.data);
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
