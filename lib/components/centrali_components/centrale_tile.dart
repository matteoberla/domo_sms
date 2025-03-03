import 'package:domo_sms/components/centrali_components/centrale_tile_popup_menu.dart';
import 'package:domo_sms/components/palladio_std_components/palladio_text.dart';
import 'package:domo_sms/controllers/centrali_handlers/centrali_callback.dart';
import 'package:domo_sms/models/centrale_model.dart';
import 'package:domo_sms/state_management/centrali_provider/centrali_provider.dart';
import 'package:domo_sms/styles.dart';
import 'package:flutter/material.dart';

class CentraleTile extends StatelessWidget {
  CentraleTile(
      {super.key, required this.centraliProvider, required this.centrale});

  final CentraliProvider centraliProvider;
  final CentraleModel centrale;
  final CentraliCallback centraliCallback = CentraliCallback();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        centraliCallback.onCentraleTilePressed(
            context, centraliProvider, centrale);
      },
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8.0), color: backgroundColor),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  PalladioText(centrale.nameCentrale ?? "", type: PTextType.h2),
                  PalladioText(
                    centrale.phoneNum ?? "",
                    type: PTextType.h3,
                    textColor: opaqueTextColor,
                    italic: true,
                  ),
                ],
              ),
              CentraleTilePopupMenu(
                  provider: centraliProvider, centrale: centrale),
            ],
          ),
        ),
      ),
    );
  }
}
