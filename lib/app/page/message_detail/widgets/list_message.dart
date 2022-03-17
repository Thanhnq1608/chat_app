import 'package:flutter/material.dart';

class ListMessage extends StatelessWidget {
  final List<Map<String, dynamic>> messages;

  ListMessage({required this.messages});

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

  Widget _item(BuildContext context, Map<String, dynamic> message){
    return Container(
      child: Column(
        children: [
          Text(message['sender'], style: Theme.of(context).textTheme.headline6!.copyWith(),),
          Container(
            width: MediaQuery.of(context).size.width * 0.8,
            decoration: BoxDecoration(color: Colors.blue, borderRadius: BorderRadius.all(Radius.circular(50.0),),),
            child: Text(message['text'], style: Theme.of(context).textTheme.headline6!.copyWith(
              color: Colors.white,
            ),),
          )
        ],
      ),
    );
  }
}
