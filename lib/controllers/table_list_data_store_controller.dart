import 'package:flutter/material.dart';
import 'package:woo_network/core/mock_data/mock_table_data.dart';
import 'package:woo_network/models/futures.dart';
import 'package:woo_network/models/spot.dart';
import 'package:woo_network/models/transaction_prices.dart';

class TableListDataStoreController extends ChangeNotifier {
  TableListDataStoreController() {
    setDefaultTransactionList();
    setCurrentTransactionPriceList = defaultTransactionPriceList;
  }
  final List<TransactionPrices> currentTransactionPriceList = [];

  set setCurrentTransactionPriceList(List<TransactionPrices> transactionPriceList) {
    currentTransactionPriceList.clear();
    currentTransactionPriceList.addAll(transactionPriceList);
    notifyListeners();
  }

  void setDefaultTransactionList() {
    for (var transactionItem in mockTableData) {
      if (transactionItem["type"] == 'SPOT') {
        Spot spotTypeTransactionPrice = Spot.fromMap(transactionItem);
        defaultTransactionPriceList.add(spotTypeTransactionPrice);
      } else if (transactionItem["type"] == "FUTURES") {
        Futures futuresTypeTransactionPrice = Futures.fromMap(transactionItem);
        defaultTransactionPriceList.add(futuresTypeTransactionPrice);
      }
    }
  }

  List<TransactionPrices> defaultTransactionPriceList = [];
}
