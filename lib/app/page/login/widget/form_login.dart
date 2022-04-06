import 'package:chat_app/app/components/text_input.dart';
import 'package:flutter/material.dart';

enum TitleFormType {
  email,
  password,
}

class FormLogin extends StatelessWidget {
  final TextEditingController controller;
  final TextInputType? textInputType;
  IconData icon = Icons.mail;
  final TitleFormType titleType;

  bool autoFocus = false;
  FormLogin(
      {Key? key,
      required this.controller,
      required this.titleType,
      this.autoFocus = false,
      this.textInputType})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.black12,
        borderRadius: BorderRadius.all(
          Radius.circular(20),
        ),
      ),
      margin: EdgeInsets.symmetric(
        vertical: 10,
      ),
      child: ListTile(
        leading: Icon(iconTitle(titleType)),
        minLeadingWidth: 10,
        title: TextInput(
          controller: controller,
          obscureText: titleType == TitleFormType.password ? true : false,
          textInputType: textInputType,
          autoFocus: autoFocus,
        ),
      ),
    );
  }

  IconData iconTitle(TitleFormType type) {
    if (type == TitleFormType.email) {
      return Icons.mail;
    } else {
      return Icons.lock;
    }
  }
}
