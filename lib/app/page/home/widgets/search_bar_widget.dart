import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SearchBarWidget extends StatelessWidget {
  final TextEditingController controller;
  final String? hintText;
  SearchBarWidget({
    Key? key,
    required this.controller,
    this.hintText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      cursorHeight: 25,
      autofocus: false,
      textAlignVertical: TextAlignVertical.center,
      style: Theme.of(context).textTheme.headline6!.copyWith(
          fontSize: 18, fontWeight: FontWeight.w400, color: Colors.black),
      cursorRadius: Radius.circular(100.0),
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: Theme.of(context).textTheme.headline1!.copyWith(
            fontSize: 14, fontWeight: FontWeight.w300, color: Colors.black),
        filled: true,
        contentPadding: EdgeInsets.symmetric(horizontal: 20.0),
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
        ),
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: BorderSide(color: Colors.white)),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: BorderSide(color: Colors.white)),
      ),
    );
  }
}
