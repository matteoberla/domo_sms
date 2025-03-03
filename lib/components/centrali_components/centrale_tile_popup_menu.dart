import 'package:domo_sms/components/palladio_std_components/palladio_popup_item.dart';
import 'package:domo_sms/controllers/centrali_handlers/centrali_callback.dart';
import 'package:domo_sms/models/centrale_model.dart';
import 'package:domo_sms/state_management/centrali_provider/centrali_provider.dart';
import 'package:domo_sms/styles.dart';
import 'package:flutter/material.dart';

enum MenuValues { modifica, elimina }

class CentraleTilePopupMenu extends StatelessWidget {
  CentraleTilePopupMenu({
    super.key,
    required this.provider,
    required this.centrale,
  });

  final CentraliProvider provider;
  final CentraleModel centrale;

  final CentraliCallback centraliCallback = CentraliCallback();

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      icon: Icon(
        Icons.info_outline,
        color: interactiveColor,
      ),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(10.0),
        ),
      ),
      itemBuilder: (contextPopUp) => <PopupMenuEntry<Object>>[
        const PopupMenuItem(
          value: MenuValues.modifica,
          child: PalladioPopUpItem(title: "Modifica", icon: Icons.edit),
        ),
        const PopupMenuDivider(),
        const PopupMenuItem(
          value: MenuValues.elimina,
          child: PalladioPopUpItem(title: "Elimina", icon: Icons.delete),
        ),
      ],
      onSelected: (itemPressed) async {
        switch (itemPressed) {
          case MenuValues.modifica:
            await centraliCallback.onEditCentralePressed(
                context, provider, centrale);
            break;
          case MenuValues.elimina:
            await centraliCallback.onDeleteCentralePressed(
                context, provider, centrale);
            break;
          default:
            print("non gestito");
            break;
        }
      },
    );
  }
}
