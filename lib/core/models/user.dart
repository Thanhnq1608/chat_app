import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class User {
  int id;
  String name;
  Color userColor;
  User({required this.id, required this.name, required this.userColor});

  static List<User> generateUsers() {
    return [
      User(id: 1, name: 'Thanh', userColor: Colors.deepPurpleAccent),
      User(id: 2, name: 'Hoang Anh', userColor: Colors.blueAccent),
      User(id: 3, name: 'Nam', userColor: Colors.amberAccent),
      User(id: 4, name: 'Bich', userColor: Colors.cyan),
      User(id: 5, name: 'Dat', userColor: Colors.brown),
      User(id: 6, name: 'Nghia', userColor: Colors.greenAccent),
      User(id: 7, name: 'Hung', userColor: Colors.indigo),
    ];
  }
}
