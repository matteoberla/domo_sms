import 'package:domo_sms/controllers/alerts.dart';
import 'package:domo_sms/controllers/centrali_handlers/centrali_persistent_data_handler.dart';
import 'package:domo_sms/controllers/commands_handlers/commands_bottom_sheet_handler.dart';
import 'package:domo_sms/models/centrale_model.dart';
import 'package:domo_sms/state_management/centrali_provider/centrali_provider.dart';
import 'package:flutter/material.dart';

class CommandsBottomSheetCallback {
  onSaveNewCommandPressed(
      BuildContext context, CentraliProvider provider, Commands command) async {
    CommandsBottomSheetHandler commandsBottomSheetHandler =
        CommandsBottomSheetHandler();
    //verifico i dati inseriti
    bool success = commandsBottomSheetHandler.verifyCommandValid(command);
    if (success) {
      provider.addCommand(provider.selectedCentrale, command);
      //salvataggio in locale
      CentraliPersistentDataHandler centraliPersistentDataHandler =
          CentraliPersistentDataHandler();
      await centraliPersistentDataHandler.saveCentraliList(
          context, provider.centraliList);
      if (context.mounted) {
        //chiudo bottom
        Navigator.of(context).pop();
      }
    }
  }

  onEditCommandPressed(
      BuildContext context, CentraliProvider provider, Commands command) async {
    CommandsBottomSheetHandler commandsBottomSheetHandler =
        CommandsBottomSheetHandler();
    bool success = commandsBottomSheetHandler.verifyCommandValid(command);

    if (success) {
      //get dell'index della centrale corrente
      if (provider.selectedCentrale != null &&
          provider.selectedComando != null) {
        int index = provider.selectedCentrale!.commands!
            .indexOf(provider.selectedComando!);

        if (index != -1) {
          //rimuovo quella vecchia
          provider.removeCommandFromCentrale(
              provider.selectedCentrale!, command);
          //inserisco quella aggiornata allo stesso index
          provider.addCommandAtIndex(
              provider.selectedCentrale!, command, index);
          //salvataggio in locale
          CentraliPersistentDataHandler centraliPersistentDataHandler =
              CentraliPersistentDataHandler();
          await centraliPersistentDataHandler.saveCentraliList(
              context, provider.centraliList);
          if (context.mounted) {
            //chiudo bottom
            Navigator.of(context).pop();
          }
        }
      } else {
        Alerts.showErrorAlertNoContext(
            "Errore", "Nessuna centrale selezionata");
      }
    }
  }

  onDeleteCommandPressed(
      BuildContext context, CentraliProvider provider, Commands command) async {
    Alerts.showConfirmAlertNoContext(
        "Conferma", "Procedere con l'eliminazione del comando?", () async {
      //chiudo alert
      Navigator.of(context).pop();
      //chiudo bottom
      Navigator.of(context).pop();
      //rimozione dalla lista
      provider.removeCommandFromCentrale(provider.selectedCentrale, command);
      //salvataggio in locale
      CentraliPersistentDataHandler centraliPersistentDataHandler =
          CentraliPersistentDataHandler();
      await centraliPersistentDataHandler.saveCentraliList(
          context, provider.centraliList);
    }, () {
      Navigator.of(context).pop();
    });
  }
}
