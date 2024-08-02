import 'package:ecp_user/controller/home_controller.dart';
import 'package:ecp_user/controller/login_controller.dart';
import 'package:ecp_user/controller/purches_controller.dart';
import 'package:ecp_user/firebase_options.dart';
// import 'package:ecp_user/pages/home_page.dart';
import 'package:ecp_user/pages/registration_page.dart';
import 'package:firebase_core/firebase_core.dart';
// import 'package:ecp_user/pages/product_description_page.dart';
// import 'package:ecp_user/pages/registration_page.dart';
// import 'package:ecp_user/pages/login_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

void main() async {
  await GetStorage.init();
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: firebaseOptions);
  Get.put(LoginController());
  Get.put(HomeController());
  Get.put(PurchesController());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: RegistrationPage(),
    );
  }
}
