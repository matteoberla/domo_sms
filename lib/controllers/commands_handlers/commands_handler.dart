import 'package:domo_sms/components/comandi_centrale_components/main_action_tile.dart';
import 'package:domo_sms/components/empty_space.dart';
import 'package:domo_sms/models/centrale_model.dart';
import 'package:domo_sms/state_management/centrali_provider/centrali_provider.dart';
import 'package:domo_sms/styles.dart';
import 'package:flutter/material.dart';

class CommandsHandler {
  Widget getFirstCommandWithType(
      CentraliProvider provider, CommandType commandType) {
    //cerco il comando per tipologia
    Commands? commandFound = provider.selectedCentrale?.commands
        ?.where((e) => e.action == commandsAction[commandType])
        .firstOrNull;

    if (commandFound != null) {
      return Expanded(
        child: MainActionTile(
          centraliProvider: provider,
          command: commandFound,
        ),
      );
    } else {
      return EmptySpace();
    }
  }

  List<Commands> getGenericCommandsList(CentraliProvider provider) {
    return provider.selectedCentrale?.commands
            ?.where((e) => e.action == commandsAction[CommandType.generico])
            .toList() ??
        [];
  }

  Color getTileColor(Commands command) {
    CommandType? commandType = commandsAction.keys
        .where((k) => commandsAction[k] == command.action)
        .firstOrNull;

    switch (commandType) {
      case CommandType.accensione:
        return dangerColor;
      case CommandType.parziale:
        return warningSecondaryColor;
      case CommandType.spegnimento:
        return successColor;
      default:
        return darkInfoColor;
    }
  }
}
