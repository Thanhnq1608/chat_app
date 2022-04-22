import 'dart:async';
import 'package:chat_app/app/interfaces/recent_contact_service_type.dart';
import 'package:chat_app/data/models/message.dart';
import 'package:chat_app/app/interfaces/auth_service_type.dart';
import 'package:chat_app/app/interfaces/message_service_type.dart';
import 'package:chat_app/data/models/notification.dart' as localNoti;
import 'package:chat_app/data/models/notification_data.dart';
import 'package:chat_app/data/models/recent_contact.dart';
import 'package:chat_app/data/models/user.dart';
import 'package:chat_app/tools/helper/error_handler.dart';
import 'package:chat_app/tools/push_notification/push_notification.dart';
import 'package:chat_app/tools/session_manager/session_manager.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class MessageDetailController extends GetxController {
  MessageDetailController({required this.user});
  final User user;
  late TextEditingController sendController;
  RxBool isLoading = false.obs;
  final _messageService = Get.find<MessageServiceType>();
  final _authService = Get.find<AuthServiceType>();
  final _recentContactService = Get.find<RecentContactServiceType>();
  final _sessionManager = Get.find<SessionManager>();
  final _pushNotification = Get.find<PushNotification>();

  late StreamSubscription<List<Message>> streamSubcriptionSender;
  late StreamSubscription<List<Message>> streamSubcriptionReceiver;

  RxList<Message> listMessages = <Message>[].obs;

  RxList<Message> listMessagesUI = <Message>[].obs;

  User currentUser = User(userId: '', email: '', name: '', token: '');

  Future<void> sendMessage() async {
    if (sendController.text.isNotEmpty) {
      try {
        _messageService.sendMessage(
          message: Message(
            sender: currentUser.email,
            receiver: user.email,
            message: sendController.text,
            type: 1,
            sendTime: _formatDateTime(time: DateTime.now()),
          ),
          user: user,
        );
        _authService.sendNotificationMessage(
          notification: localNoti.Notification(
            data: NotificationData(
              message: sendController.text,
              sender: currentUser.email,
              title: currentUser.name,
              clickAction: "FLUTTER_NOTIFICATION_CLICK",
            ),
            priority: 'high',
            receiver: user.token,
          ),
        );
        _recentContactService.updateRecentContact(
            contact: RecentContact(
                isSeen: false,
                lastMessage: sendController.text,
                email: user.email,
                sendTime: _formatDateTime(time: DateTime.now()),
                name: user.name,
                avatar: user.avatar,
                sender: currentUser.email),
            emailDoc: user.email);
        sendController.clear();
      } catch (e) {
        print(e);
        ErrorHandler.current.handle(error: e);
      }
    }
  }

  Stream<List<Message>> getLastMessageSender(
      {required String currentUser, required String user}) {
    var listMessages = _messageService.listenMessagesFromSender(
        currentUser: currentUser, user: user);
    print(listMessages.length);
    return listMessages;
  }

  Stream<List<Message>> getLastMessageReceiver(
      {required String currentUser, required String user}) {
    var listMessages = _messageService.listenMessagesFromReceiver(
        currentUser: currentUser, user: user);
    print(listMessages.length);
    return listMessages;
  }

  Future<void> updateIsInMessage({required String? user}) async {
    try {
      await _sessionManager.updateIsInMessage(user: user);
    } catch (e) {
      print(e);
    }
  }

  Future<void> getCurrentUser() async {
    try {
      currentUser = await _sessionManager.currentUser();
    } catch (e) {
      ErrorHandler.current.handle(error: e);
    }
  }

  @override
  void onInit() async {
    sendController = TextEditingController();
    await getCurrentUser();

    await updateIsInMessage(user: user.email);

    streamSubcriptionSender =
        getLastMessageSender(currentUser: currentUser.email, user: user.email)
            .listen((event) {
      listMessages.addAll(event);

      listMessages.sort((a, b) => b.sendTime.compareTo(a.sendTime));
    });
    streamSubcriptionReceiver =
        getLastMessageReceiver(currentUser: currentUser.email, user: user.email)
            .listen((event) {
      listMessages.addAll(event);

      listMessages.sort((a, b) => b.sendTime.compareTo(a.sendTime));
    });
    super.onInit();
  }

  @override
  void onReady() async {
    // TODO: implement onReady
    super.onReady();
  }

  @override
  void onClose() {
    streamSubcriptionSender.cancel();
    streamSubcriptionReceiver.cancel();
    super.onClose();
  }

  String _formatDateTime({required DateTime time}) {
    String dateTime = DateFormat('yyyy/MM/dd - HH:mm:ss').format(time);
    DateTime formatDate = DateFormat('yyyy/MM/dd - HH:mm:ss').parse(dateTime);
    if (formatDate.hour + 1 == 24) {
      return '${formatDate.year}/${formatDate.month}/${formatDate.day} - 00:${formatDate.minute}:${formatDate.second}';
    }

    return dateTime;
  }
}
