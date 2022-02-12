import 'package:flutter/material.dart';

class ListMessage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(50),
          topRight: Radius.circular(50),
        ),
      ),
      child: ListView.separated(
        itemBuilder: (context, index) {
          return Container();
        },
        separatorBuilder: (_, index) => SizedBox(
          height: 20,
        ),
        itemCount: 3,
      ),
    );
  }
}
