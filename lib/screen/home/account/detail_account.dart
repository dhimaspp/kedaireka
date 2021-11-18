import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kedaireka/theme/constant.dart';

class DetailAccount extends StatefulWidget {
  const DetailAccount({Key? key}) : super(key: key);

  @override
  _DetailAccountState createState() => _DetailAccountState();
}

class _DetailAccountState extends State<DetailAccount> {
  TextEditingController namaController = TextEditingController();
  TextEditingController usernameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  bool? ubahNama, ubahUsername, ubahEmail;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        child: Stack(
          alignment: Alignment.topLeft,
          children: [
            Container(
              color: kMaincolor,
              height: 190,
              padding: const EdgeInsets.only(top: 60, left: 62),
              width: Get.width,
              child: Text(
                'Informasi Akun',
                style: textInputDecoration.labelStyle!.copyWith(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.w400),
              ),
            ),
            Container(
              height: 30,
              margin: const EdgeInsets.only(
                top: 52,
                left: 12,
              ),
              child: IconButton(
                onPressed: () {
                  Get.back();
                },
                icon: const Icon(
                  Icons.arrow_back_ios_new_rounded,
                  color: Colors.white,
                ),
              ),
            ),
            Positioned(
              top: 110,
              child: Container(
                  width: Get.width,
                  height: Get.height,
                  decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                          topRight: Radius.circular(30),
                          topLeft: Radius.circular(30))),
                  child: SingleChildScrollView(
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          const SizedBox(
                            height: 30,
                          ),
                          const CircleAvatar(
                            radius: 55,
                            backgroundColor: kMaincolor,
                            child: Text(
                              'K',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 80),
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.only(top: 30, bottom: 15),
                            height: Get.height,
                            width: Get.width / 1.15,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'Nama',
                                  style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.grey,
                                      fontWeight: FontWeight.w400),
                                ),
                                Container(
                                  decoration: const BoxDecoration(
                                      border: Border(
                                          bottom: BorderSide(
                                    color: Colors.grey,
                                  ))),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      const Text(
                                        'Kedaireka Find Disease',
                                        style: TextStyle(
                                            fontSize: 16,
                                            color: Colors.black,
                                            fontWeight: FontWeight.w400),
                                      ),
                                      TextButton(
                                          onPressed: () {
                                            setState(() {
                                              ubahNama = true;
                                            });
                                          },
                                          child: const Text('Ubah',
                                              style: TextStyle(
                                                  fontSize: 16,
                                                  color: kMaincolor,
                                                  fontWeight: FontWeight.w400)))
                                    ],
                                  ),
                                ),
                                AnimatedSwitcher(
                                    duration: const Duration(milliseconds: 300),
                                    transitionBuilder: (Widget child,
                                        Animation<double> animation) {
                                      final offsetAnimation = Tween<Offset>(
                                              begin: const Offset(1.0, 0.0),
                                              end: const Offset(0.0, 0.0))
                                          .animate(animation);
                                      return SlideTransition(
                                        position: offsetAnimation,
                                        child: child,
                                      );
                                    },
                                    child: ubahNama == true
                                        ? Container(
                                            padding: const EdgeInsets.all(8),
                                            // height: 60,
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: [
                                                TextFormField(
                                                  controller: namaController,
                                                  decoration:
                                                      const InputDecoration(
                                                          hintText:
                                                              'Masukan nama baru',
                                                          // border: InputBorder.none,
                                                          focusedBorder: OutlineInputBorder(
                                                              borderRadius: BorderRadius
                                                                  .all(Radius
                                                                      .circular(
                                                                          5.0)),
                                                              borderSide:
                                                                  BorderSide(
                                                                      color:
                                                                          kMaincolor))),
                                                ),
                                                Row(
                                                  children: [
                                                    ElevatedButton(
                                                        style: ElevatedButton
                                                            .styleFrom(
                                                                primary:
                                                                    kMaincolor),
                                                        onPressed: () {},
                                                        child: const Text(
                                                          'Perbarui Nama',
                                                        )),
                                                    TextButton(
                                                        onPressed: () {
                                                          setState(() {
                                                            ubahNama = false;
                                                          });
                                                        },
                                                        child: const Text(
                                                          'batalkan',
                                                          style: TextStyle(
                                                              color:
                                                                  kMaincolor),
                                                        ))
                                                  ],
                                                )
                                              ],
                                            ),
                                          )
                                        : const SizedBox(
                                            height: 25,
                                          )),
                                const Text(
                                  'Username',
                                  style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.grey,
                                      fontWeight: FontWeight.w400),
                                ),
                                Container(
                                  decoration: const BoxDecoration(
                                      border: Border(
                                          bottom: BorderSide(
                                    color: Colors.grey,
                                  ))),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      const Text(
                                        'Kedaireka',
                                        style: TextStyle(
                                            fontSize: 16,
                                            color: Colors.black,
                                            fontWeight: FontWeight.w400),
                                      ),
                                      TextButton(
                                          onPressed: () {
                                            setState(() {
                                              ubahUsername = true;
                                            });
                                          },
                                          child: const Text('Ubah',
                                              style: TextStyle(
                                                  fontSize: 16,
                                                  color: kMaincolor,
                                                  fontWeight: FontWeight.w400)))
                                    ],
                                  ),
                                ),
                                AnimatedSwitcher(
                                    duration: const Duration(milliseconds: 300),
                                    transitionBuilder: (Widget child,
                                        Animation<double> animation) {
                                      final offsetAnimation = Tween<Offset>(
                                              begin: const Offset(1.0, 0.0),
                                              end: const Offset(0.0, 0.0))
                                          .animate(animation);
                                      return SlideTransition(
                                        position: offsetAnimation,
                                        child: child,
                                      );
                                    },
                                    child: ubahUsername == true
                                        ? Container(
                                            padding: const EdgeInsets.all(8),
                                            // height: 60,
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: [
                                                TextFormField(
                                                  controller: namaController,
                                                  decoration:
                                                      const InputDecoration(
                                                          hintText:
                                                              'Masukan username baru',
                                                          // border: InputBorder.none,
                                                          focusedBorder: OutlineInputBorder(
                                                              borderRadius: BorderRadius
                                                                  .all(Radius
                                                                      .circular(
                                                                          5.0)),
                                                              borderSide:
                                                                  BorderSide(
                                                                      color:
                                                                          kMaincolor))),
                                                ),
                                                Row(
                                                  children: [
                                                    ElevatedButton(
                                                        style: ElevatedButton
                                                            .styleFrom(
                                                                primary:
                                                                    kMaincolor),
                                                        onPressed: () {},
                                                        child: const Text(
                                                          'Perbarui Username',
                                                        )),
                                                    TextButton(
                                                        onPressed: () {
                                                          setState(() {
                                                            ubahUsername =
                                                                false;
                                                          });
                                                        },
                                                        child: const Text(
                                                          'batalkan',
                                                          style: TextStyle(
                                                              color:
                                                                  kMaincolor),
                                                        ))
                                                  ],
                                                )
                                              ],
                                            ),
                                          )
                                        : const SizedBox(
                                            height: 25,
                                          )),
                                const Text(
                                  'Email',
                                  style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.grey,
                                      fontWeight: FontWeight.w400),
                                ),
                                Container(
                                  decoration: const BoxDecoration(
                                      border: Border(
                                          bottom: BorderSide(
                                    color: Colors.grey,
                                  ))),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      const Text(
                                        'Kedaireka@gmail.com',
                                        style: TextStyle(
                                            fontSize: 16,
                                            color: Colors.black,
                                            fontWeight: FontWeight.w400),
                                      ),
                                      TextButton(
                                          onPressed: () {
                                            setState(() {
                                              ubahEmail = true;
                                            });
                                          },
                                          child: const Text('Ubah',
                                              style: TextStyle(
                                                  fontSize: 16,
                                                  color: kMaincolor,
                                                  fontWeight: FontWeight.w400)))
                                    ],
                                  ),
                                ),
                                AnimatedSwitcher(
                                    duration: const Duration(milliseconds: 300),
                                    transitionBuilder: (Widget child,
                                        Animation<double> animation) {
                                      final offsetAnimation = Tween<Offset>(
                                              begin: const Offset(1.0, 0.0),
                                              end: const Offset(0.0, 0.0))
                                          .animate(animation);
                                      return SlideTransition(
                                        position: offsetAnimation,
                                        child: child,
                                      );
                                    },
                                    child: ubahEmail == true
                                        ? Container(
                                            padding: const EdgeInsets.all(8),
                                            // height: 60,
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: [
                                                TextFormField(
                                                  controller: namaController,
                                                  decoration:
                                                      const InputDecoration(
                                                          hintText:
                                                              'Masukan email baru',
                                                          // border: InputBorder.none,
                                                          focusedBorder: OutlineInputBorder(
                                                              borderRadius: BorderRadius
                                                                  .all(Radius
                                                                      .circular(
                                                                          5.0)),
                                                              borderSide:
                                                                  BorderSide(
                                                                      color:
                                                                          kMaincolor))),
                                                ),
                                                Row(
                                                  children: [
                                                    ElevatedButton(
                                                        style: ElevatedButton
                                                            .styleFrom(
                                                                primary:
                                                                    kMaincolor),
                                                        onPressed: () {},
                                                        child: const Text(
                                                          'Perbarui Email',
                                                        )),
                                                    TextButton(
                                                        onPressed: () {
                                                          setState(() {
                                                            ubahEmail = false;
                                                          });
                                                        },
                                                        child: const Text(
                                                          'batalkan',
                                                          style: TextStyle(
                                                              color:
                                                                  kMaincolor),
                                                        ))
                                                  ],
                                                )
                                              ],
                                            ),
                                          )
                                        : const SizedBox(
                                            height: 25,
                                          )),
                              ],
                            ),
                          ),
                        ]),
                  )),
            ),
            // Container(
            //   color: kMaincolor,
            //   height: 120,
            // ),
          ],
        ),
      ),
    );
    ;
  }
}
