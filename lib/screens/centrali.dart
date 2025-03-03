import 'package:domo_sms/components/centrali_components/centrale_tile.dart';
import 'package:domo_sms/components/palladio_std_components/palladio_app_bar.dart';
import 'package:domo_sms/components/palladio_std_components/palladio_body.dart';
import 'package:domo_sms/components/palladio_std_components/palladio_loading.dart';
import 'package:domo_sms/controllers/centrali_handlers/centrali_callback.dart';
import 'package:domo_sms/controllers/centrali_handlers/centrali_handler.dart';
import 'package:domo_sms/models/centrale_model.dart';
import 'package:domo_sms/state_management/centrali_provider/centrali_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CentraliScreen extends StatefulWidget {
  const CentraliScreen({super.key});

  @override
  State<CentraliScreen> createState() => _CentraliScreenState();
}

class _CentraliScreenState extends State<CentraliScreen> {
  Future<bool>? pageInitialized;

  CentraliHandler centraliHandler = CentraliHandler();
  CentraliCallback centraliCallback = CentraliCallback();

  @override
  void initState() {
    pageInitialized = centraliHandler.initCentraliPage(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var centraliProvider = Provider.of<CentraliProvider>(context, listen: true);

    return Scaffold(
      appBar: PalladioAppBar(title: "DomoSms"),
      body: FutureBuilder(
        future: pageInitialized,
        builder: (context, snapshot) {
          if (snapshot.data != null) {
            return PalladioBody(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisExtent: 80,
                      mainAxisSpacing: 8,
                      crossAxisSpacing: 8),
                  itemBuilder: (context, index) {
                    CentraleModel centrale =
                        centraliProvider.centraliList[index];
                    return CentraleTile(
                        centraliProvider: centraliProvider, centrale: centrale);
                  },
                  itemCount: centraliProvider.centraliListLength,
                ),
              ),
            );
          } else {
            return PalladioLoading(
              absorbing: true,
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await centraliCallback.onAddCentralePressed(
              context, centraliProvider);
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
