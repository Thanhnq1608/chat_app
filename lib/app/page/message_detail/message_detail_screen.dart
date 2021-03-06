import 'package:chat_app/app/page/message_detail/message_detail_controller.dart';
import 'package:chat_app/app/page/message_detail/widgets/list_message.dart';
import 'package:chat_app/app/page/message_detail/widgets/text_input_message.dart';
import 'package:chat_app/data/models/message.dart';
import 'package:chat_app/data/models/recent_contact.dart';
import 'package:chat_app/data/models/user.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MessageDetailScreen extends StatelessWidget {
  final controller = Get.put(MessageDetailController(user: Get.arguments));

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        backgroundColor: Color(0xFF5157b2),
        appBar: _appBar(context),
        body: Container(
          child: Column(
            children: [
              _header(context, user: controller.user),
              SizedBox(
                height: 20,
              ),
              Obx(
                () => _body(
                  context,
                  controller.listMessages.value,
                  controller.currentUser.email,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  AppBar _appBar(BuildContext context) {
    return AppBar(
      backgroundColor: Color(0xFF5157b2),
      elevation: 0,
      leading: TextButton(
        onPressed: () async {
          Get.back(
              result: RecentContact(
                  isSeen: true,
                  lastMessage: 'lastMessage',
                  sendTime: 'sendTime',
                  sender: '',
                  email: controller.user.email,
                  name: 'name'));
          await controller.updateIsInMessage(user: null);
        },
        child: Text(
          'Back',
          style: Theme.of(context).textTheme.button!.copyWith(),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {},
          child: Text(
            'Search',
            style: Theme.of(context).textTheme.button!.copyWith(),
          ),
        ),
      ],
    );
  }

  Widget _header(BuildContext context, {required User user}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 30),
      child: Row(
        children: [
          _loadAvatar(context, user: user),
          SizedBox(
            width: 10,
          ),
          Expanded(
            child: Container(
              width: context.width / 3,
              child: Text(
                controller.user.name,
                style: Theme.of(context).textTheme.headline1!.copyWith(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
              ),
            ),
          ),
          _buttonService(context, icon: Icons.phone),
          _buttonService(context, icon: Icons.videocam),
        ],
      ),
    );
  }

  ElevatedButton _buttonService(BuildContext context,
      {required IconData icon}) {
    return ElevatedButton(
      onPressed: () {},
      child: Icon(
        icon,
        size: 20,
      ),
      style: ElevatedButton.styleFrom(
          minimumSize: Size(40, 40),
          elevation: 0,
          padding: EdgeInsets.zero,
          onPrimary: Colors.white,
          primary: Colors.white.withOpacity(0.3),
          shape: CircleBorder()),
    );
  }

  Widget _body(
      BuildContext context, List<Message> messages, String currentUser) {
    return Expanded(
      child: Column(
        children: [
          Expanded(
            child: ListMessage(
              messages: messages,
              currentUser: currentUser,
            ),
          ),
          TextInputMessage(
            controller: controller.sendController,
            onClickSend: () async {
              await controller.sendMessage();
            },
          ),
        ],
      ),
    );
  }

  Widget _loadAvatar(BuildContext context, {required User user}) {
    return user.avatar == null
        ? Container(
            height: 60,
            width: 60,
            decoration: BoxDecoration(
              color: Colors.transparent,
              // shape: BoxShape.circle,
              image: DecorationImage(
                  image: AssetImage('assets/images/avatar_default_icon.png')),
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
                image: NetworkImage(user.avatar!),
                placeholder: AssetImage('assets/images/image_loading.gif'),
              ),
            ),
          );
  }
}
