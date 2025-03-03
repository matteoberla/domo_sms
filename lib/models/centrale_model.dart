import 'package:flutter/cupertino.dart';

enum CommandType { accensione, spegnimento, parziale, generico }

Map<CommandType, String> commandsAction = {
  CommandType.accensione: "ON",
  CommandType.spegnimento: "OFF",
  CommandType.parziale: "PARTIAL",
  CommandType.generico: "GENERIC",
};

class CentraleModel {
  String? nameCentrale;
  String? phoneNum;
  List<Commands>? commands;
  bool? isNew = false;

  //
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();

  CentraleModel(
      {this.nameCentrale, this.phoneNum, this.commands, this.isNew = false});

  CentraleModel.fromJson(Map<String, dynamic> json) {
    nameCentrale = json['name_centrale'];
    phoneNum = json['phone_num'];
    if (json['commands'] != null) {
      commands = <Commands>[];
      json['commands'].forEach((v) {
        commands!.add(Commands.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name_centrale'] = nameCentrale;
    data['phone_num'] = phoneNum;
    if (commands != null) {
      data['commands'] = commands!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Commands {
  String? name;
  String? msg;
  String? action;
  bool? isNew = false;

  //
  TextEditingController nameController = TextEditingController();
  TextEditingController msgController = TextEditingController();

  Commands({this.name, this.msg, this.action, this.isNew = false});

  Commands.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    msg = json['msg'];
    action = json['action'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['msg'] = msg;
    data['action'] = action;
    return data;
  }
}
