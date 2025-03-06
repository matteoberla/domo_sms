import 'package:domo_sms/components/palladio_std_components/palladio_text.dart';
import 'package:domo_sms/controllers/commands_handlers/commands_callback.dart';
import 'package:domo_sms/controllers/commands_handlers/commands_handler.dart';
import 'package:domo_sms/models/centrale_model.dart';
import 'package:domo_sms/state_management/centrali_provider/centrali_provider.dart';
import 'package:domo_sms/styles.dart';
import 'package:flutter/material.dart';

class MainActionTile extends StatelessWidget {
  const MainActionTile(
      {super.key, required this.centraliProvider, required this.command});

  final CentraliProvider centraliProvider;
  final Commands command;

  @override
  Widget build(BuildContext context) {
    CommandsHandler commandsHandler = CommandsHandler();
    CommandsCallback commandsCallback = CommandsCallback();
    Color tileColor = commandsHandler.getTileColor(command);
    IconData icon = commandsHandler.getTileIcon(command);

    return InkWell(
      onTap: () async {
        await commandsCallback.onCommandPress(
            context, centraliProvider, command);
      },
      onLongPress: () async {
        await commandsCallback.onCommandLongPress(
            context, centraliProvider, command);
      },
      child: Container(
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.all(4.0),
              child: Icon(
                icon,
                color: tileColor,
                size: 50,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: PalladioText(
                command.name ?? "",
                type: PTextType.h3,
                bold: true,
                textColor: tileColor,
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
