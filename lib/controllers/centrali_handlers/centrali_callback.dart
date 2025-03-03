import 'package:domo_sms/controllers/centrali_handlers/centrali_bottom_sheet_handler.dart';
import 'package:domo_sms/controllers/centrali_handlers/centrali_handler.dart';
import 'package:domo_sms/models/centrale_model.dart';
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
    CentraliBottomSheetHandler centraliBottomSheetHandler =
        CentraliBottomSheetHandler();
    //
    provider.updateSelectedCentrale(centrale);
    //apro bottom sheet
    await centraliBottomSheetHandler.openCentraleBottomSheet(
        context, provider, centrale);
  }
}
