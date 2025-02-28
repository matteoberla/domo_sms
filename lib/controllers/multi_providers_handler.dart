import 'package:domo_sms/state_management/centrali_provider/centrali_provider.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

class MultiProvidersHandler {
  List<SingleChildWidget> getProvidersList() {
    return [
      ChangeNotifierProvider(
        create: (_) => CentraliProvider(),
      ),
    ];
  }
}
