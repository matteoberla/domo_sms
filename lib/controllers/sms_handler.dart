import 'dart:io';
import 'package:domo_sms/controllers/alerts.dart';
import 'package:domo_sms/main.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sms/flutter_sms.dart';
import 'package:permission_handler/permission_handler.dart';

class SmsHandler {
  openSMSDialog(String message, List<String> recipents) async {
    try {
      String result = await sendSMS(
        message: message,
        recipients: recipents,
        sendDirect: true,
      );
      print(result);
      //
      var snackBarInvio = SnackBar(content: Text('SMS inviato!'));
      BuildContext currContext = navigatorKey.currentState!.context;
      print(currContext.mounted);
      if (currContext.mounted == true) {
        ScaffoldMessenger.of(currContext).showSnackBar(snackBarInvio);
      }
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
      PermissionStatus status = await Permission.sms.status;
      //verifico permessi messaggi
      if (status.isDenied || status.isPermanentlyDenied || status.isLimited) {
        // We didn't ask for permission yet or the permission has been denied before but not permanently.
        status = await Permission.sms.request();
      }
      // Send SMS
      if (status.isGranted) {
        await openSMSDialog(msg, [address]);
      } else {
        Alerts.showErrorAlertNoContext(
            "Errore", "L'app necessita dei permessi per l'invio degli SMS");
      }
    }
  }
}
