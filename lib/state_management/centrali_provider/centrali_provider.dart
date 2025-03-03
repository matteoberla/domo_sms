import 'package:domo_sms/models/centrale_model.dart';
import 'package:flutter/cupertino.dart';

class CentraliProvider extends ChangeNotifier {
  List<CentraleModel> centraliList = [];

  overrideCentraliList(List<CentraleModel> newList) {
    centraliList = List.from(newList);
    notifyListeners();
  }

  int get centraliListLength {
    return centraliList.length;
  }

  addCentrale(CentraleModel newCentrale) {
    centraliList.add(newCentrale);
    notifyListeners();
  }

  addCentraleAtIndex(CentraleModel newCentrale, intIndex) {
    centraliList.insert(intIndex, newCentrale);
    notifyListeners();
  }

  removeCentrale(CentraleModel centrale) {
    centraliList.remove(centrale);
    notifyListeners();
  }

  ///
  CentraleModel? selectedCentrale;

  updateSelectedCentrale(CentraleModel? newCentrale) {
    selectedCentrale = newCentrale;
    notifyListeners();
  }
}
