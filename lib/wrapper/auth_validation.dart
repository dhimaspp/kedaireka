import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kedaireka/screen/auth/login.dart';
import 'package:kedaireka/widgets/persistence_bottom_nav.dart';
import 'package:kedaireka/core/auth_manager.dart';

class AuthValidation extends StatelessWidget {
  const AuthValidation({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AuthenticationManager _authManager = Get.find();
    return Obx(() {
      return _authManager.isLogged.value
          ? const PersistenceBottomNavBar()
          : const LoginScreen();
    });
  }
}
