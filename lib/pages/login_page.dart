import 'package:ecp_user/controller/login_controller.dart';
import 'package:ecp_user/pages/registration_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

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
                'Welcome',
                style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Colors.deepPurple),
              ),
              SizedBox(
                height: 23,
              ),
              TextField(
                controller: ctrl.loginNumberController,
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
                height: 25,
              ),
              ElevatedButton(
                onPressed: () {
                  ctrl.loginWithPhone();
                },
                style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: Colors.deepPurple),
                child: Text('Login'),
              ),
              TextButton(
                onPressed: () {
                  Get.to(
                    RegistrationPage(),
                  );
                },
                child: Text('Register New Account'),
              ),
            ],
          ),
        ),
      );
    });
  }
}
