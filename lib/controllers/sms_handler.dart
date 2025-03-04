import 'package:domo_sms/controllers/alerts.dart';
import 'package:flutter_sms/flutter_sms.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:sms_sender_background/sms_sender.dart';

class SmsHandler {
  sendSMSTo(String message, List<String> recipents) async {
    String result = await sendSMS(
        message: message, recipients: recipents, sendDirect: true);
    print(result);
  }

  sendSmsTo(String address, String msg) async {
    PermissionStatus status = await Permission.sms.status;

    final smsSender = SmsSender();

    if (status.isDenied) {
      // We didn't ask for permission yet or the permission has been denied before but not permanently.
      status = await Permission.sms.request();
    }

    // Send SMS
    if (status.isGranted) {
      try {
        bool success = await smsSender.sendSms(
          phoneNumber: address,
          message: msg,
          simSlot: 0, // Optional: specify SIM slot (0 or 1)
        );
        print('SMS sent: $success');
      } catch (e) {
        print('Error sending SMS: $e');
        Alerts.showErrorAlertNoContext("Errore", "Error sending SMS: $e");
      }
    }

    /*var snackBarInvio =
    SnackBar(content: Text('SMS di ${command.name} inviato!'));
    if (navigatorKey.currentState!.context.mounted) {
      ScaffoldMessenger.of(navigatorKey.currentState!.context)
          .showSnackBar(snackBarInvio);
    }*/
  }
}
