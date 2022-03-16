import 'package:flutter/material.dart';

class TextInput extends StatelessWidget {
  TextInput(
      {Key? key,
      required this.controller,
      required this.obscureText,
      this.textInputType})
      : super(key: key);

  final TextEditingController controller;
  final bool obscureText;
  TextInputType? textInputType = TextInputType.text;

  @override
  Widget build(BuildContext context) {
    return TextField(
      scrollPadding: EdgeInsets.zero,
      keyboardType: textInputType,
      controller: controller,
      cursorColor: Colors.white,
      cursorHeight: 15,
      mouseCursor: MouseCursor.uncontrolled,
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
