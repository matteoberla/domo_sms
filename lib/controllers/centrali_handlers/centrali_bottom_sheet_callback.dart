import 'package:domo_sms/controllers/alerts.dart';
import 'package:domo_sms/controllers/centrali_handlers/centrali_bottom_sheet_handler.dart';
import 'package:domo_sms/controllers/centrali_handlers/centrali_persistent_data_handler.dart';
import 'package:domo_sms/models/centrale_model.dart';
import 'package:domo_sms/state_management/centrali_provider/centrali_provider.dart';
import 'package:flutter/cupertino.dart';

class CentraliBottomSheetCallback {
  onSaveNewCentralePressed(BuildContext context, CentraliProvider provider,
      CentraleModel centrale) async {
    CentraliBottomSheetHandler centraliBottomSheetHandler =
        CentraliBottomSheetHandler();
    //verifico i dati inseriti
    bool success = centraliBottomSheetHandler.verifyCentraleValid(centrale);
    if (success) {
      provider.addCentrale(centrale);
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

  onEditCentralePressed(BuildContext context, CentraliProvider provider,
      CentraleModel centrale) async {
    CentraliBottomSheetHandler centraliBottomSheetHandler =
        CentraliBottomSheetHandler();
    bool success = centraliBottomSheetHandler.verifyCentraleValid(centrale);

    if (success) {
      //get dell'index della centrale corrente
      if (provider.selectedCentrale != null) {
        int index = provider.centraliList.indexOf(provider.selectedCentrale!);

        if (index != -1) {
          //rimuovo quella vecchia
          provider.removeCentrale(provider.selectedCentrale!);
          //inserisco quella aggiornata allo stesso index
          provider.addCentraleAtIndex(centrale, index);
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

  onDeleteCentralePressed(BuildContext context, CentraliProvider provider,
      CentraleModel centrale) async {
    Alerts.showConfirmAlertNoContext(
        "Conferma", "Procedere con l'eliminazione della centrale?", () async {
      //chiudo alert
      Navigator.of(context).pop();
      //chiudo bottom
      Navigator.of(context).pop();
      //rimozione dalla lista
      provider.removeCentrale(centrale);
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
