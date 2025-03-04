import 'package:domo_sms/components/palladio_std_components/palladio_text.dart';
import 'package:domo_sms/components/pin_components/keyboard_number.dart';
import 'package:domo_sms/components/pin_components/pin_number.dart';
import 'package:domo_sms/routes.dart';
import 'package:domo_sms/styles.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';

String avvisoAccesso = 'Pin di accesso';

enum Modalita { accesso, insertOldPin, insertNewPin }

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(color: canvasColor),
        child: OtpScreen(),
      ),
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
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  List<String> currentPin = ["", "", "", ""];
  TextEditingController pinOneController = TextEditingController();
  TextEditingController pinTwoController = TextEditingController();
  TextEditingController pinThreeController = TextEditingController();
  TextEditingController pinFourController = TextEditingController();

  Modalita modalitaCorrente = Modalita.accesso;

  final String defaultPin = "2018";

  var outlineInputBorder = OutlineInputBorder(
    borderRadius: BorderRadius.circular(10.0),
    borderSide: BorderSide(color: Colors.transparent),
  );

  int pinIndex = 0;
  String pinSalvato = '';

  @override
  void initState() {
    super.initState();
    initPin();
  }

  void initPin() async {
    pinSalvato = await getCredentials('pin');
    if (pinSalvato == '') {
      pinSalvato = defaultPin;
    }
  }

  void setCredentials(String pin) async {
    final SharedPreferences prefs = await _prefs;
    await prefs.setString('pin', pin);
  }

  Future<String> getCredentials(String tag) async {
    final SharedPreferences prefs = await _prefs;
    return prefs.getString(tag) ?? defaultPin;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          buildExtraButton(),
          Expanded(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  buildSecurityText(),
                  SizedBox(
                    height: 40.0,
                  ),
                  buildPinRow(),
                  buildNumberPad(),
                ],
              ),
            ),
          ),
          //biometric
        ],
      ),
    );
  }

  buildNumberPad() {
    return Expanded(
      child: Container(
        alignment: Alignment.bottomCenter,
        child: Padding(
          padding: const EdgeInsets.only(bottom: 32),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  KeyboardNumber(
                      n: 1,
                      onPressed: () {
                        pinIndexSetup('1');
                      }),
                  KeyboardNumber(
                      n: 2,
                      onPressed: () {
                        pinIndexSetup('2');
                      }),
                  KeyboardNumber(
                      n: 3,
                      onPressed: () {
                        pinIndexSetup('3');
                      }),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  KeyboardNumber(
                      n: 4,
                      onPressed: () {
                        pinIndexSetup('4');
                      }),
                  KeyboardNumber(
                      n: 5,
                      onPressed: () {
                        pinIndexSetup('5');
                      }),
                  KeyboardNumber(
                      n: 6,
                      onPressed: () {
                        pinIndexSetup('6');
                      }),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  KeyboardNumber(
                      n: 7,
                      onPressed: () {
                        pinIndexSetup('7');
                      }),
                  KeyboardNumber(
                      n: 8,
                      onPressed: () {
                        pinIndexSetup('8');
                      }),
                  KeyboardNumber(
                      n: 9,
                      onPressed: () {
                        pinIndexSetup('9');
                      }),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    color: transparent,
                    width: 60.0,
                    child: MaterialButton(
                      onPressed: null,
                      child: SizedBox(),
                    ),
                  ),
                  KeyboardNumber(
                      n: 0,
                      onPressed: () {
                        pinIndexSetup('0');
                      }),
                  Container(
                    color: transparent,
                    width: 60.0,
                    child: MaterialButton(
                      height: 60.0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(60.0),
                      ),
                      onPressed: () {
                        clearPin();
                      },
                      child: Icon(
                        Icons.cancel,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  clearPin() {
    if (pinIndex == 0) {
      pinIndex = 0;
    } else if (pinIndex == 4) {
      setPin(pinIndex, "");
      currentPin[pinIndex - 1] = "";
      pinIndex--;
    } else {
      setPin(pinIndex, "");
      currentPin[pinIndex - 1] = "";
      pinIndex--;
    }
  }

  clearPad() {
    for (int num = 1; num <= 4; num++) {
      setPin(pinIndex, "");
      currentPin[pinIndex - 1] = "";
      pinIndex--;
    }
  }

  pinIndexSetup(String text) async {
    if (pinIndex == 0) {
      pinIndex = 1;
    } else if (pinIndex < 4) {
      pinIndex++;
    }
    setPin(pinIndex, text);
    currentPin[pinIndex - 1] = text;
    String strPin = "";
    for (var e in currentPin) {
      strPin += e;
    }
    if (pinIndex == 4) {
      //verificare pin
      if (modalitaCorrente == Modalita.accesso) {
        if (strPin == pinSalvato) {
          setState(() {
            avvisoAccesso = 'Benvenuto';
            clearPad();
          });
          //accesso eseguito con successo
          Navigator.pushReplacementNamed(context, RoutesHandler.centraliPage);
        } else {
          setState(() {
            avvisoAccesso = 'Il pin inserito non è corretto';
            clearPad();
          });
        }
        print('pin salvato $pinSalvato');
        print('il pin è: $strPin');
      } else if (modalitaCorrente == Modalita.insertOldPin) {
        if (strPin == pinSalvato) {
          setState(() {
            avvisoAccesso = 'Inserisci il nuovo pin';
            clearPad();
            modalitaCorrente = Modalita.insertNewPin;
          });
        } else {
          setState(() {
            avvisoAccesso = 'Il pin inserito non è corretto';
            clearPad();
          });
        }
      } else if (modalitaCorrente == Modalita.insertNewPin) {
        setCredentials(strPin);
        initPin();
        setState(() {
          clearPad();
          modalitaCorrente = Modalita.accesso;
          avvisoAccesso = 'Pin di accesso';
        });
      }
    }
  }

  setPin(int n, String text) {
    switch (n) {
      case 1:
        pinOneController.text = text;
        break;
      case 2:
        pinTwoController.text = text;
        break;
      case 3:
        pinThreeController.text = text;
        break;
      case 4:
        pinFourController.text = text;
        break;
    }
  }

  buildPinRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        PinNumber(
          outlineInputBorder: outlineInputBorder,
          textEditingController: pinOneController,
        ),
        PinNumber(
          outlineInputBorder: outlineInputBorder,
          textEditingController: pinTwoController,
        ),
        PinNumber(
          outlineInputBorder: outlineInputBorder,
          textEditingController: pinThreeController,
        ),
        PinNumber(
          outlineInputBorder: outlineInputBorder,
          textEditingController: pinFourController,
        ),
      ],
    );
  }

  buildSecurityText() {
    return PalladioText(
      avvisoAccesso,
      type: PTextType.h2,
      bold: true,
      textAlign: TextAlign.center,
    );
  }

  buildExtraButton() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              MaterialButton(
                onPressed: () {
                  //apri pagina aiuto
                  Navigator.pushNamed(context, RoutesHandler.helpPage);
                },
                height: 50.0,
                minWidth: 50.0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50.0),
                ),
                child: Icon(
                  Icons.help,
                ),
              ),
              MaterialButton(
                onPressed: () {
                  setState(() {
                    if (modalitaCorrente == Modalita.accesso) {
                      avvisoAccesso =
                          'Inserisci il vecchio codice per sostituirlo';
                      modalitaCorrente = Modalita.insertOldPin;
                    } else {
                      avvisoAccesso = 'Pin di accesso';
                      modalitaCorrente = Modalita.accesso;
                    }
                  });
                },
                height: 50.0,
                minWidth: 50.0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50.0),
                ),
                child: Icon(
                  Icons.lock_open,
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}
