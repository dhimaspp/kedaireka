// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:kedaireka/repository/auth/auth_api.dart';
import 'package:kedaireka/theme/constant.dart';
import 'package:kedaireka/widgets/persistence_bottom_nav.dart';

class AuthenticationManager extends GetxController {
  late final AuthApi _authApi;
  final isLogged = false.obs;

  @override
  void onInit() {
    super.onInit();
    _authApi = Get.put(AuthApi());
  }

  Future<void> userLogin(String email, String password) async {
    final response = await _authApi.getAccess(email, password);

    if (response == 'login sukses') {
      print('login success');
      isLogged.value = true;
      Get.to(() => const PersistenceBottomNavBar());
    } else {
      Get.defaultDialog(
          middleText: response,
          textConfirm: 'OK',
          confirmTextColor: Colors.white,
          buttonColor: kMaincolor,
          onConfirm: () {
            Get.back();
          });
    }
  }

  Future<void> userRegister(String email, String password, String nama) async {
    final response = await _authApi.userRegistration(email, password, nama);

    if (response == 'register sukses') {
      print('register success');
      // await userLogin(email, password);
      // isLogged.value = true;
    } else {
      Get.defaultDialog(
          middleText: response,
          textConfirm: 'OK',
          confirmTextColor: Colors.white,
          buttonColor: kMaincolor,
          onConfirm: () {
            Get.back();
          });
    }
  }

  Future<void> userLogout() async {
    isLogged.value = false;
    final localStorage = GetStorage();
    await localStorage.remove('token');
    await localStorage.remove('email');
    await localStorage.remove('name');
    print('logout success');
  }

  void checkLoginStatus() {
    final localStorage = GetStorage();
    final token = localStorage.read('token');
    print('local token = $token');
    if (token != null) {
      isLogged.value = true;
    }
  }
}
