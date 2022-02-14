import 'package:flutter/material.dart';

class ButtonLoginScreen extends StatelessWidget {
  const ButtonLoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: Column(
        children: [
          _button(
            context,
            handleButton: () {},
            title: 'Sign In',
            backgroundColor: Color(0xFF5157b2),
          ),
          SizedBox(
            height: 30,
          ),
          _button(
            context,
            handleButton: () {},
            title: 'Sign In with Google',
            backgroundColor: Colors.white,
          ),
        ],
      ),
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
