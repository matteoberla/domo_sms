import 'package:domo_sms/components/empty_space.dart';
import 'package:domo_sms/components/palladio_std_components/palladio_text.dart';
import 'package:domo_sms/styles.dart';
import 'package:flutter/material.dart';

class PalladioPopUpItem extends StatelessWidget {
  const PalladioPopUpItem(
      {super.key, required this.title, this.icon, this.selected = false});

  final String title;
  final IconData? icon;
  final bool selected;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Visibility(
                visible: icon != null,
                child: Icon(
                  icon,
                  color: iconsPopUpMenuColor,
                ),
              ),
              const EmptySpace(
                width: 10,
              ),
              Flexible(
                child: PalladioText(
                  title,
                  type: PTextType.h3,
                  maxLines: 1,
                ),
              ),
            ],
          ),
        ),
        Icon(
          selected ? Icons.check : null,
          color: interactiveColor,
        ),
      ],
    );
  }
}
