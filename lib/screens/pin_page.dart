import 'package:domo_sms/components/palladio_std_components/palladio_text.dart';
import 'package:domo_sms/components/pin_components/extra_buttons.dart';
import 'package:domo_sms/components/pin_components/number_pad.dart';
import 'package:domo_sms/components/pin_components/pin_row.dart';
import 'package:domo_sms/controllers/login_handlers/login_handler.dart';
import 'package:domo_sms/state_management/login_provider/login_provider.dart';
import 'package:domo_sms/styles.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: canvasColor,
      body: OtpScreen(),
    );
  }
}

class OtpScreen extends StatefulWidget {
  const OtpScreen({
    super.key,
  });
  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  final LoginHandler loginHandler = LoginHandler();

  @override
  void initState() {
    super.initState();
    loginHandler.initLoginPage(context);
  }

  @override
  Widget build(BuildContext context) {
    var loginProvider = Provider.of<LoginProvider>(context, listen: true);

    return SafeArea(
      child: Column(
        children: [
          ExtraButtons(),
          Expanded(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  PalladioText(
                    loginProvider.avvisoAccesso,
                    type: PTextType.h2,
                    bold: true,
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(
                    height: 40.0,
                  ),
                  PinRow(),
                  NumberPad(),
                ],
              ),
            ),
          ),
          //biometric
        ],
      ),
    );
  }
}
