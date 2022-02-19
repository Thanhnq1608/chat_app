import 'package:chat_app/app/components/buntton_login_screen.dart';
import 'package:chat_app/app/components/form_input.dart';
import 'package:chat_app/app/components/text_input.dart';
import 'package:chat_app/app/page/forget_pass/forget_password_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ForgetPasswordScreen extends GetView<ForgetPasswordController> {
  const ForgetPasswordScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black87,
      body: Obx(
        () {
          if (controller.isLoading.value) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          if (controller.isClickReset.value) {
            return _notification(context);
          }

          return _body(context);
        },
      ),
    );
  }

  Widget _body(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          FormInput(
            title: 'Email',
            child: TextInput(
              controller: controller.emailController,
              obscureText: false,
              textInputType: TextInputType.emailAddress,
            ),
          ),
          SizedBox(
            height: 30,
          ),
          // FormInput(
          //     child: TextInput(
          //       controller: controller.passController,
          //       obscureText: true,
          //     ),
          //     title: 'Password'),
          //     SizedBox(
          //   height: 20,
          // ),
          // FormInput(
          //     child: TextInput(
          //       controller: controller.passController,
          //       obscureText: true,
          //     ),
          //     title: 'Password'),
          ButtonLoginScreen(
              title: 'Reset password',
              backgroundColor: Color(0xFF5157b2),
              handleButton: () {
                controller.forgotPassword(
                    email: controller.emailController.text);
              }),
          SizedBox(
            height: 20,
          ),
          ButtonLoginScreen(
              title: 'Cancel',
              backgroundColor: Colors.white,
              handleButton: () {
                Get.back();
              }),
        ],
      ),
    );
  }

  Widget _notification(BuildContext context) {
    return Center(
      child: Text(
        'Please check your email to change your password',
        style: Theme.of(context).textTheme.headline5!.copyWith(
              fontSize: 24,
              color: Colors.white,
            ),
      ),
    );
  }
}
