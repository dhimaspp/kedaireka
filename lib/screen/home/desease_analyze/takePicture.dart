// ignore_for_file: file_names, avoid_print

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
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
  bool _isLoading = false;
  CameraController? _cameraController;
  Future<void>? _initializeCameraControllerFuture;
  CameraController? cameraController;
  CameraDescription? cameraDescription;
  bool cameraFlash = false;

  @override
  void initState() {
    super.initState();

    _cameraController = CameraController(
      widget.cameraDesc,
      ResolutionPreset.max,
    );

    _initializeCameraControllerFuture = _cameraController!.initialize();
  }

  void _takePicture(BuildContext context) async {
    try {
      await _initializeCameraControllerFuture;
      final image = await _cameraController!.takePicture();

      XFile file = XFile(image.path);
      setState(() {
        _isLoading = true;
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(children: <Widget>[
      FutureBuilder(
        future: _initializeCameraControllerFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            final mediaSize = MediaQuery.of(context).size;
            final scale = 1.2 /
                (_cameraController!.value.aspectRatio * mediaSize.aspectRatio);
            print('done ');
            return ClipRect(
                clipper: _MediaSizeClipper(mediaSize),
                child: Transform.scale(
                    scale: scale, child: CameraPreview(_cameraController!)));
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
                                  _cameraController!
                                      .setFlashMode(FlashMode.torch);
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
                                  _cameraController!
                                      .setFlashMode(FlashMode.off);
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
                            onTap: () {
                              setState(() {
                                _isLoading = true;
                              });
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
                            onTap: () {
                              _isLoading = true;
                              _takePicture(context);
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
    _cameraController!.dispose();
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
