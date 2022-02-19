import 'package:chat_app/app/components/buntton_login_screen.dart';
import 'package:chat_app/app/components/form_input.dart';
import 'package:chat_app/app/components/text_input.dart';
import 'package:chat_app/app/page/login/login_controller.dart';
import 'package:chat_app/app/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginScreen extends GetView<LoginController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black87,
      body: Obx(
        () => controller.isLoading.value
            ? Center(
                child: CircularProgressIndicator(),
              )
            : Column(
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
                    child: InkWell(
                      onTap: () => Get.toNamed(AppRoutes.FORGET_PASS),
                      child: Text(
                        'Forget password?',
                        style: Theme.of(context)
                            .textTheme
                            .bodyText1!
                            .copyWith(color: Colors.white),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  ButtonLoginScreen(
                    title: 'Sign In',
                    backgroundColor: Color(0xFF5157b2),
                    handleButton: () {
                      controller.login(
                        email: controller.emailController.text,
                        password: controller.passwordContoller.text,
                      );
                    },
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  ButtonLoginScreen(
                    title: 'Sign In with Google',
                    backgroundColor: Colors.white,
                    handleButton: () {
                      controller.login(
                        email: controller.emailController.text,
                        password: controller.passwordContoller.text,
                      );
                    },
                  ),
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
                          style:
                              Theme.of(context).textTheme.bodyText1!.copyWith(
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
                controller: controller.passwordContoller,
                obscureText: true,
              ),
              title: 'Password')
        ],
      ),
    );
  }
}
