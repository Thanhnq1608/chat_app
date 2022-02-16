import 'package:chat_app/app/components/error_alert_dialog.dart';
import 'package:get/get.dart';

class ErrorHandler {
  static final current = ErrorHandler();

  @override
  void handle({required dynamic error}) {
    // if (error is AppError && error.type == ErrorType.unAuthorized) {
    //   return;
    // }

    Get.dialog(ErrorAlertDialog(error: error.toString()));
  }
}
