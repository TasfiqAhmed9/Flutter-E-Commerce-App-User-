import 'package:ecp_user/controller/login_controller.dart';
import 'package:ecp_user/pages/login_page.dart';
import 'package:ecp_user/widgets/otp_text_field.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RegistrationPage extends StatelessWidget {
  const RegistrationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<LoginController>(builder: (ctrl) {
      return Scaffold(
        body: Container(
          width: double.maxFinite,
          padding: EdgeInsets.all(20),
          // decoration: BoxDecoration(color: Colors.blueGrey),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Create New Account',
                style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Colors.deepPurple),
              ),
              SizedBox(
                height: 20,
              ),
              TextField(
                controller: ctrl.registerNameController,
                keyboardType: TextInputType.phone,
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    prefixIcon: Icon(Icons.phone_android),
                    labelText: 'Your Name',
                    hintText: 'Enter your Name'),
              ),
              SizedBox(
                height: 20,
              ),
              TextField(
                controller: ctrl.registerNumberController,
                keyboardType: TextInputType.phone,
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    prefixIcon: Icon(Icons.phone_android),
                    labelText: 'Mobile Number',
                    hintText: 'Enter your Mobile number'),
              ),
              SizedBox(
                height: 20,
              ),
              OtpTextField(
                otpController: ctrl.otpController,
                visble: ctrl.otpFieldShow,
                onComplete: (otp) {
                  ctrl.otpEnter = int.tryParse(otp ?? '0000');
                },
              ),
              SizedBox(
                height: 20,
              ),
              ElevatedButton(
                onPressed: () {
                  if (ctrl.otpFieldShow) {
                    ctrl.addUser();
                  } else {
                    ctrl.sendOtp();
                  }
                },
                style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: Colors.deepPurple),
                child: Text(ctrl.otpFieldShow ? 'Register' : 'Send OTP'),
              ),
              TextButton(
                onPressed: () {
                  Get.to(
                    LoginPage(),
                  );
                },
                child: Text('Login'),
              ),
            ],
          ),
        ),
      );
    });
  }
}
