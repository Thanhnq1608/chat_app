import 'package:chat_app/core/models/user.dart';

var users = User.generateUsers();

class Message {
  User user;
  String lastMessage;
  String lastTime;
  bool isContinue;

  Message(
      {required this.lastMessage,
      this.isContinue = false,
      required this.lastTime,
      required this.user});

  static List<Message> generateMessage() {
    return [
      Message(
        lastMessage: 'I am working in my company',
        lastTime: '18:32',
        user: users[0],
      ),
      Message(
        lastMessage: 'I stay in my house',
        lastTime: '12:32',
        user: users[1],
      ),
      Message(
        lastMessage: 'I am a doctor',
        lastTime: '08:32',
        user: users[2],
      ),
      Message(
        lastMessage: 'Where are you now?',
        lastTime: '10:32',
        user: users[3],
      ),
      Message(
        lastMessage: 'How do you fell?',
        lastTime: '05:32',
        user: users[4],
      ),
      Message(
        lastMessage: 'I am working in me company',
        lastTime: '18:32',
        user: users[5],
      ),
      Message(
        lastMessage: 'I am working in me company',
        lastTime: '18:32',
        user: users[6],
      ),
    ];
  }
}
