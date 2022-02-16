import 'package:chat_app/data/core/auth.dart';
import 'package:get/get.dart';

import 'interfaces/auth_service_type.dart';

class AppBindings extends Bindings {
  @override
  void dependencies() {
    // TODO: implement dependencies

    Get.lazyPut<AuthServiceType>(() => AuthService());
  }
}
