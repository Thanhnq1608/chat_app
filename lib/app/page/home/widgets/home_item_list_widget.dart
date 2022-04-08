import 'package:chat_app/data/models/recent_contact.dart';
import 'package:chat_app/data/models/user.dart';
import 'package:flutter/material.dart';

class HomeItemListWidget extends StatelessWidget {
  final RecentContact recentContact;
  final String senderName;
  HomeItemListWidget({
    Key? key,
    required this.recentContact,
    required this.senderName,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: [
          recentContact.avatar == null
              ? Container(
                  height: 60,
                  width: 60,
                  decoration: BoxDecoration(
                    color: Colors.transparent,
                    // shape: BoxShape.circle,
                    image: DecorationImage(
                        image: AssetImage(
                            'assets/images/avatar_default_icon.png')),
                    borderRadius: BorderRadius.all(
                      Radius.circular(50),
                    ),
                  ),
                )
              : Container(
                  height: 60,
                  width: 60,
                  decoration: BoxDecoration(
                    color: Colors.transparent,
                    // shape: BoxShape.circle,
                    borderRadius: BorderRadius.all(
                      Radius.circular(50),
                    ),
                  ),
                  child: ClipOval(
                    child: FadeInImage(
                      fit: BoxFit.cover,
                      image: NetworkImage(recentContact.avatar!),
                      placeholder:
                          AssetImage('assets/images/image_loading.gif'),
                    ),
                  ),
                ),
          SizedBox(
            width: 8,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                recentContact.name,
                style: Theme.of(context).textTheme.headline5!.copyWith(
                      color: Colors.black,
                      fontWeight: recentContact.isSeen
                          ? FontWeight.w300
                          : FontWeight.bold,
                      letterSpacing: 1,
                      fontSize: 18,
                    ),
              ),
              const SizedBox(
                height: 8.0,
              ),
              Text(
                '$senderName: ${recentContact.lastMessage}',
                style: Theme.of(context).textTheme.bodyText1!.copyWith(
                      fontSize: 15,
                      color: Colors.black,
                      fontWeight: recentContact.isSeen
                          ? FontWeight.w300
                          : FontWeight.bold,
                    ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
