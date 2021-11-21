import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kedaireka/theme/constant.dart';

class ChangePassword extends StatefulWidget {
  const ChangePassword({Key? key}) : super(key: key);

  @override
  _ChangePasswordState createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  TextEditingController kataSandiLamaController = TextEditingController();
  TextEditingController kataSandiBaruController = TextEditingController();
  String? kataSandiLama, kataSandiBaru, konfirmasiKataSandi;

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
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: []),
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
