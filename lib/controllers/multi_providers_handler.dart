import 'package:domo_sms/state_management/centrali_provider/centrali_provider.dart';
import 'package:domo_sms/state_management/http_provider/http_provider.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

class MultiProvidersHandler {
  List<SingleChildWidget> getProvidersList() {
    return [
      ChangeNotifierProvider(
        create: (_) => HttpProvider(),
      ),
      ChangeNotifierProvider(
        create: (_) => CentraliProvider(),
      ),
    ];
  }
}
