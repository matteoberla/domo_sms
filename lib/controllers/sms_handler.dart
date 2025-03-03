import 'package:flutter_sms/flutter_sms.dart';

class SmsHandler {
  sendSMSTo(String message, List<String> recipents) async {
    String result =
        await sendSMS(message: message, recipients: recipents, sendDirect: true)
            .catchError((onError) {
      print(onError);
      return onError;
    });
    print(result);
  }
}
