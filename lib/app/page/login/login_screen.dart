import 'package:chat_app/app/components/buntton_login_screen.dart';
import 'package:chat_app/app/components/form_input.dart';
import 'package:chat_app/app/components/text_input.dart';
import 'package:chat_app/app/page/login/login_controller.dart';
import 'package:chat_app/app/page/login/widget/form_login.dart';
import 'package:chat_app/app/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginScreen extends GetView<LoginController> {
  void onclickEnter() {}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black87,
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/bg_login.jpg'),
            colorFilter: new ColorFilter.mode(
                Colors.white.withOpacity(0.8), BlendMode.dstATop),
            fit: BoxFit.cover,
          ),
        ),
        child: Obx(
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
                    Padding(
                      padding: const EdgeInsets.only(
                        right: 20,
                      ),
                      child: Align(
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
                      onclickEnterKey: () => controller.login(
                        email: controller.emailController.text,
                        password: controller.passwordContoller.text,
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      width: 40,
                      height: 40,
                      padding: EdgeInsets.all(5.0),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white,
                      ),
                      child: CircleAvatar(
                        backgroundImage: AssetImage(
                          'assets/images/logo_google.png',
                        ),
                        backgroundColor: Colors.white,
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Don\'t have account? ',
                          style:
                              Theme.of(context).textTheme.bodyText1!.copyWith(
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
      ),
    );
  }

  Widget _body(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: Column(
        children: [
          FormLogin(
            controller: controller.emailController,
            titleType: TitleFormType.email,
          ),
          SizedBox(
            height: 20,
          ),
          FormLogin(
            controller: controller.passwordContoller,
            titleType: TitleFormType.password,
          )
        ],
      ),
    );
  }
}
