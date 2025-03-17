import 'dart:io';
import 'package:domo_sms/controllers/alerts.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_sms/flutter_sms.dart';

class SmsHandler {
  openSMSDialog(String message, List<String> recipents) async {
    try {
      String result = await sendSMS(
        message: message,
        recipients: recipents,
        sendDirect: false,
      );
      print(result);
      //
      /*var snackBarInvio = SnackBar(content: Text('SMS inviato!'));
      BuildContext currContext = navigatorKey.currentState!.context;
      print(currContext.mounted);
      if (currContext.mounted == true) {
        ScaffoldMessenger.of(currContext).showSnackBar(snackBarInvio);
      }*/
    } catch (error) {
      print(error.toString());
      Alerts.showErrorAlertNoContext(
          "Errore", "Errore nell'invio SMS: ${error.toString()}");
    }
  }

  handleSMSSend(String address, String msg) async {
    if (kIsWeb) {
      //invio messaggio tramite dialog
      await openSMSDialog(msg, [address]);
    } else if (Platform.isIOS) {
      // Send SMS
      await openSMSDialog(msg, [address]);
    } else if (Platform.isAndroid) {
      await openSMSDialog(msg, [address]);
    }
  }
}
