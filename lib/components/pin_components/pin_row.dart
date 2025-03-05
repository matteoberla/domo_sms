import 'package:domo_sms/components/pin_components/pin_number.dart';
import 'package:domo_sms/state_management/login_provider/login_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PinRow extends StatelessWidget {
  const PinRow({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    var loginProvider = Provider.of<LoginProvider>(context, listen: true);

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        PinNumber(
          textEditingController: loginProvider.pinOneController,
        ),
        PinNumber(
          textEditingController: loginProvider.pinTwoController,
        ),
        PinNumber(
          textEditingController: loginProvider.pinThreeController,
        ),
        PinNumber(
          textEditingController: loginProvider.pinFourController,
        ),
      ],
    );
  }
}
