import 'package:get/get_state_manager/get_state_manager.dart';

class AnalyzeDesease {
  AnalyzeDesease({
    this.detail,
    required this.classType,
    required this.treatment,
    required this.description,
    required this.imgbounding,
    required this.predictions,
  });
  String? detail;
  late final List<String> classType;
  late final List<String> treatment;
  late final List<String> description;
  late final String imgbounding;
  late final List<Predictions> predictions;

  AnalyzeDesease.fromJson(Map<String, dynamic> json) {
    detail = json['detail'];
    classType = List.castFrom<dynamic, String>(json['class_type']);
    treatment = List.castFrom<dynamic, String>(json['treatment']);
    description = List.castFrom<dynamic, String>(json['description']);
    imgbounding = json['imgbounding'];
    predictions = List.from(json['predictions'])
        .map((e) => Predictions.fromJson(e))
        .toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['class_type'] = classType;
    _data['treatment'] = treatment;
    _data['description'] = description;
    _data['imgbounding'] = imgbounding;
    _data['predictions'] = predictions.map((e) => e.toJson()).toList();
    return _data;
  }
}

class Predictions {
  Predictions({
    required this.classType,
    required this.xywhNormalized,
    required this.roiCropped,
  });
  late final List<String> classType;
  late final List<String> xywhNormalized;
  late final String roiCropped;

  Predictions.fromJson(Map<String, dynamic> json) {
    classType = List.castFrom<dynamic, String>(json['class_type']);
    xywhNormalized = List.castFrom<dynamic, String>(json['xywh_normalized']);
    roiCropped = json['roi_cropped'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['class_type'] = classType;
    _data['xywh_normalized'] = xywhNormalized;
    _data['roi_cropped'] = roiCropped;
    return _data;
  }
}
