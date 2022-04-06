import 'package:chat_app/app/interfaces/message_service_type.dart';
import 'package:chat_app/app/interfaces/recent_contact_service_type.dart';
import 'package:chat_app/data/api/shared_preferences/shared_preferences.dart';
import 'package:chat_app/data/services/auth_service.dart';
import 'package:chat_app/data/services/message_service.dart';
import 'package:chat_app/data/services/recent_contact_service.dart';
import 'package:chat_app/tools/session_manager/session_manager.dart';
import 'package:get/get.dart';

import 'interfaces/auth_service_type.dart';

class AppBindings extends Bindings {
  @override
  void dependencies() {
    // TODO: implement dependencies

    Get.lazyPut<AuthServiceType>(() => AuthService());

    Get.put<SessionManager>(
      SessionManager(
        sfStorage: Get.find<SfStorage>(),
      ),
    );

    Get.lazyPut<MessageServiceType>(() => MessageService());
    Get.lazyPut<RecentContactServiceType>(() => RecentContactService());
  }
}
