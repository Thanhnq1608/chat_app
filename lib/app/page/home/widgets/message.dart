import 'package:chat_app/app/routes/app_pages.dart';
import 'package:chat_app/app/routes/app_routes.dart';
import 'package:chat_app/core/models/message.dart' as messages;
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Message extends StatelessWidget {
  final messageDatas = messages.Message.generateMessage();

  @override
  Widget build(BuildContext context) {
    return Container(
        width: double.infinity,
        child: ListView.separated(
            separatorBuilder: (context, index) => SizedBox(
                  height: 40,
                ),
            itemCount: messageDatas.length,
            itemBuilder: (context, index) {
              var message = messageDatas[index];
              var user = message.user;
              return InkWell(
                onTap: () => Get.toNamed(AppRoutes.MESSAGE, arguments: user),
                child: Row(
                  children: [
                    Container(
                      height: 60,
                      width: 60,
                      decoration: BoxDecoration(
                          color: user.userColor, shape: BoxShape.circle),
                      child: CircleAvatar(
                        backgroundImage: AssetImage(user.avatar),
                      ),
                    ),
                    SizedBox(
                      width: 15,
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                user.name,
                                style: Theme.of(context)
                                    .textTheme
                                    .headline1!
                                    .copyWith(
                                      letterSpacing: -1,
                                      fontSize: 18,
                                    ),
                              ),
                              Text(
                                message.lastTime,
                                style: Theme.of(context)
                                    .textTheme
                                    .caption!
                                    .copyWith(letterSpacing: -0.5),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            message.lastMessage,
                            overflow: TextOverflow.ellipsis,
                            style: Theme.of(context)
                                .textTheme
                                .bodyText1!
                                .copyWith(letterSpacing: -0.3),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              );
            }));
  }
}
