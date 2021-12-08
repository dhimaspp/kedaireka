// ignore_for_file: use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:kedaireka/theme/constant.dart';
import 'package:kedaireka/core/auth_manager.dart';
import 'package:kedaireka/wrapper/auth_validation.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  await SentryFlutter.init(
    (options) {
      options.dsn =
          'https://357d1fde2a684565998fc72f32622c88@o883076.ingest.sentry.io/6088650';
      // Set tracesSampleRate to 1.0 to capture 100% of transactions for performance monitoring.
      // We recommend adjusting this value in production.
      options.tracesSampleRate = 1.0;
    },
    appRunner: () => runApp(MyApp()),
  );

  // runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final AuthenticationManager _authmanager = Get.put(AuthenticationManager());

  Future<void> initializeSettings() async {
    _authmanager.checkLoginStatus();
  }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      builder: EasyLoading.init(),
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: themePP,
      home: FutureBuilder(
          future: initializeSettings(),
          builder: (context, snapshot) {
            return const AuthValidation();
          }),
    );
  }
}
