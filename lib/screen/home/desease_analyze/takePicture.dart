// ignore_for_file: file_names, avoid_print, prefer_final_fields

import 'dart:io';

import 'package:camera/camera.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kedaireka/core/analyze_manager.dart';
import 'package:kedaireka/screen/home/desease_analyze/result_analyze.dart';
import 'package:kedaireka/theme/constant.dart';
import 'package:loading_overlay/loading_overlay.dart';

class TakePictureScreen extends StatefulWidget {
  const TakePictureScreen({Key? key, required this.cameraDesc})
      : super(key: key);
  final CameraDescription cameraDesc;

  @override
  _TakePictureScreenState createState() => _TakePictureScreenState();
}

class _TakePictureScreenState extends State<TakePictureScreen>
    with SingleTickerProviderStateMixin {
  AnalyzeManager _analyzeManager = Get.put(AnalyzeManager());
  AnalyzeManager _analyzefind = Get.find();
  bool _isLoading = false;
  CameraController? cameraController;
  Future<void>? _initializeCameraControllerFuture;
  // CameraController? cameraController;
  CameraDescription? cameraDescription;
  bool cameraFlash = false;

  @override
  void initState() {
    super.initState();

    cameraController = CameraController(widget.cameraDesc, ResolutionPreset.max,
        imageFormatGroup: ImageFormatGroup.jpeg);

    _initializeCameraControllerFuture = cameraController!.initialize();
  }

  void _takePicture(BuildContext context) async {
    try {
      await _initializeCameraControllerFuture;
      final image = await cameraController!.takePicture();

      print('TakePicturee ----->>>');

      File file = File(image.path);
      print('File path --->>>>> ${image.path}');
      _analyzeManager.postImageObject(file);
      setState(() {
        _isLoading = true;
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    // _cameraController!.setFlashMode(FlashMode.off);
    return Stack(children: <Widget>[
      FutureBuilder(
        future: _initializeCameraControllerFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            final mediaSize = MediaQuery.of(context).size;
            final scale = 1.2 /
                (cameraController!.value.aspectRatio * mediaSize.aspectRatio);
            print('done ');
            return ClipRect(
                clipper: _MediaSizeClipper(mediaSize),
                child: Transform.scale(
                    scale: scale, child: CameraPreview(cameraController!)));
          } else {
            print('loading');
            return const Center(
                child: CircularProgressIndicator(
              backgroundColor: kFillColor,
              color: kMaincolor,
            ));
          }
        },
      ),
      LoadingOverlay(
          color: kMaincolor,
          progressIndicator: const SizedBox(
            // width: 120,
            child: CircularProgressIndicator(
              // minHeight: 8,
              backgroundColor: kFillColor,
              color: kMaincolor,
            ),
          ),
          child: SizedBox(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: <
                  Widget>[
                Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      GestureDetector(
                        child: Container(
                          height: 38,
                          margin: const EdgeInsets.only(top: 52.0, left: 28),
                          child: Image.asset(
                            'assets/button/button-close.png',
                          ),
                        ),
                        onTap: () {
                          Get.back();
                        },
                      ),
                    ]),
                Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      cameraFlash == false
                          ? GestureDetector(
                              child: Container(
                                height: 38,
                                margin:
                                    const EdgeInsets.only(top: 52.0, right: 28),
                                child: Image.asset(
                                  'assets/button/button-flash.png',
                                ),
                              ),
                              onTap: () {
                                setState(() {
                                  // _cameraController!
                                  //     .setFlashMode(FlashMode.torch);
                                  cameraFlash = true;
                                });
                              },
                            )
                          : GestureDetector(
                              child: Container(
                                height: 38,
                                margin:
                                    const EdgeInsets.only(top: 52.0, right: 28),
                                child: Image.asset(
                                  'assets/button/button-flash.png',
                                  color: Colors.white,
                                ),
                              ),
                              onTap: () async {
                                setState(() {
                                  // _cameraController!
                                  //     .setFlashMode(FlashMode.off);
                                  cameraFlash = false;
                                });
                              },
                            ),
                    ]),
              ]),
              Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          GestureDetector(
                            child: Container(
                              height: 48,
                              margin:
                                  const EdgeInsets.only(bottom: 24.0, left: 48),
                              child: Image.asset(
                                'assets/button/button-gallery.png',
                              ),
                            ),
                            onTap: () async {
                              setState(() {
                                _isLoading = true;
                              });
                              FilePickerResult? resultImage =
                                  await FilePicker.platform.pickFiles(
                                      allowMultiple: false,
                                      type: FileType.custom,
                                      allowedExtensions: ['jpg']);
                              if (resultImage != null) {
                                _analyzeManager
                                    .postImageObject(
                                        File(resultImage.files.single.path!))
                                    .whenComplete(() {
                                  Get.to(() => ResultAnalyze());
                                  setState(() {
                                    _isLoading = false;
                                  });
                                });
                              }
                            },
                          ),
                        ]),
                    Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          GestureDetector(
                            child: Container(
                              height: 74,
                              margin: EdgeInsets.only(
                                  bottom: 18.0,
                                  right: MediaQuery.of(context).size.width / 2 -
                                      37),
                              child: Image.asset(
                                'assets/button/Take Photo Button.png',
                              ),
                            ),
                            onTap: () async {
                              setState(() {
                                _isLoading = true;
                              });
                              try {
                                setState(() {
                                  _isLoading = true;
                                });
                                await _initializeCameraControllerFuture;
                                final image =
                                    await cameraController!.takePicture();
                                // cameraController!.setFlashMode(FlashMode.off);
                                print('TakePicturee ----->>>');

                                File file = File(image.path);
                                print('File path --->>>>> ${image.path}');
                                _analyzeManager
                                    .postImageObject(file)
                                    .whenComplete(() {
                                  Get.to(() => ResultAnalyze());
                                  setState(() {
                                    _isLoading = false;
                                  });
                                });
                                // setState(() {
                                //   if (_analyzefind.isSuccess.value == true) {
                                //     Get.to(() => ResultAnalyze());
                                //   }
                                //   _isLoading = _analyzefind.isDataProcessing.value;
                                // });
                              } catch (e) {
                                print(e);
                              }
                            },
                          ),
                        ]),
                  ]),
            ],
          )),
          isLoading: _isLoading),
    ]);
  }

  @override
  void dispose() {
    cameraController!.dispose();
    _isLoading = false;
    super.dispose();
  }
}

class _MediaSizeClipper extends CustomClipper<Rect> {
  final Size mediaSize;
  const _MediaSizeClipper(this.mediaSize);
  @override
  Rect getClip(Size size) {
    return Rect.fromLTWH(0, 0, mediaSize.width, mediaSize.height);
  }

  @override
  bool shouldReclip(CustomClipper<Rect> oldClipper) {
    return true;
  }
}
