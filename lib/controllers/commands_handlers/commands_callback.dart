import 'package:domo_sms/controllers/alerts.dart';
import 'package:domo_sms/controllers/commands_handlers/commands_bottom_sheet_handler.dart';
import 'package:domo_sms/controllers/sms_handler.dart';
import 'package:domo_sms/models/centrale_model.dart';
import 'package:domo_sms/state_management/centrali_provider/centrali_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CommandsCallback {
  onAddCommandPressed(BuildContext context, CentraliProvider provider) async {
    CommandsBottomSheetHandler commandsBottomSheetHandler =
        CommandsBottomSheetHandler();
    //creo nuovo comando
    Commands command =
        Commands(isNew: true, action: commandsAction[CommandType.generico]);
    //
    provider.updateSelectedComando(null);
    //apro bottom sheet
    await commandsBottomSheetHandler.openCommandsBottomSheet(
        context, provider, command);
  }

  onCommandLongPress(
      BuildContext context, CentraliProvider provider, Commands command) async {
    CommandsBottomSheetHandler commandsBottomSheetHandler =
        CommandsBottomSheetHandler();
    //
    provider.updateSelectedComando(command);
    //apro bottom sheet
    await commandsBottomSheetHandler.openCommandsBottomSheet(
        context, provider, command);
  }

  onCommandPress(
      BuildContext context, CentraliProvider provider, Commands command) async {
    //verifica se il numero di telefono è impostato
    if (provider.selectedCentrale == null ||
        provider.selectedCentrale?.phoneNum == null) {
      Alerts.showInfoAlertNoContext("Attenzione",
          "Verificare che la centrale sia configurata correttamente");
      return;
    }
    //verifica se il messaggio è configurato
    if (command.msg == null || command.msg == "") {
      Alerts.showInfoAlertNoContext("Attenzione",
          "Nessun messaggio configurato per il comando selezionato");
      return;
    }

    //invio messaggio
    SmsHandler smsHandler = SmsHandler();
    String address = provider.selectedCentrale!.phoneNum!;
    String msg = command.msg!;

    await smsHandler.sendSmsTo(address, msg);
  }
}
