import 'package:domo_sms/components/palladio_std_components/palladio_app_bar.dart';
import 'package:domo_sms/components/palladio_std_components/palladio_body.dart';
import 'package:domo_sms/components/palladio_std_components/palladio_icon_button.dart';
import 'package:domo_sms/components/palladio_std_components/palladio_text.dart';
import 'package:domo_sms/components/palladio_std_components/palladio_text_input.dart';
import 'package:domo_sms/controllers/alerts.dart';
import 'package:domo_sms/controllers/commands_handlers/commands_bottom_sheet_callback.dart';
import 'package:domo_sms/models/centrale_model.dart';
import 'package:domo_sms/state_management/centrali_provider/centrali_provider.dart';
import 'package:domo_sms/styles.dart';
import 'package:flutter/material.dart';

class CommandsBottomSheetHandler {
  openCommandsBottomSheet(
      BuildContext context, CentraliProvider provider, Commands command) async {
    CommandsBottomSheetCallback commandsBottomSheetCallback =
        CommandsBottomSheetCallback();
    initCommandsFields(command);

    FocusNode comandoFN = FocusNode();

    await showModalBottomSheet(
      backgroundColor: transparent,
      isScrollControlled: true,
      context: context,
      isDismissible: true,
      builder: (bsContext) {
        double height = MediaQuery.of(context).size.height;
        comandoFN.requestFocus();
        return Padding(
          padding: EdgeInsets.only(top: height * 0.25, left: 8.0, right: 8.0),
          child: ClipRRect(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(20.0),
              topRight: Radius.circular(20.0),
            ),
            child: Scaffold(
              appBar: PalladioAppBar(
                title:
                    "${command.isNew == true ? "Nuovo" : "Modifica"} comando",
              ),
              body: PalladioBody(
                showBottomBar: false,
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (getCommandType(command) == CommandType.generico)
                          PalladioText(
                            "Nome comando",
                            type: PTextType.h2,
                            bold: true,
                          ),
                        if (getCommandType(command) == CommandType.generico)
                          PalladioTextInput(
                            forcedKeyboard: true,
                            textController: command.nameController,
                            allowedChars: AllowedChars.text,
                            textAlign: TextAlign.start,
                          ),
                        PalladioText(
                          "Comando da inviare",
                          type: PTextType.h2,
                          bold: true,
                        ),
                        PalladioTextInput(
                          forcedKeyboard: true,
                          textController: command.msgController,
                          allowedChars: AllowedChars.text,
                          textAlign: TextAlign.start,
                          focusNode: comandoFN,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              if (command.isNew == true)
                                PalladioIconButton(
                                  title: "Salva",
                                  icon: Icons.add,
                                  onPressed: () async {
                                    await commandsBottomSheetCallback
                                        .onSaveNewCommandPressed(
                                            context, provider, command);
                                  },
                                  backgroundColor: successColor,
                                ),
                              if (command.isNew == false)
                                PalladioIconButton(
                                  title: "Salva",
                                  icon: Icons.edit,
                                  onPressed: () async {
                                    await commandsBottomSheetCallback
                                        .onEditCommandPressed(
                                            context, provider, command);
                                  },
                                  backgroundColor: interactiveColor,
                                ),
                              if (getCommandType(command) ==
                                  CommandType.generico)
                                PalladioIconButton(
                                  title: "Elimina",
                                  icon: Icons.delete,
                                  onPressed: () async {
                                    await commandsBottomSheetCallback
                                        .onDeleteCommandPressed(
                                            context, provider, command);
                                  },
                                  backgroundColor: dangerColor,
                                ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  initCommandsFields(Commands command) {
    command.nameController.text = command.name ?? "";
    command.msgController.text = command.msg ?? "";
  }

  bool verifyCommandValid(Commands command) {
    if (command.nameController.text == "") {
      Alerts.showInfoAlertNoContext(
          "Attenzione", "Indicare un nome per il comando prima di procedere");
      return false;
    }

    if (command.msgController.text == "") {
      Alerts.showInfoAlertNoContext(
          "Attenzione", "Indicare un comando prima di procedere");
      return false;
    }

    //aggiornamento dati centrale
    command.name = command.nameController.text;
    command.msg = command.msgController.text;

    return true;
  }

  CommandType getCommandType(Commands command) {
    CommandType? commandType = commandsAction.keys
        .where((k) => commandsAction[k] == command.action)
        .firstOrNull;

    return commandType ?? CommandType.generico;
  }
}
