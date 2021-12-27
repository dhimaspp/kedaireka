// ignore_for_file: avoid_print, prefer_final_fields

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:kedaireka/screen/auth/signup.dart';
import 'package:kedaireka/theme/constant.dart';
import 'package:kedaireka/widgets/exit_transition.dart';
import 'package:kedaireka/widgets/persistence_bottom_nav.dart';

import 'package:kedaireka/core/auth_manager.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  AuthenticationManager _loginInitiative = Get.put(AuthenticationManager());
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final formKey = GlobalKey<FormState>();
  final formKey2 = GlobalKey<FormState>();
  final _textController = TextEditingController();
  bool loading = false;
  String email = '';
  String password = '';
  String error = '';
  bool _obscure = true;
  bool back = false;

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
    return WillPopScope(
      onWillPop: () {
        showDialog<bool>(
          context: context,
          builder: (c) => AlertDialog(
            title: const Text('Keluar'),
            content: const Text(
              'Anda ingin keluar aplikasi?',
            ),
            actions: [
              TextButton(
                child: const Text(
                  'Yes',
                  style: TextStyle(color: Colors.black),
                ),
                onPressed: () => exit(0),
              ),
              TextButton(
                child: const Text('No', style: TextStyle(color: Colors.black)),
                onPressed: () => Navigator.pop(c, false),
              ),
            ],
          ),
        );
        return Future.value(back);
      },
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: SizedBox(
            height: MediaQuery.of(context).size.height,
            child: Stack(
              // fit: StackFit.expand,
              alignment: AlignmentDirectional.topCenter,
              children: <Widget>[
                // Container(
                //   height: 261,
                //   color: kFillColor,
                // ),
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
                    'Masuk',
                    style: TextStyle(
                        fontSize: 16,
                        color: Colors.black,
                        fontWeight: FontWeight.w500),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.fromLTRB(0, 380, 0, 0),
                  child: formLogin(),
                ),
              ],
              // clipBehavior: Clip.hardEdge,
              // overflow: Overflow.visible,
            ),
          ),
        ),
      ),
    );
  }

  Widget formLogin() {
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
                        labelText: "Email",
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
                        return 'Masukan Email';
                      }
                      if (val.length < 3) {
                        return 'Username Harus lebih dari \n 3 karakter';
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
                    cursorColor: Colors.black,
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
                    validator: (val) {
                      //   // String pattern =
                      //   //     r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$';
                      //   // RegExp regExp = new RegExp(pattern);
                      if (val!.isEmpty) {
                        return 'Masukan Password';
                      }
                      //   // if (!regExp.hasMatch(val)) {
                      //   //   return 'Password harus terdiri dari 8 karakter dan \n kombinasi angka dan huruf';
                      //   // }
                      //   // return null;
                    },
                    onChanged: (password) {
                      setState(() => this.password = password);
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
                        "Masuk",
                        style: textInputDecoration.labelStyle!.copyWith(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w800),
                      ),
                      onPressed: () async {
                        if (formKey.currentState?.validate() ?? false) {
                          EasyLoading.show();

                          await _loginInitiative
                              .userLogin(email, password)
                              .whenComplete(() async {
                            final localStorage = GetStorage();
                            await localStorage.write('email', email);
                          });
                          EasyLoading.dismiss();
                        }
                      },
                    ),
                  ),
                  SizedBox(
                    child: TextButton(
                        style: ButtonStyle(
                            overlayColor:
                                MaterialStateProperty.all(kFillColor)),
                        onPressed: () {
                          Navigator.of(context).push(EnterExitRoute(
                              exitPage: const LoginScreen(),
                              enterPage: const SignUpScreen()));
                          // Get.to(
                          //   const SignUpScreen(),
                          //   // duration: const Duration(seconds: 2),
                          //   // transition: Transition.cupertino
                          // );
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Text('Belum punya akun?',
                                style: TextStyle(
                                    fontWeight: FontWeight.normal,
                                    color: Colors.black)),
                            Text(
                              'Daftar',
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

  // void _login() async {
  //   EasyLoading.show(
  //       status: 'Loading login',
  //       dismissOnTap: false,
  //       indicator: const Center(
  //           child: SpinKitRipple(
  //         color: kMaincolor,
  //         size: 80,
  //       )));
  //   var data = {
  //     'username': username,
  //     'password': password,
  //   };

  //   // var res = await UserAuth().authData(data);
  //   var res = 'silent';
  //   var body = json.decode(res);

  //   if (body['message'] == "Login success!") {
  //     SharedPreferences localData = await SharedPreferences.getInstance();
  //     // localData.setString('message', 'Login success!');
  //     localData.setString('access_token', json.encode(body['access_token']));
  //     localData.setString('data', json.encode(body['data']));
  //     print('$body');

  //     setState(() {
  //       Navigator.push(
  //           context,
  //           MaterialPageRoute(
  //               builder: (context) => const PersistenceBottomNavBar()));
  //     });
  //   } else {
  //     EasyLoading.dismiss();
  //     _showMsg(body['message']);
  //   }
  //   EasyLoading.dismiss();
  // }

}
