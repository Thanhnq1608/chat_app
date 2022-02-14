import 'package:flutter/material.dart';

class FormInput extends StatelessWidget {
  final Widget child;
  final String title;
  FormInput({required this.child, required this.title});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: Theme.of(context).textTheme.bodyText1!.copyWith(
              fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),
        ),
        child,
        Divider(
          height: 1,
          color: Colors.white,
        )
      ],
    );
  }
}
