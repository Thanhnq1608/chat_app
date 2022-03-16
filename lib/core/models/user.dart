import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class User {
  int id;
  String name;
  Color userColor;
  String avatar;
  User(
      {required this.id,
      required this.name,
      required this.userColor,
      required this.avatar});

  static List<User> generateUsers() {
    return [
      User(
          id: 1,
          name: 'Thanh',
          userColor: Colors.deepPurpleAccent,
          avatar: 'assets/images/user1.jpg'),
      User(
          id: 2,
          name: 'Hoang Anh',
          userColor: Colors.blueAccent,
          avatar: 'assets/images/user2.png'),
      User(
          id: 3,
          name: 'Nam',
          userColor: Colors.amberAccent,
          avatar: 'assets/images/user3.jpg'),
      User(
          id: 4,
          name: 'Bich',
          userColor: Colors.cyan,
          avatar: 'assets/images/user4.jpg'),
      User(
          id: 5,
          name: 'Dat',
          userColor: Colors.brown,
          avatar: 'assets/images/user5.jpg'),
      User(
          id: 6,
          name: 'Nghia',
          userColor: Colors.greenAccent,
          avatar: 'assets/images/user6.jpg'),
      User(
          id: 7,
          name: 'Hung',
          userColor: Colors.indigo,
          avatar: 'assets/images/user7.jpg'),
    ];
  }
}
