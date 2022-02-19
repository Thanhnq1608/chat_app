import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ButtonLoginScreen extends StatelessWidget {
  Function() handleButton;
  String title;
  Color backgroundColor;
  ButtonLoginScreen(
      {Key? key,
      required this.handleButton,
      required this.backgroundColor,
      required this.title})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: ElevatedButton(
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
                color: backgroundColor == Colors.white
                    ? Colors.black
                    : Colors.white,
              ),
        ),
      ),
    );
  }
}
