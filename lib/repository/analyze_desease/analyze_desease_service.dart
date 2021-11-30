import 'dart:convert';
import 'dart:io';

import 'package:get/get.dart';
import 'package:get/get_connect/http/src/status/http_status.dart';
import 'package:get_storage/get_storage.dart';
import 'package:kedaireka/model/analyze_desease_model.dart';
import 'package:path/path.dart';

class AnalyzeDeseaseService extends GetConnect {
  Future postImageObject(File file) async {
    final form = FormData({
      'image': MultipartFile(file,
          filename: basename(file.path), contentType: 'multipart/form-data'),
    });
    final storaging = GetStorage();
    var token = await storaging.read('token');

    final response =
        await post('https://kedaireka.widyarobotics.com/v1/imageProcess/', form,
            headers: {
              'Authorization': 'Bearer $token',
              'Connection': 'keep-alive',
            },
            contentType: 'multipart/form-data');
    print('analisa berhasil------>>>>> ${response.body}');
    if (response.statusCode == HttpStatus.created) {
      print('created----------------');
      var analyze = AnalyzeDesease.fromJson(response.body);
      return analyze;
    } else if (response.statusCode == HttpStatus.networkConnectTimeoutError) {
      return 'connection timeout';
    } else {
      var body = response.body;
      var message = body['detail'];
      return message ?? body;
    }
  }
}
