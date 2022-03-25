import 'package:flutter/material.dart';

class TextInputMessage extends StatelessWidget {
  final TextEditingController controller;
  final Function()? onClickSend;
  TextInputMessage(
      {Key? key, required this.controller, required this.onClickSend})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.symmetric(
        horizontal: 10.0,
        vertical: 10.0,
      ),
      height: 70,
      child: Row(
        children: [
          Expanded(
            child: TextFormField(
              controller: controller,
              cursorHeight: 20,
              textAlignVertical: TextAlignVertical.bottom,
              style: Theme.of(context).textTheme.headline1!.copyWith(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  color: Colors.black),
              cursorRadius: Radius.circular(100.0),
              decoration: InputDecoration(
                  hintText: 'Aa',
                  hintStyle: Theme.of(context).textTheme.headline1!.copyWith(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      color: Colors.black54),
                  filled: true,
                  fillColor: Colors.black12,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(100.0),
                  ),
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(100.0),
                      borderSide: BorderSide(color: Colors.white)),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(100.0),
                      borderSide: BorderSide(color: Colors.white)),
                  errorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(100.0),
                      borderSide: BorderSide(color: Colors.white))),
            ),
          ),
          IconButton(
            onPressed: onClickSend,
            icon: Icon(Icons.send),
            hoverColor: Colors.red,
            color: Colors.blue[400],
          )
        ],
      ),
    );
  }
}
