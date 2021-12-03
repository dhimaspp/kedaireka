// ignore_for_file: avoid_print, must_be_immutable

import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kedaireka/core/analyze_manager.dart';
import 'dart:ui' as ui;

import 'package:kedaireka/model/analyze_desease_model.dart';
import 'package:kedaireka/screen/home/desease_analyze/detail_analyze.dart';
import 'package:kedaireka/theme/constant.dart';
import 'package:kedaireka/widgets/persistence_bottom_nav.dart';

// ignore: use_key_in_widget_constructors
class ResultAnalyze extends GetView<AnalyzeManager> {
  ui.Image? info;
  List<String> classTypeNested = [];
  List<String> lalatBuah = [];
  List<String> antraknosa = [];
  List<String> gambarCropanLalatBuah = [];
  List<String> gambarCropanAntraknosa = [];
  List<Predictions> prediction = [];
  List<String> jumlahDeteksi = [];

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return await Get.to(const PersistenceBottomNavBar());
      },
      child: Scaffold(
        body: Obx(() {
          classTypeNested.clear();
          lalatBuah.clear();
          antraknosa.clear();
          gambarCropanAntraknosa.clear();
          gambarCropanLalatBuah.clear();
          prediction.clear();
          for (var i = 0; i < controller.prediction.length; i++) {
            prediction.add(controller.prediction[i]);
            if (controller.prediction[i].classType[0] == '0') {
              lalatBuah.add('lalatbuah $i');
              print('jumlah lalat buah $lalatBuah');
              gambarCropanLalatBuah.add(controller.prediction[i].roiCropped);
            } else if (controller.prediction[i].classType[0] == '1') {
              antraknosa.add('antraknosa $i');
              print('jumlah antraknosa $antraknosa');
              gambarCropanAntraknosa.add(controller.prediction[i].roiCropped);
            }
          }
          if (lalatBuah.isNotEmpty) {
            jumlahDeteksi.add('satu');
          }
          if (antraknosa.isNotEmpty) {
            jumlahDeteksi.add('dua');
          }
          // for (var i = 0; i < prediction.length; i++) {
          //   lalatBuah.add(prediction[i].classType);
          // }
          print('print state result--------->>>>${controller.prediction}');
          return Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                height: 380,
                child: Stack(
                  // fit: StackFit.loose,
                  children: [
                    SizedBox(
                      width: Get.width,
                      height: Get.width,
                      child: ClipRRect(
                        borderRadius: const BorderRadius.only(
                            bottomLeft: Radius.circular(24),
                            bottomRight: Radius.circular(24)),
                        child: CachedNetworkImage(
                          height: 300,
                          imageUrl: '${controller.imgBounding}',
                          progressIndicatorBuilder:
                              (context, url, downloadProgress) =>
                                  LinearProgressIndicator(
                                      backgroundColor: Colors.grey[100],
                                      color: Colors.grey[300],
                                      value: downloadProgress.progress),
                          errorWidget: (context, url, error) =>
                              const Icon(Icons.error),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          height: 100,
                          decoration: const BoxDecoration(
                              gradient: LinearGradient(
                                  begin: Alignment.bottomCenter,
                                  end: Alignment.topCenter,
                                  colors: [
                                    Colors.black54,
                                    Colors.black45,
                                    Colors.transparent
                                  ]),
                              borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(24),
                                  bottomRight: Radius.circular(24))),
                        ),
                      ],
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Padding(
                          padding: EdgeInsets.only(left: 18, bottom: 6),
                          child: Text(
                            'Hasil Pengolahan Citra',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 18, bottom: 18),
                          child: Text(
                            'Mendapatkan ${jumlahDeteksi.length} jenis penyakit',
                            style: const TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                                fontWeight: FontWeight.w400),
                          ),
                        ),
                      ],
                    ),
                    GestureDetector(
                        onTap: () {
                          Get.to(() => const PersistenceBottomNavBar());
                        },
                        child: Container(
                          height: 30,
                          width: 30,
                          color: Colors.black45,
                          margin: const EdgeInsets.only(left: 18, top: 38),
                          child: const Icon(
                            Icons.arrow_back,
                            color: Colors.white,
                          ),
                        ))
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              lalatBuah.isNotEmpty
                  ? ListTile(
                      title: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Lalat Buah',
                            style: TextStyle(
                                fontWeight: FontWeight.w500, fontSize: 20),
                          ),
                          Text('Terdapat ${lalatBuah.length} deteksi'),
                        ],
                      ),
                      subtitle: SizedBox(
                          height: 82,
                          child: ListView.builder(
                            shrinkWrap: false,
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, index) {
                              return Container(
                                margin:
                                    const EdgeInsets.only(right: 10, top: 5),
                                padding:
                                    const EdgeInsets.only(left: 10, right: 10),
                                decoration: BoxDecoration(
                                    border: Border.all(
                                        color: Colors.grey, width: 1),
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(8))),
                                child: CachedNetworkImage(
                                  imageUrl: gambarCropanLalatBuah[index],
                                  // progressIndicatorBuilder:
                                  //     (context, url, downloadProgress) =>
                                  //         LinearProgressIndicator(
                                  //             backgroundColor: Colors.grey[100],
                                  //             color: Colors.grey[300],
                                  //             value: downloadProgress.progress),
                                  // errorWidget: (context, url, error) =>
                                  //     const Icon(Icons.error),
                                ),
                              );
                            },
                            itemCount: gambarCropanLalatBuah.length,
                          )),
                      trailing: IconButton(
                          onPressed: () {
                            Get.to(() => DetailAnalyze(
                                  classType: 'Lalat Buah',
                                  deskripsi: controller.description[0],
                                  gambarTerkait: gambarCropanLalatBuah,
                                  treatment: controller.treatment[0],
                                ));
                          },
                          icon: const Icon(
                            Icons.arrow_forward,
                            color: Colors.black,
                          )),
                    )
                  : const SizedBox(
                      height: 0,
                    ),
              const Divider(
                thickness: 1,
              ),
              antraknosa.isNotEmpty
                  ? ListTile(
                      title: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Antraknosa',
                            style: TextStyle(
                                fontWeight: FontWeight.w500, fontSize: 20),
                          ),
                          Text('Terdapat ${antraknosa.length} deteksi'),
                        ],
                      ),
                      subtitle: SizedBox(
                          height: 82,
                          child: ListView.builder(
                            shrinkWrap: false,
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, index) {
                              return Container(
                                margin:
                                    const EdgeInsets.only(right: 10, top: 5),
                                padding:
                                    const EdgeInsets.only(left: 10, right: 10),
                                decoration: BoxDecoration(
                                    border: Border.all(
                                        color: Colors.grey, width: 1),
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(8))),
                                child: CachedNetworkImage(
                                  imageUrl: gambarCropanAntraknosa[index],
                                  // progressIndicatorBuilder:
                                  //     (context, url, downloadProgress) =>
                                  //         LinearProgressIndicator(
                                  //             backgroundColor: Colors.grey[100],
                                  //             color: Colors.grey[300],
                                  //             value: downloadProgress.progress),
                                  // errorWidget: (context, url, error) =>
                                  //     const Icon(Icons.error),
                                ),
                              );
                            },
                            itemCount: gambarCropanAntraknosa.length,
                          )),
                      trailing: IconButton(
                          onPressed: () {
                            Get.to(() => DetailAnalyze(
                                  classType: 'Antraknosa',
                                  deskripsi: controller.description[1],
                                  gambarTerkait: gambarCropanAntraknosa,
                                  treatment: controller.treatment[1],
                                ));
                          },
                          icon: const Icon(
                            Icons.arrow_forward,
                            color: Colors.black,
                          )),
                    )
                  : const SizedBox(
                      height: 0,
                    ),
            ],
          );
        }),
      ),
    );
  }
}
