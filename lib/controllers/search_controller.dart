import 'package:flutter/material.dart';
import 'package:woo_network/controllers/sort_controller.dart';
import 'package:woo_network/controllers/table_list_data_store_controller.dart';
import 'package:woo_network/core/init/injection_container.dart';
import 'package:woo_network/models/transaction_prices.dart';

class SearchController extends ChangeNotifier {
  String searchedText = '';
  List<TransactionPrices> searchedTransactionList = [];

  void clearSearchText() {
    searchedText = '';
    notifyListeners();
  }

  void search(String searchText) {
    searchedText = searchText;
    setSearchedList();
    notifyListeners();
  }

  void setSearchedList() {
    List<TransactionPrices> searchedList = [];
    if (searchedText != '') {
      searchedList.addAll(
        serviceLocator<TableListDataStoreController>().currentTransactionPriceList.where(
              (element) => element.base.toLowerCase().startsWith(searchedText.toLowerCase()),
            ),
      );
      searchedList.addAll(
        serviceLocator<TableListDataStoreController>()
            .currentTransactionPriceList
            .where(
              (element) => (element.base.toLowerCase().contains(searchedText.toLowerCase()) &&
                  !element.base.toLowerCase().startsWith(searchedText.toLowerCase())),
            )
            .toList(),
      );
      serviceLocator<TableListDataStoreController>().setCurrentTransactionPriceList = searchedList;
      searchedTransactionList = searchedList;
    } else {
      serviceLocator<SortController>().applySort();
    }
    notifyListeners();
  }
}
