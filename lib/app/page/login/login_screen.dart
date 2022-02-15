import 'package:chat_app/app/components/form_input.dart';
import 'package:chat_app/app/page/login/login_controller.dart';
import 'package:chat_app/app/page/login/widgets/buntton_login_screen.dart';
import 'package:chat_app/app/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginScreen extends GetView<LoginController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black87,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _body(context),
          SizedBox(
            height: 15,
          ),
          Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(horizontal: 30),
            alignment: Alignment.centerRight,
            child: Text(
              'Forget password?',
              style: Theme.of(context)
                  .textTheme
                  .bodyText1!
                  .copyWith(color: Colors.white),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          ButtonLoginScreen(),
          SizedBox(
            height: 15,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Don\'t have account? ',
                style: Theme.of(context).textTheme.bodyText1!.copyWith(
                      color: Colors.white,
                      fontSize: 15,
                    ),
              ),
              InkWell(
                onTap: () => Get.toNamed(AppRoutes.SIGN_UP),
                child: Text(
                  'Register now',
                  style: Theme.of(context).textTheme.bodyText1!.copyWith(
                        decoration: TextDecoration.underline,
                        color: Colors.white,
                        fontSize: 15,
                      ),
                ),
              )
            ],
          )
        ],
      ),
    );
  }

  Widget _body(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: Column(
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
                controller: controller.passwordContoller,
                obscureText: true,
              ),
              title: 'Password')
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
