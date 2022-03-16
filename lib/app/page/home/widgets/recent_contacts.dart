import 'package:chat_app/core/models/user.dart';
import 'package:flutter/material.dart';

class RecentContacts extends StatelessWidget {
  final contacts = User.generateUsers();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      padding: EdgeInsets.zero,
      margin: EdgeInsets.zero,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          ElevatedButton(
            onPressed: () {},
            child: Icon(
              Icons.search,
              size: 28,
            ),
            style: ElevatedButton.styleFrom(
                minimumSize: Size(50, 50),
                elevation: 0,
                padding: EdgeInsets.zero,
                onPrimary: Colors.white,
                primary: Colors.white.withOpacity(0.3),
                shape: CircleBorder()),
          ),
          SizedBox(
            width: 15,
          ),
          Expanded(
            child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  var color = contacts[index].userColor;
                  return Container(
                    height: 50,
                    width: 50,
                    padding: EdgeInsets.all(10),
                    decoration:
                        BoxDecoration(color: color, shape: BoxShape.circle),
                    child: CircleAvatar(
                      backgroundImage: AssetImage(contacts[index].avatar),
                    ),
                  );
                },
                separatorBuilder: (_, index) => SizedBox(
                      width: 15,
                    ),
                itemCount: contacts.length),
          )
        ],
      ),
    );
  }
}
