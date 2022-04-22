import 'package:intl/intl.dart';

class ShowSendTimeMessage {
  static String getTime({required String time}) {
    var sendTime = DateFormat('yyyy/MM/dd - HH:mm:ss').parse(time);
    if (sendTime.year == DateTime.now().year &&
        sendTime.month == DateTime.now().month &&
        sendTime.day == DateTime.now().day) {
      if (sendTime.hour == 23) {
        return '00:${sendTime.minute}';
      }
      return '${sendTime.hour + 1}:${sendTime.minute}';
    } else {
      return '${sendTime.day}/${sendTime.month}';
    }
  }
}
