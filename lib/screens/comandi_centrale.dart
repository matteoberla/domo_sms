import 'package:domo_sms/components/comandi_centrale_components/generic_action_tile.dart';
import 'package:domo_sms/components/empty_space.dart';
import 'package:domo_sms/components/palladio_std_components/palladio_app_bar.dart';
import 'package:domo_sms/components/palladio_std_components/palladio_body.dart';
import 'package:domo_sms/controllers/commands_handlers/commands_callback.dart';
import 'package:domo_sms/controllers/commands_handlers/commands_handler.dart';
import 'package:domo_sms/models/centrale_model.dart';
import 'package:domo_sms/state_management/centrali_provider/centrali_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ComandiCentralePage extends StatefulWidget {
  const ComandiCentralePage({super.key});

  @override
  State<ComandiCentralePage> createState() => _ComandiCentralePageState();
}

class _ComandiCentralePageState extends State<ComandiCentralePage> {
  final CommandsCallback commandsCallback = CommandsCallback();
  final CommandsHandler commandsHandler = CommandsHandler();

  @override
  Widget build(BuildContext context) {
    var centraliProvider = Provider.of<CentraliProvider>(context, listen: true);

    CentraleModel? selectedCentrale = centraliProvider.selectedCentrale;

    return Scaffold(
      appBar: PalladioAppBar(title: selectedCentrale?.nameCentrale ?? ""),
      body: PalladioBody(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              IntrinsicHeight(
                child: Row(
                  spacing: 8,
                  children: [
                    commandsHandler.getFirstCommandWithType(
                        centraliProvider, CommandType.spegnimento),
                    commandsHandler.getFirstCommandWithType(
                        centraliProvider, CommandType.parziale),
                    commandsHandler.getFirstCommandWithType(
                        centraliProvider, CommandType.accensione),
                    commandsHandler.getFirstCommandWithType(
                        centraliProvider, CommandType.stato),
                  ],
                ),
              ),
              EmptySpace(
                height: 8,
              ),
              ListView.separated(
                shrinkWrap: true,
                separatorBuilder: (context, index) => EmptySpace(
                  height: 8,
                ),
                itemBuilder: (context, index) {
                  Commands command = commandsHandler
                      .getGenericCommandsList(centraliProvider)[index];

                  return GenericActionTile(
                    centraliProvider: centraliProvider,
                    command: command,
                  );
                },
                itemCount: commandsHandler
                    .getGenericCommandsList(centraliProvider)
                    .length,
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await commandsCallback.onAddCommandPressed(context, centraliProvider);
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
