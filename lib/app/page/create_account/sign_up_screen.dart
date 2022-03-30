import 'package:chat_app/app/components/form_input.dart';
import 'package:chat_app/app/components/loading_indicator.dart';
import 'package:chat_app/app/components/text_input.dart';
import 'package:chat_app/app/page/create_account/sign_up_controller.dart';
import 'package:chat_app/app/components/buntton_login_screen.dart';
import 'package:chat_app/app/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignUpScreen extends GetView<SignUpController> {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appbar(context),
      backgroundColor: Colors.black87,
      body: Obx(
        () => controller.isLoading.value
            ? Center(
                child: LoadingIndicator(),
              )
            : _body(context),
      ),
    );
  }

  Widget _body(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: Center(
        child: ListView(
          shrinkWrap: true,
          children: [
            FormInput(
              title: 'Name',
              child: TextInput(
                controller: controller.nameController,
                obscureText: false,
              ),
            ),
            SizedBox(
              height: 20,
            ),
            FormInput(
              title: 'Email',
              child: TextInput(
                controller: controller.emailController,
                obscureText: false,
              ),
            ),
            SizedBox(
              height: 20,
            ),
            FormInput(
                child: TextInput(
                  controller: controller.passController,
                  obscureText: true,
                ),
                title: 'Password'),
            SizedBox(
              height: 20,
            ),
            FormInput(
                child: TextInput(
                  controller: controller.rePassController,
                  obscureText: true,
                ),
                title: 'Password'),
            SizedBox(
              height: 30,
            ),
            ButtonLoginScreen(
              title: 'Sign Up',
              backgroundColor: Color(0xFF5157b2),
              handleButton: () async {
                final result = await controller.signUp();
                if (result) {
                  Get.snackbar('', 'Sign up success');
                  Get.toNamed(AppRoutes.LOGIN);
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  AppBar _appbar(BuildContext context) {
    return AppBar(
      elevation: 0,
      backgroundColor: Colors.transparent,
      leading: IconButton(
        icon: Icon(
          Icons.arrow_back_ios_new_rounded,
          color: Colors.white,
        ),
        onPressed: () => Get.back(),
      ),
    );
  }
}
