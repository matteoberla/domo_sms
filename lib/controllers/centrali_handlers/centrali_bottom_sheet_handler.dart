import 'package:domo_sms/components/palladio_std_components/palladio_app_bar.dart';
import 'package:domo_sms/components/palladio_std_components/palladio_body.dart';
import 'package:domo_sms/components/palladio_std_components/palladio_icon_button.dart';
import 'package:domo_sms/components/palladio_std_components/palladio_text.dart';
import 'package:domo_sms/components/palladio_std_components/palladio_text_input.dart';
import 'package:domo_sms/controllers/alerts.dart';
import 'package:domo_sms/controllers/centrali_handlers/centrali_bottom_sheet_callback.dart';
import 'package:domo_sms/models/centrale_model.dart';
import 'package:domo_sms/state_management/centrali_provider/centrali_provider.dart';
import 'package:domo_sms/styles.dart';
import 'package:flutter/material.dart';

class CentraliBottomSheetHandler {
  openCentraleBottomSheet(BuildContext context, CentraliProvider provider,
      CentraleModel centrale) async {
    CentraliBottomSheetCallback centraliBottomSheetCallback =
        CentraliBottomSheetCallback();
    initCentraleFields(centrale);

    await showModalBottomSheet(
      backgroundColor: transparent,
      isScrollControlled: true,
      context: context,
      isDismissible: true,
      builder: (bsContext) {
        double height = MediaQuery.of(context).size.height;
        return Padding(
          padding: EdgeInsets.only(top: height / 2, left: 8.0, right: 8.0),
          child: ClipRRect(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(20.0),
              topRight: Radius.circular(20.0),
            ),
            child: Scaffold(
              appBar: PalladioAppBar(
                title:
                    "${centrale.isNew == true ? "Nuova" : "Modifica"} centrale",
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
                        PalladioText(
                          "Nome centrale",
                          type: PTextType.h2,
                          bold: true,
                        ),
                        PalladioTextInput(
                          forcedKeyboard: true,
                          textController: centrale.nameController,
                          allowedChars: AllowedChars.text,
                          textAlign: TextAlign.start,
                        ),
                        PalladioText(
                          "Numero di telefono",
                          type: PTextType.h2,
                          bold: true,
                        ),
                        PalladioTextInput(
                          forcedKeyboard: true,
                          textController: centrale.phoneController,
                          allowedChars: AllowedChars.integer,
                          textAlign: TextAlign.start,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              if (centrale.isNew == true)
                                PalladioIconButton(
                                  title: "Salva",
                                  icon: Icons.add,
                                  onPressed: () async {
                                    await centraliBottomSheetCallback
                                        .onSaveNewCentralePressed(
                                            context, provider, centrale);
                                  },
                                  backgroundColor: successColor,
                                ),
                              if (centrale.isNew == false)
                                PalladioIconButton(
                                  title: "Salva",
                                  icon: Icons.edit,
                                  onPressed: () async {
                                    await centraliBottomSheetCallback
                                        .onEditCentralePressed(
                                            context, provider, centrale);
                                  },
                                  backgroundColor: interactiveColor,
                                ),
                              PalladioIconButton(
                                title: "Elimina",
                                icon: Icons.delete,
                                onPressed: () async {
                                  await centraliBottomSheetCallback
                                      .onDeleteCentralePressed(
                                          context, provider, centrale);
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

  initCentraleFields(CentraleModel centrale) {
    centrale.nameController.text = centrale.nameCentrale ?? "";
    centrale.phoneController.text = centrale.phoneNum ?? "";
  }

  bool verifyCentraleValid(CentraleModel centrale) {
    if (centrale.nameController.text == "") {
      Alerts.showInfoAlertNoContext(
          "Attenzione", "Indicare un nome per la centrale prima di procedere");
      return false;
    }

    if (centrale.phoneController.text == "") {
      Alerts.showInfoAlertNoContext("Attenzione",
          "Indicare un numero di telefono per la centrale prima di procedere");
      return false;
    }

    //aggiornamento dati centrale
    centrale.nameCentrale = centrale.nameController.text;
    centrale.phoneNum = centrale.phoneController.text;

    return true;
  }
}
