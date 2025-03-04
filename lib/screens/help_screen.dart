import 'package:domo_sms/components/palladio_std_components/palladio_app_bar.dart';
import 'package:domo_sms/components/palladio_std_components/palladio_icon_button.dart';
import 'package:domo_sms/components/palladio_std_components/palladio_text.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class HelpPage extends StatelessWidget {
  final String emailAddress = 'elettronicamimmo@gmail.com';
  final String siteUrl =
      'https://sites.google.com/view/berlatomatteo/domotica-pro?authuser=0';
  // ignore: non_constant_identifier_names
  final String FacebUrl =
      'https://sites.google.com/view/berlatomatteo/domotica-pro?authuser=0';

  const HelpPage({super.key});

  void sendEmail() async {
    final Uri email = Uri(
      scheme: 'mailto',
      path: emailAddress,
      query: 'subject=Richiesta aiuto&body=Buongiorno,',
    );
    if (await canLaunchUrl(email)) {
      await launchUrl(email);
    } else {
      throw 'Could not launch $email';
    }
  }

  void openSite() async {
    if (await canLaunchUrl(Uri.parse(siteUrl))) {
      await launchUrl(Uri.parse(siteUrl));
    } else {
      throw 'Could not launch $siteUrl';
    }
  }

  void openFB() async {
    if (await canLaunchUrl(Uri.parse(FacebUrl))) {
      await launchUrl(Uri.parse(FacebUrl));
    } else {
      throw 'Could not launch $FacebUrl';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PalladioAppBar(title: "Risoluzione problemi"),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              PalladioText(
                'Elettronica Mimmo',
                type: PTextType.h2,
                bold: true,
              ),
              PalladioText(
                'Via balestri 23, Carrè(VI)',
                type: PTextType.h3,
              ),
              PalladioText(
                '392 845 7419',
                type: PTextType.h3,
              ),
              SizedBox(
                height: 10,
              ),
              PalladioText(
                'Il nostro indirizzo:',
                type: PTextType.h3,
              ),
              PalladioText(
                emailAddress,
                type: PTextType.h3,
              ),
              PalladioIconButton(
                icon: Icons.email,
                title: 'Scrivi una mail!',
                onPressed: sendEmail,
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                      color: Colors.blueAccent,
                      iconSize: 60,
                      // Use the FaIcon Widget + FontAwesomeIcons class for the IconData
                      icon: FaIcon(FontAwesomeIcons.squareFacebook),
                      onPressed: () {
                        openFB();
                      }),
                  IconButton(
                      color: Colors.blueAccent,
                      iconSize: 60,
                      // Use the FaIcon Widget + FontAwesomeIcons class for the IconData
                      icon: FaIcon(FontAwesomeIcons.google),
                      onPressed: () {
                        openSite();
                      }),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
