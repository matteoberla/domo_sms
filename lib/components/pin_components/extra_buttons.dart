import 'package:domo_sms/routes.dart';
import 'package:domo_sms/state_management/login_provider/login_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ExtraButtons extends StatelessWidget {
  const ExtraButtons({super.key});

  @override
  Widget build(BuildContext context) {
    var loginProvider = Provider.of<LoginProvider>(context, listen: true);

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
                  if (loginProvider.modalitaCorrente == Modalita.accesso) {
                    loginProvider.updateAvvisoAccesso(
                        'Inserisci il vecchio codice per sostituirlo');
                    loginProvider.updateModalitaPin(Modalita.insertOldPin);
                  } else {
                    loginProvider.updateAvvisoAccesso('Pin di accesso');
                    loginProvider.updateModalitaPin(Modalita.accesso);
                  }
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
