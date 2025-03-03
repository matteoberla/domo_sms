import 'package:domo_sms/controllers/centrali_handlers/centrali_persistent_data_handler.dart';
import 'package:domo_sms/models/centrale_model.dart';
import 'package:flutter/cupertino.dart';

class CentraliHandler {
  Future<bool> initCentraliPage(BuildContext context) async {
    await getLocalSavedCentraliList(context);
    return true;
  }

  getLocalSavedCentraliList(BuildContext context) async {
    /*var centraliProvider =
    Provider.of<CentraliProvider>(context, listen: false);*/

    CentraliPersistentDataHandler centraliPersistentDataHandler =
        CentraliPersistentDataHandler();
    await centraliPersistentDataHandler.getCentraliLocallyData(context);
  }

  CentraleModel createNewCentraleModel() {
    CentraleModel newCentrale = CentraleModel(
      isNew: true,
      commands: [
        Commands(
          name: "Spegni",
          action: commandsAction[CommandType.spegnimento],
        ),
        Commands(
          name: "Accensione parziale",
          action: commandsAction[CommandType.parziale],
        ),
        Commands(
          name: "Accensione totale",
          action: commandsAction[CommandType.accensione],
        ),
      ],
    );

    return newCentrale;
  }
}
