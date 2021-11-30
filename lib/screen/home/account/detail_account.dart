// ignore_for_file: prefer_final_fields

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:kedaireka/core/auth_manager.dart';
import 'package:kedaireka/theme/constant.dart';

class DetailAccount extends StatefulWidget {
  const DetailAccount({Key? key}) : super(key: key);

  @override
  _DetailAccountState createState() => _DetailAccountState();
}

class _DetailAccountState extends State<DetailAccount> {
  final AuthenticationManager _authmanager = Get.put(AuthenticationManager());
  AuthenticationManager _authfind = Get.find();
  TextEditingController namaController = TextEditingController();
  TextEditingController usernameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  bool? ubahNama, ubahUsername, ubahEmail;
  bool loadingUbahNama = false,
      loadingUbahUsername = false,
      loadingUbahEmail = false;
  bool successUbahNama = false,
      successUbahUsername = false,
      successUbahEmail = false;

  String? nama, email;
  @override
  void initState() {
    super.initState();
    final localStorage = GetStorage();
    setState(() {
      nama = localStorage.read('name');
      email = localStorage.read('email');
    });
  }

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
                          CircleAvatar(
                            radius: 55,
                            backgroundColor: kMaincolor,
                            child: Text(
                              nama![0].capitalizeFirst!,
                              style: const TextStyle(
                                  color: Colors.white, fontSize: 80),
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
                                      Text(
                                        nama!.capitalizeFirst!,
                                        style: const TextStyle(
                                            fontSize: 16,
                                            color: Colors.black,
                                            fontWeight: FontWeight.w400),
                                      ),
                                      TextButton(
                                          onPressed: () {
                                            setState(() {
                                              successUbahNama = false;
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
                                successUbahNama == true
                                    ? const Padding(
                                        padding: EdgeInsets.only(top: 8),
                                        child: Text(
                                          "Berhasil mengubah nama!",
                                          style: TextStyle(color: kMaincolor),
                                        ),
                                      )
                                    : const SizedBox(),
                                AnimatedSwitcher(
                                    duration: const Duration(milliseconds: 200),
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
                                                  validator: (val) {
                                                    if (val ==
                                                        namaController.text) {
                                                      return 'Nama baru sama dengan nama anda sebelumnya';
                                                    } else if (val!.isEmpty) {
                                                      return 'Masukan nama baru';
                                                    }
                                                  },
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
                                                        onPressed: () {
                                                          setState(() {
                                                            loadingUbahNama =
                                                                true;
                                                          });
                                                          _authmanager
                                                              .userGantiNama(
                                                                  namaController
                                                                      .text)
                                                              .whenComplete(
                                                                  () async {
                                                            setState(() {
                                                              final localStorage =
                                                                  GetStorage();
                                                              var namas =
                                                                  localStorage
                                                                      .read(
                                                                          'name');
                                                              nama = namas;
                                                              successUbahNama =
                                                                  true;
                                                              ubahNama = false;
                                                              loadingUbahNama =
                                                                  false;
                                                            });
                                                          });
                                                        },
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
                                                        )),
                                                    loadingUbahNama == true
                                                        ? const CircularProgressIndicator(
                                                            color: kMaincolor,
                                                          )
                                                        : const SizedBox(
                                                            height: 0,
                                                          )
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
                                      Text(
                                        email!,
                                        style: const TextStyle(
                                            fontSize: 16,
                                            color: Colors.black,
                                            fontWeight: FontWeight.w400),
                                      ),
                                      TextButton(
                                          onPressed: () {
                                            setState(() {
                                              successUbahEmail = false;
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
                                successUbahEmail == true
                                    ? const Padding(
                                        padding: EdgeInsets.only(top: 8),
                                        child: Text(
                                          "Berhasil mengubah emal!",
                                          style: TextStyle(color: kMaincolor),
                                        ),
                                      )
                                    : const SizedBox(),
                                AnimatedSwitcher(
                                    duration: const Duration(milliseconds: 200),
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
                                                  controller: emailController,
                                                  validator: (val) {
                                                    if (val ==
                                                        emailController.text) {
                                                      return 'Email baru sama dengan Email anda sebelumnya';
                                                    } else if (val!.isEmpty) {
                                                      return 'Masukan email baru';
                                                    }
                                                  },
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
                                                        onPressed: () {
                                                          setState(() {
                                                            loadingUbahEmail =
                                                                true;
                                                          });
                                                          _authmanager
                                                              .userGantiEmail(
                                                                  emailController
                                                                      .text)
                                                              .whenComplete(
                                                                  () async {
                                                            setState(() {
                                                              final localStorage =
                                                                  GetStorage();
                                                              var emails =
                                                                  localStorage
                                                                      .read(
                                                                          'email');
                                                              email = emails;
                                                              successUbahEmail =
                                                                  true;
                                                              ubahEmail = false;
                                                              loadingUbahEmail =
                                                                  false;
                                                            });
                                                          });
                                                        },
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
                                                        )),
                                                    loadingUbahEmail == true
                                                        ? const CircularProgressIndicator(
                                                            color: kMaincolor,
                                                          )
                                                        : const SizedBox(
                                                            height: 0,
                                                          )
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
