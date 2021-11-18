// ignore_for_file: avoid_print

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import 'package:kedaireka/theme/constant.dart';
import 'package:kedaireka/widgets/persistence_bottom_nav.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final formKey = GlobalKey<FormState>();
  final formKey2 = GlobalKey<FormState>();
  final _textController = TextEditingController();
  bool loading = false;
  String name = '';
  String? email;
  String password = '';
  String? confirmPassword;
  String error = '';
  bool _obscure = true;

  _showMsg(msg) {
    final snackBar = SnackBar(
      content: Text(msg),
      action: SnackBarAction(
        label: 'Close',
        onPressed: () {
          _textController.clear();
        },
      ),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: true,
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        child: SingleChildScrollView(
          child: Stack(
            // fit: StackFit.expand,
            alignment: AlignmentDirectional.topCenter,
            children: <Widget>[
              // Container(
              //   height: 261,
              //   color: kFillColor,
              // ),
              // ignore: sized_box_for_whitespace
              Container(
                // height: MediaQuery.of(context).size.height,
                width: double.infinity,
                child: Image.asset(
                  "assets/images/image-welcometitle+layer.png",
                  fit: BoxFit.fitWidth,
                ),
              ),
              Positioned(
                top: 120,
                child: SvgPicture.asset(
                  'assets/images/Logo Find Disease.svg',
                  color: Colors.white,
                ),
              ),
              const Positioned(
                top: 60,
                child: Text(
                  'Selamat Datang di',
                  style: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                      fontWeight: FontWeight.w400),
                ),
              ),
              Container(
                margin: const EdgeInsets.fromLTRB(0, 330, 0, 0),
                child: const Text(
                  'Daftar',
                  style: TextStyle(
                      fontSize: 16,
                      color: Colors.black,
                      fontWeight: FontWeight.w500),
                ),
              ),
              Container(
                margin: const EdgeInsets.fromLTRB(0, 380, 0, 0),
                child: formSignUp(),
              ),
            ],
            // clipBehavior: Clip.hardEdge,
            // overflow: Overflow.visible,
          ),
        ),
      ),
    );
  }

  Widget formSignUp() {
    return Column(
      children: <Widget>[
        Form(
          key: formKey,
          child: Container(
            width: MediaQuery.of(context).size.width / 1.2,
            alignment: Alignment.center,
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  TextFormField(
                    // controller: _textController,
                    cursorColor: Colors.black,
                    decoration: textInputDecoration.copyWith(
                        labelText: "Nama",
                        labelStyle: textInputDecoration.labelStyle!
                            .copyWith(color: Colors.black54, fontSize: 16),
                        suffixIcon: const Icon(
                          Icons.person,
                          color: Colors.black38,
                        ),
                        focusedBorder: const OutlineInputBorder(
                          borderSide: BorderSide(
                            color: kMaincolor,
                            width: 2,
                          ),
                        ),
                        enabledBorder: const OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.black38, width: 1.3))),
                    style: textInputDecoration.labelStyle!.copyWith(
                        fontWeight: FontWeight.w500, color: Colors.black),
                    textAlignVertical: TextAlignVertical.center,
                    validator: (val) {
                      if (val!.isEmpty) {
                        return 'Masukan Nama';
                      }
                      if (val.length < 4) {
                        return 'Email Harus lebih dari \n 2 karakter';
                      }
                      return null;
                    },
                    onChanged: (val) {
                      setState(() => name = val);
                    },
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    // controller: _textController,
                    cursorColor: Colors.black,
                    decoration: textInputDecoration.copyWith(
                        labelText: "Email",
                        labelStyle: textInputDecoration.labelStyle!
                            .copyWith(color: Colors.black54, fontSize: 16),
                        suffixIcon: const Icon(
                          Icons.email,
                          color: Colors.black38,
                        ),
                        focusedBorder: const OutlineInputBorder(
                          borderSide: BorderSide(
                            color: kMaincolor,
                            width: 2,
                          ),
                        ),
                        enabledBorder: const OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.black38, width: 1.3))),
                    style: textInputDecoration.labelStyle!.copyWith(
                        fontWeight: FontWeight.w500, color: Colors.black),
                    textAlignVertical: TextAlignVertical.center,
                    validator: (val) {
                      if (val!.isEmpty) {
                        return 'Masukan Email';
                      }
                      if (val.length < 4) {
                        return 'Email Harus lebih dari \n 4 karakter';
                      }
                      return null;
                    },
                    onChanged: (val) {
                      setState(() => email = val);
                    },
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    // controller: _textController,
                    cursorColor: kFillColor,
                    decoration: textInputDecoration.copyWith(
                        labelStyle: textInputDecoration.labelStyle!
                            .copyWith(color: Colors.black54, fontSize: 16),
                        labelText: "Kata Sandi",
                        suffixIcon: IconButton(
                          icon: Icon(
                            _obscure
                                ? Icons.visibility_off_rounded
                                : Icons.visibility_rounded,
                            color: Colors.black38,
                          ),
                          onPressed: () {
                            setState(() {
                              _obscure = !_obscure;
                            });
                          },
                        ),
                        focusedBorder: const OutlineInputBorder(
                          borderSide: BorderSide(color: kMaincolor, width: 2),
                        ),
                        enabledBorder: const OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.black38, width: 1.3))),
                    style: textInputDecoration.labelStyle!.copyWith(
                        fontWeight: FontWeight.w500, color: Colors.black),
                    textAlignVertical: TextAlignVertical.center,
                    // validator: (val) {
                    //   // String pattern =
                    //   //     r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$';
                    //   // RegExp regExp = new RegExp(pattern);
                    //   // if (val.isEmpty) {
                    //   //   return 'Masukan Password';
                    //   // }
                    //   // if (!regExp.hasMatch(val)) {
                    //   //   return 'Password harus terdiri dari 8 karakter dan \n kombinasi angka dan huruf';
                    //   // }
                    //   // return null;
                    // },
                    onChanged: (password) {
                      setState(() => this.password = password);
                    },
                    obscureText: _obscure,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    // controller: _textController,
                    cursorColor: kFillColor,
                    decoration: textInputDecoration.copyWith(
                        labelStyle: textInputDecoration.labelStyle!
                            .copyWith(color: Colors.black54, fontSize: 16),
                        labelText: " Konfirmasi Kata Sandi",
                        suffixIcon: IconButton(
                          icon: Icon(
                            _obscure
                                ? Icons.visibility_off_rounded
                                : Icons.visibility_rounded,
                            color: Colors.black38,
                          ),
                          onPressed: () {
                            setState(() {
                              _obscure = !_obscure;
                            });
                          },
                        ),
                        focusedBorder: const OutlineInputBorder(
                          borderSide: BorderSide(color: kMaincolor, width: 2),
                        ),
                        enabledBorder: const OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.black38, width: 1.3))),
                    style: textInputDecoration.labelStyle!.copyWith(
                        fontWeight: FontWeight.w500, color: Colors.black),
                    textAlignVertical: TextAlignVertical.center,
                    // validator: (val) {
                    //   // String pattern =
                    //   //     r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$';
                    //   // RegExp regExp = new RegExp(pattern);
                    //   // if (val.isEmpty) {
                    //   //   return 'Masukan Password';
                    //   // }
                    //   // if (!regExp.hasMatch(val)) {
                    //   //   return 'Password harus terdiri dari 8 karakter dan \n kombinasi angka dan huruf';
                    //   // }
                    //   // return null;
                    // },
                    validator: (val) {
                      if (val != password) {
                        return "Konfirmasi Password tidak cocok";
                      }
                      return null;
                    },
                    onChanged: (val) {
                      setState(() => confirmPassword = val);
                    },
                    obscureText: _obscure,
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  SizedBox(
                    height: 48,
                    width: MediaQuery.of(context).size.width,
                    child: ElevatedButton(
                      clipBehavior: Clip.hardEdge,
                      style: ElevatedButton.styleFrom(
                        primary: kMaincolor,
                      ),
                      child: Text(
                        "Daftar",
                        style: textInputDecoration.labelStyle!.copyWith(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w800),
                      ),
                      onPressed: () {
                        // Navigator.of(context).push(PageRouteBuilder(
                        //     pageBuilder:
                        //         (context, animation, anotherAnimation) =>
                        //             HomeScreen(),
                        //     transitionDuration: Duration(milliseconds: 350),
                        //     transitionsBuilder:
                        //         (context, animation, anotherAnimation, child) {
                        //       // animation = SlideTransition(position: Tween(begin: Off));
                        //       return SlideTransition(
                        //         position: Tween(
                        //                 begin: Offset(1.0, 0.0),
                        //                 end: Offset(0.0, 0.0))
                        //             .animate(animation),
                        //         child: child,
                        //       );
                        //     }));
                        Get.to(() => const PersistenceBottomNavBar());

                        // if (formKey.currentState!.validate()) {
                        //   _SignUp();
                        // }
                      },
                    ),
                  ),
                  SizedBox(
                    child: TextButton(
                        style: ButtonStyle(
                            overlayColor:
                                MaterialStateProperty.all(kFillColor)),
                        onPressed: () {
                          Navigator.of(context).pop();
                          // Get.back();
                          // Get.to(const LoginScreen(),
                          //     duration: const Duration(seconds: 2),
                          //     transition: Transition.cupertino);
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Text('Sudah punya akun?',
                                style: TextStyle(
                                    fontWeight: FontWeight.normal,
                                    color: Colors.black)),
                            Text(
                              'Masuk',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black),
                            )
                          ],
                        )),
                  )
                ]),
          ),
        ),
        Text(
          error,
          style: const TextStyle(color: Colors.red, fontSize: 14.0),
        ),
      ],
    );
  }

  // Widget _loading() {
  //   return Center(child: EasyLoading.show(),);
  // }

  void _signUp() async {
    EasyLoading.show(
        status: 'Loading SignUp',
        dismissOnTap: false,
        indicator: const Center(
            child: SpinKitRipple(
          color: kMaincolor,
          size: 80,
        )));
    var data = {
      'email': email,
      'password': password,
    };

    // var res = await UserAuth().authData(data);
    var res = 'silent';
    var body = json.decode(res);

    if (body['message'] == "SignUp success!") {
      SharedPreferences localData = await SharedPreferences.getInstance();
      // localData.setString('message', 'SignUp success!');
      localData.setString('access_token', json.encode(body['access_token']));
      localData.setString('data', json.encode(body['data']));
      print('$body');

      setState(() {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => const PersistenceBottomNavBar()));
      });
    } else {
      EasyLoading.dismiss();
      _showMsg(body['message']);
    }
    EasyLoading.dismiss();
  }

  void presentLoader(BuildContext context,
      {String textIP = 'Aguarde...',
      String uid = '',
      bool barrierDismissible = true,
      bool error = false,
      bool willPop = true,
      bool success = false,
      List<Widget>? action,
      Widget? elevatedButton,
      // required VoidCallback onPressed,
      TextEditingController? ipEditingText,
      double? value}) {
    showDialog(
        barrierDismissible: barrierDismissible,
        context: context,
        builder: (c) {
          return WillPopScope(
            onWillPop: () async {
              return willPop;
            },
            child: AlertDialog(
              content: SizedBox(
                height: 180,
                width: 240,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'Current IP or Web: \n$textIP',
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Form(
                      key: formKey2,
                      onChanged: () => setState(() {}),
                      child: TextFormField(
                        // autovalidateMode: AutovalidateMode.always,
                        // autovalidate: true,
                        validator: (value) {
                          value!.length < 6
                              // ignore: unnecessary_statements
                              ? 'Number must be at least 8 digits'
                              : // return an error message
                              null;

                          // value!.length < 8
                          //     ? _isEnable = false
                          //     : _isEnable = true;
                        },
                        controller: ipEditingText,
                        cursorColor: kFillColor,
                        decoration: textInputDecoration.copyWith(
                            labelText: "Type here to edit address",
                            labelStyle: textInputDecoration.labelStyle!
                                .copyWith(color: Colors.black54, fontSize: 16),
                            focusedBorder: const OutlineInputBorder(
                              borderSide: BorderSide(
                                color: kMaincolor,
                                width: 2,
                              ),
                            ),
                            enabledBorder: const OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Colors.black38, width: 1.3))),
                        style: textInputDecoration.labelStyle!
                            .copyWith(fontWeight: FontWeight.w500),
                        textAlignVertical: TextAlignVertical.center,
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    ElevatedButton(
                        clipBehavior: Clip.hardEdge,
                        style: ElevatedButton.styleFrom(
                          primary: kFillColor,
                        ),
                        child: Text(
                          "EDIT ADDRESS",
                          style: textInputDecoration.labelStyle!.copyWith(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.w800),
                        ),
                        onPressed: () async {
                          SharedPreferences localData =
                              await SharedPreferences.getInstance();
                          print('saving ip ${ipEditingText!.text}');
                          localData.setString('username', ipEditingText.text);
                        })
                  ],
                ),
              ),
              actions: action,
            ),
          );
        });
  }
}
