// ignore_for_file: avoid_print

import 'dart:convert';
import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:kedaireka/model/analyze_desease_model.dart';
import 'package:kedaireka/repository/analyze_desease/analyze_desease_service.dart';
import 'package:kedaireka/screen/home/desease_analyze/result_analyze.dart';
import 'package:kedaireka/theme/constant.dart';

class AnalyzeManager extends GetxController {
  late final AnalyzeDeseaseService _analyzeDeseaseService;
  var classType = [].obs;
  var description = [].obs;
  var imgBounding = ''.obs;
  var prediction = <Predictions>[].obs;
  var treatment = [].obs;
  var isDataProcessing = false.obs;
  var isSuccess = false.obs;

  @override
  void onInit() {
    super.onInit();

    _analyzeDeseaseService = Get.put(AnalyzeDeseaseService());
  }

  Future<void> postImageObject(File file) async {
    isDataProcessing(true);
    final response = await _analyzeDeseaseService.postImageObject(file);

    if (response is AnalyzeDesease) {
      print('analisa response------>>>>>');
      classType.clear();
      description.clear();
      prediction.clear();
      treatment.clear();

      classType.addAll(response.classType);
      description.addAll(response.description);
      imgBounding = response.imgbounding.obs;
      prediction.addAll(response.predictions);
      treatment.addAll(response.treatment);

      isSuccess(true);
      Get.to(() => ResultAnalyze());
      isDataProcessing(false);
      // cameraController!.dispose();

    } else {
      Get.defaultDialog(
          middleText: response,
          textConfirm: 'OK',
          confirmTextColor: Colors.white,
          buttonColor: kMaincolor,
          onConfirm: () {
            isSuccess(false);
            isDataProcessing(false);
            Get.back();
          });
    }
  }
}
