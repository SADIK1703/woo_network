import 'package:flutter/material.dart';
import 'package:woo_network/controllers/search_controller.dart';
import 'package:woo_network/controllers/sort_controller.dart';
import 'package:woo_network/controllers/table_list_data_store_controller.dart';
import 'package:woo_network/core/helpers/primary_tab_type.dart';
import 'package:woo_network/core/helpers/sort_type.dart';
import 'package:woo_network/core/helpers/tab_type.dart';
import 'package:woo_network/core/init/injection_container.dart';
import 'package:woo_network/models/futures.dart';
import 'package:woo_network/models/spot.dart';

class PrimaryTabController extends ChangeNotifier {
  PrimaryTabType selectedPrimaryTabType = PrimaryTabType.all;

  void resetSecondaryTabType(int tabIndex) {
    if (tabIndex == 0) {
      serviceLocator<SortController>().setSelectedTabType = TabType.symbol;
      serviceLocator<SortController>().setSelectedSortType = SortType.ascendingSort;
    } else if (tabIndex == 1 || tabIndex == 2) {
      serviceLocator<SortController>().setSelectedTabType = TabType.volume;
      serviceLocator<SortController>().setSelectedSortType = SortType.desccendingSort;
    }
  }

  set changeSelectedPrimaryTabType(int tabIndex) {
    serviceLocator<SortController>().applySort();
    serviceLocator<SearchController>().clearSearchText();
    selectedPrimaryTabType = PrimaryTabType.values[tabIndex];
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
    notifyListeners();
  }
}
