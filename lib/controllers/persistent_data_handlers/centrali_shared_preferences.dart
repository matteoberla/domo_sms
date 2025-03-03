import 'dart:convert';

import 'package:domo_sms/models/centrale_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CentraliSharedPreferences {
  static Future<List<CentraleModel>> centraliList() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    String savedCentrali = prefs.getString('centrali_list') ?? "";
    if (savedCentrali == "") {
      return [];
    }

    List<CentraleModel> centraliList = [];
    for (var article in json.decode(savedCentrali)) {
      centraliList.add(CentraleModel.fromJson(article));
    }

    return centraliList;
  }

  static setCentraliList(List<CentraleModel> newCentraliList) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('centrali_list',
        json.encode(newCentraliList.map((v) => v.toJson()).toList()));
  }
}
