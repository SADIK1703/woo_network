import 'package:flutter/material.dart';
import 'package:woo_network/controllers/table_list_data_store_controller.dart';
import 'package:woo_network/core/helpers/primary_tab_type.dart';
import 'package:woo_network/core/init/injection_container.dart';
import 'package:woo_network/models/futures.dart';
import 'package:woo_network/models/spot.dart';

class PrimaryTabController extends ChangeNotifier {
  PrimaryTabType selectedPrimaryTabType = PrimaryTabType.all;

  set changeSelectedPrimaryTabType(int tabIndex) {
    selectedPrimaryTabType = PrimaryTabType.values[tabIndex];
    notifyListeners();
    if (tabIndex == 1) {
      serviceLocator<TableListDataStoreController>().setCurrentTransactionPriceList =
          serviceLocator<TableListDataStoreController>()
              .currentTransactionPriceList
              .where((element) => element.runtimeType == Spot)
              .toList();
    } else if (tabIndex == 2) {
      serviceLocator<TableListDataStoreController>().setCurrentTransactionPriceList =
          serviceLocator<TableListDataStoreController>()
              .currentTransactionPriceList
              .where((element) => element.runtimeType == Futures)
              .toList();
    }
  }
}
