import 'package:domo_sms/screens/centrali.dart';
import 'package:domo_sms/screens/comandi_centrale.dart';

class RoutesHandler {
  static const String centraliPage = '/centrali_page';
  static const String comandiCentralePage = '/comandi_centrale_page';

  static final routes = {
    centraliPage: (context) => const CentraliScreen(),
    comandiCentralePage: (context) => const ComandiCentralePage(),
  };
}
