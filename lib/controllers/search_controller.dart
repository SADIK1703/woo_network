import 'package:flutter/material.dart';
import 'package:woo_network/controllers/table_list_data_store_controller.dart';
import 'package:woo_network/core/init/injection_container.dart';
import 'package:woo_network/models/transaction_prices.dart';

class SearchController extends ChangeNotifier {
  String searchedText = '';
  List<TransactionPrices?>? currentSearchedList;

  void clearSearchText() {
    searchedText = '';
  }

  set search(String searchText) {
    searchedText = searchText;
  }

  void setSearchedList() {
    List<TransactionPrices> unsearchedLiat = [];
    unsearchedLiat.addAll(
      serviceLocator<TableListDataStoreController>().transactionPriceList.where(
            (element) => element.base.startsWith(searchedText),
          ),
    );
    unsearchedLiat.addAll(
      serviceLocator<TableListDataStoreController>().transactionPriceList.where(
            (element) => (element.base.contains(searchedText) && !element.base.startsWith(searchedText)),
          ),
    );
  }
}
