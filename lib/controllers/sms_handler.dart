import 'dart:io';

import 'package:domo_sms/controllers/alerts.dart';
import 'package:domo_sms/main.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sms/flutter_sms.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:sms_sender_background/sms_sender.dart';
import 'package:sms_advanced/sms_advanced.dart' as smsAdv;

class SmsHandler {
  openSMSDialog(String message, List<String> recipents) async {
    try {
      String _result = await sendSMS(
        message: message,
        recipients: recipents,
        sendDirect: true,
      );
      print(_result);
    } catch (error) {
      print(error.toString());
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
      if (status.isDenied) {
        // We didn't ask for permission yet or the permission has been denied before but not permanently.
        status = await Permission.sms.request();
      }
      // Send SMS
      if (status.isGranted) {
        await trySendSmsAdvanced(address, msg);
      }
    }
  }

  trySendSms(String address, String msg) async {
    final smsSender = SmsSender();
    try {
      var snackBarInvio = SnackBar(content: Text('SMS inviato!'));

      bool success = await smsSender.sendSms(
        phoneNumber: "+39$address",
        message: msg,
        //simSlot: 0, // Optional: specify SIM slot (0 or 1)
      );

      BuildContext currContext = navigatorKey.currentState!.context;
      if (currContext.mounted == true) {
        ScaffoldMessenger.of(currContext).showSnackBar(snackBarInvio);
      }

      print('SMS sent: $success');
    } catch (e) {
      print('Error sending SMS: $e');
      Alerts.showErrorAlertNoContext("Errore", "Errore nell'invio SMS: $e");
    }
  }

  trySendSmsAdvanced(String address, String msg) async {
    smsAdv.SmsSender sender = smsAdv.SmsSender();

    smsAdv.SmsMessage message = smsAdv.SmsMessage(address, msg);
    message.onStateChanged.listen((state) {
      if (state == smsAdv.SmsMessageState.Sent) {
        print("SMS is sent!");
      } else if (state == smsAdv.SmsMessageState.Delivered) {
        print("SMS is delivered!");
      }
    });
    sender.sendSms(message);
  }
}
