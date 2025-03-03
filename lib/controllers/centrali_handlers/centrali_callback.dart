import 'package:domo_sms/controllers/alerts.dart';
import 'package:domo_sms/controllers/centrali_handlers/centrali_bottom_sheet_handler.dart';
import 'package:domo_sms/controllers/centrali_handlers/centrali_handler.dart';
import 'package:domo_sms/controllers/centrali_handlers/centrali_persistent_data_handler.dart';
import 'package:domo_sms/models/centrale_model.dart';
import 'package:domo_sms/routes.dart';
import 'package:domo_sms/state_management/centrali_provider/centrali_provider.dart';
import 'package:flutter/cupertino.dart';

class CentraliCallback {
  onAddCentralePressed(BuildContext context, CentraliProvider provider) async {
    CentraliHandler centraliHandler = CentraliHandler();
    CentraliBottomSheetHandler centraliBottomSheetHandler =
        CentraliBottomSheetHandler();
    //creo nuova centrale
    CentraleModel newCentrale = centraliHandler.createNewCentraleModel();
    //
    provider.updateSelectedCentrale(null);
    //apro bottom sheet
    await centraliBottomSheetHandler.openCentraleBottomSheet(
        context, provider, newCentrale);
  }

  onCentraleTilePressed(BuildContext context, CentraliProvider provider,
      CentraleModel centrale) async {
    //selezione centrale
    provider.updateSelectedCentrale(centrale);
    //apertura pagina dettaglio
    Navigator.of(context).pushNamed(RoutesHandler.comandiCentralePage);
  }

  onEditCentralePressed(BuildContext context, CentraliProvider provider,
      CentraleModel centrale) async {
    CentraliBottomSheetHandler centraliBottomSheetHandler =
        CentraliBottomSheetHandler();
    //
    provider.updateSelectedCentrale(centrale);
    //apro bottom sheet
    await centraliBottomSheetHandler.openCentraleBottomSheet(
        context, provider, centrale);
  }

  onDeleteCentralePressed(BuildContext context, CentraliProvider provider,
      CentraleModel centrale) async {
    provider.updateSelectedCentrale(centrale);
    Alerts.showConfirmAlertNoContext(
        "Conferma", "Procedere con l'eliminazione della centrale?", () async {
      //chiudo alert
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
