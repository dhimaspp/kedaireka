// ignore_for_file: prefer_final_fields

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:kedaireka/core/auth_manager.dart';
import 'package:kedaireka/theme/constant.dart';

class ChangePassword extends StatefulWidget {
  const ChangePassword({Key? key}) : super(key: key);

  @override
  _ChangePasswordState createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  final AuthenticationManager _authmanager = Get.put(AuthenticationManager());
  TextEditingController kataSandiLamaController = TextEditingController();
  TextEditingController kataSandiBaruController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  String? kataSandiLama, kataSandiBaru, konfirmasiKataSandi;
  bool _obscureKSLama = true;
  bool _obscureKSBaru = true;
  bool _obscureKS = true;

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
                'Pengaturan Kata Sandi',
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
                    child: Form(
                      key: formKey,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: Get.width / 1.1,
                            child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                mainAxisSize: MainAxisSize.max,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  const SizedBox(
                                    height: 40,
                                  ),
                                  Container(
                                    padding: const EdgeInsets.only(bottom: 24),
                                    child: TextFormField(
                                      cursorColor: kFillColor,
                                      decoration: textInputDecoration.copyWith(
                                          labelStyle: textInputDecoration
                                              .labelStyle!
                                              .copyWith(
                                                  color: Colors.black54,
                                                  fontSize: 16),
                                          labelText: "Kata Sandi Lama",
                                          suffixIcon: IconButton(
                                            icon: Icon(
                                              _obscureKSLama
                                                  ? Icons.visibility_off_rounded
                                                  : Icons.visibility_rounded,
                                              color: Colors.black38,
                                            ),
                                            onPressed: () {
                                              setState(() {
                                                _obscureKSLama =
                                                    !_obscureKSLama;
                                              });
                                            },
                                          ),
                                          focusedBorder:
                                              const OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: kMaincolor, width: 2),
                                          ),
                                          enabledBorder:
                                              const OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                      color: Colors.black38,
                                                      width: 1.3))),
                                      style: textInputDecoration.labelStyle!
                                          .copyWith(
                                              fontWeight: FontWeight.w500,
                                              color: Colors.black),
                                      textAlignVertical:
                                          TextAlignVertical.center,
                                      validator: (val) {
                                        //   // String pattern =
                                        //   //     r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$';
                                        //   // RegExp regExp = new RegExp(pattern);
                                        if (val!.isEmpty) {
                                          return 'Masukan Kata Sandi Lama';
                                        }
                                        //   // if (!regExp.hasMatch(val)) {
                                        //   //   return 'Password harus terdiri dari 8 karakter dan \n kombinasi angka dan huruf';
                                        //   // }
                                        //   // return null;
                                      },
                                      onChanged: (password) {
                                        setState(
                                            () => kataSandiLama = password);
                                      },
                                      obscureText: _obscureKSLama,
                                    ),
                                  ),
                                  Container(
                                    padding: const EdgeInsets.only(bottom: 24),
                                    child: TextFormField(
                                      cursorColor: kFillColor,
                                      decoration: textInputDecoration.copyWith(
                                          labelStyle: textInputDecoration
                                              .labelStyle!
                                              .copyWith(
                                                  color: Colors.black54,
                                                  fontSize: 16),
                                          labelText: "Kata Sandi Baru",
                                          suffixIcon: IconButton(
                                            icon: Icon(
                                              _obscureKSBaru
                                                  ? Icons.visibility_off_rounded
                                                  : Icons.visibility_rounded,
                                              color: Colors.black38,
                                            ),
                                            onPressed: () {
                                              setState(() {
                                                _obscureKSBaru =
                                                    !_obscureKSBaru;
                                              });
                                            },
                                          ),
                                          focusedBorder:
                                              const OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: kMaincolor, width: 2),
                                          ),
                                          enabledBorder:
                                              const OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                      color: Colors.black38,
                                                      width: 1.3))),
                                      style: textInputDecoration.labelStyle!
                                          .copyWith(
                                              fontWeight: FontWeight.w500,
                                              color: Colors.black),
                                      textAlignVertical:
                                          TextAlignVertical.center,
                                      validator: (val) {
                                        //   // String pattern =
                                        //   //     r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$';
                                        //   // RegExp regExp = new RegExp(pattern);
                                        if (val!.isEmpty) {
                                          return 'Masukan Kata Sandi baru';
                                        }
                                        //   // if (!regExp.hasMatch(val)) {
                                        //   //   return 'Password harus terdiri dari 8 karakter dan \n kombinasi angka dan huruf';
                                        //   // }
                                        //   // return null;
                                      },
                                      onChanged: (password) {
                                        setState(
                                            () => kataSandiBaru = password);
                                      },
                                      obscureText: _obscureKSBaru,
                                    ),
                                  ),
                                  Container(
                                    padding: const EdgeInsets.only(bottom: 20),
                                    child: TextFormField(
                                      cursorColor: kFillColor,
                                      decoration: textInputDecoration.copyWith(
                                          labelStyle: textInputDecoration
                                              .labelStyle!
                                              .copyWith(
                                                  color: Colors.black54,
                                                  fontSize: 16),
                                          labelText:
                                              "Konfirmasi Kata Sandi Baru",
                                          suffixIcon: IconButton(
                                            icon: Icon(
                                              _obscureKS
                                                  ? Icons.visibility_off_rounded
                                                  : Icons.visibility_rounded,
                                              color: Colors.black38,
                                            ),
                                            onPressed: () {
                                              setState(() {
                                                _obscureKS = !_obscureKS;
                                              });
                                            },
                                          ),
                                          focusedBorder:
                                              const OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: kMaincolor, width: 2),
                                          ),
                                          enabledBorder:
                                              const OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                      color: Colors.black38,
                                                      width: 1.3))),
                                      style: textInputDecoration.labelStyle!
                                          .copyWith(
                                              fontWeight: FontWeight.w500,
                                              color: Colors.black),
                                      textAlignVertical:
                                          TextAlignVertical.center,
                                      validator: (val) {
                                        //   // String pattern =
                                        //   //     r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$';
                                        //   // RegExp regExp = new RegExp(pattern);
                                        if (val!.isEmpty) {
                                          return 'Masukan Konfirmasi Kata Sandi';
                                        } else if (val != kataSandiBaru) {
                                          return 'Konfirmasi Kata Sandi Tidak cocok';
                                        }
                                        //   // if (!regExp.hasMatch(val)) {
                                        //   //   return 'Password harus terdiri dari 8 karakter dan \n kombinasi angka dan huruf';
                                        //   // }
                                        //   // return null;
                                      },
                                      onChanged: (password) {
                                        setState(() =>
                                            konfirmasiKataSandi = password);
                                      },
                                      obscureText: _obscureKS,
                                    ),
                                  )
                                ]),
                          ),
                        ],
                      ),
                    ),
                  )),
            ),
            Positioned(
              // width: Get.width,
              // left: Get.width - (Get.width / 1.1,
              bottom: 20,
              child: Container(
                padding: EdgeInsets.only(
                    left: Get.width * 0.1 / 2, right: Get.width * 0.1 / 2),
                height: 48,
                width: Get.width,
                child: ElevatedButton(
                  clipBehavior: Clip.hardEdge,
                  style: ElevatedButton.styleFrom(
                    primary: kMaincolor,
                  ),
                  child: Text(
                    "Ganti Kata Sandi",
                    style: textInputDecoration.labelStyle!.copyWith(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w800),
                  ),
                  onPressed: () async {
                    if (formKey.currentState?.validate() ?? false) {
                      EasyLoading.show();
                      _authmanager
                          .userGantiPassword(kataSandiBaru!)
                          .whenComplete(() => Get.defaultDialog(
                              middleText: 'Ganti Password Berhasil',
                              textConfirm: 'OK',
                              confirmTextColor: Colors.white,
                              buttonColor: kMaincolor,
                              onConfirm: () {
                                Get.back();
                              }));
                      EasyLoading.dismiss();
                    }
                  },
                ),
              ),
            )
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
