import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ButtonLoginScreen extends StatelessWidget {
  const ButtonLoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _button(
          context,
          handleButton: () {},
          title: 'Sign Up',
          backgroundColor: Color(0xFF5157b2),
        ),
        SizedBox(
          height: 20,
        ),
        _button(
          context,
          handleButton: () {
            Get.back();
          },
          title: 'Cancel',
          backgroundColor: Colors.white,
        ),
      ],
    );
  }

  ElevatedButton _button(
    BuildContext context, {
    required Function() handleButton,
    required String title,
    required Color backgroundColor,
  }) {
    return ElevatedButton(
      onPressed: handleButton,
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(30))),
        minimumSize: Size(double.infinity, 50),
        primary: backgroundColor,
        elevation: 5,
      ),
      child: Text(
        title,
        style: Theme.of(context).textTheme.bodyText1!.copyWith(
              fontSize: 20,
              color:
                  backgroundColor == Colors.white ? Colors.black : Colors.white,
            ),
      ),
    );
  }
}
