import 'package:chat_app/app/interfaces/message_service_type.dart';
import 'package:chat_app/data/core/auth.dart';
import 'package:chat_app/data/services/message_service.dart';
import 'package:get/get.dart';

import 'interfaces/auth_service_type.dart';

class AppBindings extends Bindings {
  @override
  void dependencies() {
    // TODO: implement dependencies

    Get.lazyPut<AuthServiceType>(() => AuthService());
    Get.lazyPut<MessageServiceType>(() => MessageService());
  }
}
