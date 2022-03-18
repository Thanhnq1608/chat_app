import 'package:chat_app/data/models/message.dart';
import 'package:flutter/material.dart';

class ListMessage extends StatelessWidget {
  final List<Message> messages;
  final String currentUser;

  ListMessage({required this.messages, required this.currentUser});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        shape: BoxShape.rectangle,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(50),
          topRight: Radius.circular(50),
        ),
      ),
      child: ListView.separated(
        reverse: true,
        padding: EdgeInsets.symmetric(horizontal: 10.0),
        itemBuilder: (context, index) {
          var message = messages[index];
          return _item(context, message);
        },
        separatorBuilder: (_, index) => SizedBox(
          height: 10,
        ),
        itemCount: messages.length,
      ),
    );
  }

  Widget _item(BuildContext context, Message message) {
    bool isMe = message.sender == currentUser;
    return Container(
      child: Column(
        crossAxisAlignment:
            isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          Text(
            message.sender,
            style: Theme.of(context).textTheme.headline6!.copyWith(
                  color: Colors.black54,
                  fontSize: 10,
                ),
          ),
          Container(
            constraints: BoxConstraints(
                maxWidth: MediaQuery.of(context).size.width * 0.8),
            padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
            decoration: BoxDecoration(
              color: isMe ? Colors.blue : Colors.black12.withOpacity(0.1),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(20.0),
                topLeft: isMe ? Radius.circular(20.0) : Radius.circular(0.0),
                bottomRight: Radius.circular(20.0),
                topRight: isMe ? Radius.circular(0.0) : Radius.circular(20.0),
              ),
            ),
            child: Text(
              message.message,
              style: Theme.of(context).textTheme.headline6!.copyWith(
                    color: isMe ? Colors.white : Colors.black,
                  ),
            ),
          )
        ],
      ),
    );
  }
}
