import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kedaireka/screen/home/account/detail_account.dart';
import 'package:kedaireka/theme/constant.dart';

class AccountSetting extends StatefulWidget {
  const AccountSetting({Key? key}) : super(key: key);

  @override
  _AccountSettingState createState() => _AccountSettingState();
}

class _AccountSettingState extends State<AccountSetting> {
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
                'Akun',
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
                  width: Get.width,
                  decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                          topRight: Radius.circular(30),
                          topLeft: Radius.circular(30))),
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
                            style: TextStyle(color: Colors.white, fontSize: 80),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.all(12),
                          child: const Text(
                            'Kedaireka',
                            style: TextStyle(color: kMaincolor, fontSize: 24),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            Get.to(() => const DetailAccount());
                          },
                          child: Container(
                            margin: const EdgeInsets.only(top: 30, bottom: 15),
                            height: 72,
                            width: Get.width / 1.15,
                            decoration: BoxDecoration(
                              color: kFillColor,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Container(
                                        padding:
                                            const EdgeInsets.only(left: 18),
                                        height: 46,
                                        child: Image.asset(
                                            'assets/accounts/icon-info-detail-rounded.png')),
                                    Container(
                                      padding: const EdgeInsets.only(left: 14),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: const [
                                          Text(
                                            'Informasi Akun',
                                            style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w400),
                                          ),
                                          Text(
                                            'Detail Akun Anda',
                                            textAlign: TextAlign.left,
                                            style: TextStyle(
                                                fontSize: 12,
                                                color: Colors.grey,
                                                fontWeight: FontWeight.w400),
                                          )
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                                Container(
                                  padding: const EdgeInsets.only(right: 14),
                                  child: const Icon(
                                    Icons.arrow_forward_ios_rounded,
                                    color: Colors.grey,
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {},
                          child: Container(
                            margin: const EdgeInsets.only(bottom: 15),
                            height: 72,
                            width: Get.width / 1.15,
                            decoration: BoxDecoration(
                              color: Colors.yellow.shade100,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Container(
                                        padding:
                                            const EdgeInsets.only(left: 18),
                                        height: 46,
                                        child: Image.asset(
                                            'assets/accounts/icon-security-rounded.png')),
                                    Container(
                                      padding: const EdgeInsets.only(left: 14),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: const [
                                          Text(
                                            'Kata Sandi',
                                            style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w400),
                                          ),
                                          Text(
                                            'Pengaturan Kata Sandi',
                                            textAlign: TextAlign.left,
                                            style: TextStyle(
                                                fontSize: 12,
                                                color: Colors.grey,
                                                fontWeight: FontWeight.w400),
                                          )
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                                Container(
                                  padding: const EdgeInsets.only(right: 14),
                                  child: const Icon(
                                    Icons.arrow_forward_ios_rounded,
                                    color: Colors.grey,
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {},
                          child: Container(
                            margin: const EdgeInsets.only(bottom: 15),
                            height: 72,
                            width: Get.width / 1.15,
                            decoration: BoxDecoration(
                              color: Colors.red.shade50,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Container(
                                        padding:
                                            const EdgeInsets.only(left: 18),
                                        height: 46,
                                        child: Image.asset(
                                            'assets/accounts/icon-logout-rounded.png')),
                                    Container(
                                      padding: const EdgeInsets.only(left: 14),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: const [
                                          Text(
                                            'Keluar',
                                            style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w400),
                                          ),
                                          Text(
                                            'Keluar dari Akun Anda',
                                            textAlign: TextAlign.left,
                                            style: TextStyle(
                                                fontSize: 12,
                                                color: Colors.grey,
                                                fontWeight: FontWeight.w400),
                                          )
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                                Container(
                                  padding: const EdgeInsets.only(right: 14),
                                  child: const Icon(
                                    Icons.arrow_forward_ios_rounded,
                                    color: Colors.grey,
                                  ),
                                )
                              ],
                            ),
                          ),
                        )
                      ])),
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
