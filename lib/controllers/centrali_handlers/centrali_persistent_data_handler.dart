import 'package:domo_sms/controllers/persistent_data_handlers/centrali_shared_preferences.dart';
import 'package:domo_sms/models/centrale_model.dart';
import 'package:domo_sms/state_management/centrali_provider/centrali_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CentraliPersistentDataHandler {
  saveCentraliList(
      BuildContext context, List<CentraleModel> allCentraliList) async {
    //salvataggio in locale
    await CentraliSharedPreferences.setCentraliList(allCentraliList);

    if (context.mounted) {
      await getCentraliLocallyData(context);
    }
  }

  Future getCentraliLocallyData(BuildContext context) async {
    try {
      var centraliProvider =
          Provider.of<CentraliProvider>(context, listen: false);
      // get delle liste salvate
      List<CentraleModel> centraliList =
          await CentraliSharedPreferences.centraliList();
      // sovrascrivo le liste articolo con i valori salvati
      centraliProvider.overrideCentraliList(centraliList);
    } catch (e) {
      print('centrali persistent data handler $e');
    }
  }
}
