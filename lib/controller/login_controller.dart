import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecp_user/model/user/user.dart';
import 'package:ecp_user/pages/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:otp_text_field_v2/otp_text_field_v2.dart';

class LoginController extends GetxController {
  GetStorage box = GetStorage();
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  late CollectionReference userCollection;
  TextEditingController registerNameController = TextEditingController();
  TextEditingController registerNumberController = TextEditingController();
  TextEditingController loginNumberController = TextEditingController();
  OtpFieldControllerV2 otpController = OtpFieldControllerV2();
  bool otpFieldShow = false;
  int? otpSend;
  int? otpEnter;

  User? loginUser;

  @override
  void onReady() {
    Map<String, dynamic>? user = box.read('loginUser');
    if (user != null) {
      loginUser = User.fromJson(user);
      Get.to(
        HomePage(),
      );
    }
    // TODO: implement onReady
    super.onReady();
  }

  @override
  void onInit() {
    userCollection = firestore.collection('users');
    // TODO: implement onInit
    super.onInit();
  }

  addUser() {
    try {
      if (otpSend == otpEnter) {
        DocumentReference doc = userCollection.doc();
        User user = User(
          id: doc.id,
          name: registerNameController.text,
          number: double.parse(registerNumberController.text),
        );
        final userJson = user.toJson();
        doc.set(userJson);
        Get.snackbar('Success', 'User added Successfully',
            colorText: Colors.green);
        registerNameController.clear();
        registerNumberController.clear();
        otpController.clear();
      } else {
        Get.snackbar('Error', 'OTP is incorrect', colorText: Colors.red);
      }

      // setValueDefault();
    } catch (e) {
      Get.snackbar('Error', e.toString(), colorText: Colors.red);
      print(e);
    }
  }

  sendOtp() async {
    try {
      if (registerNameController.text.isEmpty ||
          registerNumberController.text.isEmpty) {
        Get.snackbar('Error', 'Please fill the field', colorText: Colors.red);
        return;
      }
      final random = Random();
      int otp = 1000 + random.nextInt(9000);
      // String mobileNumber = registerNumberController.text;
      // String url =
      //     'https://sysadmin.muthobarta.com/api/v1/send-sms-get?token=a33a262866bbd77861411f6a94f0d667f36d797f&sender_id=$otp&receiver=$mobileNumber&message=This is a test message %26 SMS&remove_duplicate=true';
      // Response response = await GetConnect().get(url);
      print(otp);
// response.body['message'][0] == 'SMS sent successfully'
      if (otp != null) {
        otpFieldShow = true;
        otpSend = otp;
        Get.snackbar('Success', 'OTP send successfully',
            colorText: Colors.green);
      } else {
        Get.snackbar('error', 'OTP not send', colorText: Colors.red);
      }
    } catch (e) {
      print(e);
    } finally {
      update();
    }
  }

  Future<void> loginWithPhone() async {
    try {
      String phoneNumber = loginNumberController.text;
      if (phoneNumber.isNotEmpty) {
        var querySnapshot = await userCollection
            .where('number', isEqualTo: double.tryParse(phoneNumber))
            .limit(1)
            .get();
        if (querySnapshot.docs.isNotEmpty) {
          var userDoc = querySnapshot.docs.first;
          var userData = userDoc.data() as Map<String, dynamic>;
          box.write('loginUser', userData);
          loginNumberController.clear();
          Get.to(
            HomePage(),
          );
          Get.snackbar('Success', 'Login Successfull', colorText: Colors.green);
        } else {
          Get.snackbar('Error', 'User Not Found, Please register',
              colorText: Colors.red);
        }
      } else {
        Get.snackbar('Error', 'Please enter a Phoine number',
            colorText: Colors.red);
      }
    } catch (error) {
      print('Failed to Login,$error');
    }
  }
}
