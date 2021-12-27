// ignore_for_file: file_names

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kedaireka/theme/constant.dart';

class InstruksiScreen extends StatefulWidget {
  const InstruksiScreen({Key? key}) : super(key: key);

  @override
  _InstruksiScreenState createState() => _InstruksiScreenState();
}

class _InstruksiScreenState extends State<InstruksiScreen> {
  CarouselController buttonCarousel = CarouselController();
  int? currentIndexCarousel = 0;

  final itemsCarousel = <String>[
    'assets/instructions/Illustration - first.jpg',
    'assets/instructions/Illustration - Observe.png',
    'assets/instructions/Illustration - Notice!.png',
    'assets/instructions/Illustration - Center!.png',
    'assets/instructions/Illustration - Focus.png'
  ];
  final itemsTextJudul = <String>[
    'Tanaman Cabai',
    'Amati',
    'Perhatian!',
    'Ambil Terpusat',
    'Fokus Pada Objek!'
  ];
  final itemsTextDesc = <String>[
    'Saat ini aplikasi dapat digunakan untuk menganalisis tanaman cabai',
    'Keluar dan jepret masalah penyakit tanaman Anda!',
    'Jangan jepret tanaman yang terlalu jauh untuk hasil yang lebih baik.',
    'Ambil foto penyakit tanaman secara terpusat dan tepat!',
    'Pastikan focus terhadap objek yang difoto, bukan pada latar belakang gambar.'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        child: Stack(
          alignment: Alignment.topCenter,
          children: [
            Container(
              color: kMaincolor,
              height: 190,
              padding: const EdgeInsets.only(top: 60, left: 20),
              width: Get.width,
              child: Text(
                'Instruksi',
                style: textInputDecoration.labelStyle!.copyWith(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.w400),
              ),
            ),
            Positioned(
              top: 110,
              child: Container(
                // height: 40,
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(30),
                        topLeft: Radius.circular(30))),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    const SizedBox(height: 60),
                    CarouselSlider.builder(
                      carouselController: buttonCarousel,
                      itemCount: itemsCarousel.length,
                      options: CarouselOptions(
                        onPageChanged: (indexPage, reason) {
                          setState(() {
                            currentIndexCarousel = indexPage;
                          });
                        },
                        aspectRatio: 16 / 9,
                        height: 440,
                        initialPage: 0,
                        viewportFraction: 0.9,
                      ),
                      itemBuilder: (contextItem, indexItem, indexPageView) {
                        return Container(
                          margin: const EdgeInsets.symmetric(
                            horizontal: 24,
                          ),
                          width: MediaQuery.of(context).size.width / 1.5,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Image.asset(
                                itemsCarousel[indexItem],
                                fit: BoxFit.fitHeight,
                                height: 300,
                              ),
                              const SizedBox(
                                height: 18,
                              ),
                              Text(
                                itemsTextJudul[indexItem],
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20,
                                    color: kMaincolor),
                              ),
                              const SizedBox(
                                height: 18,
                              ),
                              Text(
                                itemsTextDesc[indexItem],
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                    fontWeight: FontWeight.w300, fontSize: 16),
                              )
                            ],
                          ),
                        );
                      },
                    ),
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 80),
                      height: 30,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          Icon(
                            Icons.circle,
                            size: currentIndexCarousel == 0 ? 14 : 10,
                            color: currentIndexCarousel == 0
                                ? kMaincolor
                                : Colors.grey,
                          ),
                          Icon(
                            Icons.circle,
                            size: currentIndexCarousel == 1 ? 14 : 10,
                            color: currentIndexCarousel == 1
                                ? kMaincolor
                                : Colors.grey,
                          ),
                          Icon(
                            Icons.circle,
                            size: currentIndexCarousel == 2 ? 14 : 10,
                            color: currentIndexCarousel == 2
                                ? kMaincolor
                                : Colors.grey,
                          ),
                          Icon(
                            Icons.circle,
                            size: currentIndexCarousel == 3 ? 14 : 10,
                            color: currentIndexCarousel == 3
                                ? kMaincolor
                                : Colors.grey,
                          ),
                          Icon(
                            Icons.circle,
                            size: currentIndexCarousel == 4 ? 14 : 10,
                            color: currentIndexCarousel == 4
                                ? kMaincolor
                                : Colors.grey,
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                buttonCarousel.previousPage(
                  duration: const Duration(milliseconds: 300),
                );
              },
              child: Container(
                margin: EdgeInsets.only(
                    top: Get.height / 2, right: Get.width / 1.25),
                height: 35,
                width: 35,
                child: Image.asset('assets/button/button-previous-enabled.png'),
              ),
            ),
            GestureDetector(
              onTap: () {
                buttonCarousel.nextPage(
                  duration: const Duration(milliseconds: 300),
                );
              },
              child: Container(
                margin: EdgeInsets.only(
                    top: Get.height / 2, left: Get.width / 1.25),
                height: 35,
                width: 35,
                child: Image.asset('assets/button/button-next-enabled.png'),
              ),
            ),
            // Container(
            //   color: kMaincolor,
            //   height: 120,
            // ),
          ],
        ),
      ),
    );
  }
}
