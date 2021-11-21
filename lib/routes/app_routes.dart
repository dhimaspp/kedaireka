// // ignore_for_file: constant_identifier_names

// import 'package:get/get.dart';
// import 'package:kedaireka/screen/auth/login.dart';
// import 'package:kedaireka/screen/auth/signup.dart';
// import 'package:kedaireka/screen/home/account/account_setting.dart';
// import 'package:kedaireka/screen/home/account/change_password.dart';
// import 'package:kedaireka/screen/home/account/detail_account.dart';
// import 'package:kedaireka/screen/home/desease_analyze/takePicture.dart';
// import 'package:kedaireka/screen/home/instruksi_screen.dart';

// abstract class Routes {
//   static const LOGIN = '/LoginScreen';
//   static const SIGNUP = '/SignUpScreen';
//   static const ACCOUNTSETTING = '/AccountSetting';
//   static const ACCOUNTDETAIL = '/DetailAccount';
//   static const CHANGEPASSWORD = '/ChangePassword';
//   static const INSTRUKSISCREEN = '/InstruksiScreen';
//   static const TAKEPICTURE = '/TakePictureScreen';
// }

// class AppPages {
//   static const INITIAL = Routes.LOGIN;

//   static final routes = [
//     GetPage(
//         name: Routes.LOGIN,
//         page: () => HomeView(),
//         binding: HomeBinding(),
//         children: [
//           GetPage(
//             name: Routes.COUNTRY,
//             page: () => CountryView(),
//             children: [
//               GetPage(
//                 name: Routes.DETAILS,
//                 page: () => DetailsView(),
//               ),
//             ],
//           ),
//         ]),
//   ];
// }