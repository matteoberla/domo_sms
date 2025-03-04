import 'package:domo_sms/screens/centrali.dart';
import 'package:domo_sms/screens/comandi_centrale.dart';
import 'package:domo_sms/screens/help_screen.dart';

class RoutesHandler {
  static const String centraliPage = '/centrali_page';
  static const String comandiCentralePage = '/comandi_centrale_page';

  static const String helpPage = '/help_page';

  static final routes = {
    centraliPage: (context) => const CentraliScreen(),
    comandiCentralePage: (context) => const ComandiCentralePage(),
    helpPage: (context) => const HelpPage(),
  };
}
