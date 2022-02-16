import 'package:chat_app/app/components/form_input.dart';
import 'package:chat_app/app/page/create_account/sign_up_controller.dart';
import 'package:chat_app/app/page/create_account/widgets/buntton_login_screen.dart';
import 'package:chat_app/app/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignUpScreen extends GetView<SignUpController> {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black87,
      body: Obx(
        () => controller.isLoading.value
            ? Center(
                child: CircularProgressIndicator(),
              )
            : _body(context),
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
            child: _textFeild(
              context,
              controller: controller.emailController,
              obscureText: false,
            ),
          ),
          SizedBox(
            height: 20,
          ),
          FormInput(
              child: _textFeild(
                context,
                controller: controller.passController,
                obscureText: true,
              ),
              title: 'Password'),
          SizedBox(
            height: 20,
          ),
          FormInput(
              child: _textFeild(
                context,
                controller: controller.rePassController,
                obscureText: true,
              ),
              title: 'Password'),
          SizedBox(
            height: 30,
          ),
          ButtonLoginScreen(
            clickToSignUp: () async {
              final result = await controller.signUp();
              if (result) {
                Get.snackbar('', 'Sign up success');
                Get.toNamed(AppRoutes.LOGIN);
              }
            },
          ),
        ],
      ),
    );
  }

  TextField _textFeild(BuildContext context,
      {required TextEditingController controller,
      required bool obscureText,
      TextInputType textInputType = TextInputType.text}) {
    return TextField(
      scrollPadding: EdgeInsets.zero,
      keyboardType: textInputType,
      controller: controller,
      cursorColor: Colors.white,
      cursorHeight: 15,
      style: Theme.of(context)
          .textTheme
          .bodyText1!
          .copyWith(fontSize: 22, color: Colors.white70),
      decoration: InputDecoration(
        border: InputBorder.none,
      ),
      obscureText: obscureText,
      enableSuggestions: false,
      autocorrect: false,
    );
  }
}
