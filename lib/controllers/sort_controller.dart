import 'package:flutter/material.dart';
import 'package:woo_network/controllers/table_list_data_store_controller.dart';
import 'package:woo_network/core/helpers/sort_type.dart';
import 'package:woo_network/core/helpers/tab_type.dart';
import 'package:woo_network/core/init/injection_container.dart';
import 'package:woo_network/models/spot.dart';
import 'package:woo_network/models/transaction_prices.dart';

class SortController extends ChangeNotifier {
  SortController() {
    applySort();
  }
  SortType _selectedSortType = SortType.defaultSort;
  TabType selectedTabType = TabType.symbol;
  List<TransactionPrices> sortedTransactionPriceList = [];

  SortType get selectedSortType => _selectedSortType;

  set setSelectedSortType(SortType sortType) {
    _selectedSortType = sortType;
    notifyListeners();
  }

  void resetSorts() {
    setSelectedSortType = SortType.defaultSort;
    notifyListeners();
  }

  void setSort(TabType clickedTabType) {
    if (clickedTabType == selectedTabType) {
      changeSortType();
    } else {
      selectChangeTabType(clickedTabType);
    }
  }

  void changeSortType() {
    switch (selectedSortType) {
      case SortType.defaultSort:
        setSelectedSortType = SortType.ascendingSort;
        break;
      case SortType.ascendingSort:
        setSelectedSortType = SortType.desccendingSort;
        break;
      case SortType.desccendingSort:
        setSelectedSortType = SortType.defaultSort;
        break;
    }
  }

  void selectChangeTabType(TabType newTabType) {
    selectedTabType = newTabType;
    notifyListeners();
  }

  void applySort() {
    sortedTransactionPriceList.clear();
    List<TransactionPrices> transactionPriceList = TableListDataStoreController().currentTransactionPriceList;
    switch (selectedTabType) {
      case TabType.symbol:
        switch (selectedSortType) {
          case SortType.defaultSort:
            sortedTransactionPriceList.addAll(
              priorTransactionPriceList(transactionPriceList),
            );
            sortedTransactionPriceList.add(Spot('1', '1', 1.0, 1.0));
            sortedTransactionPriceList.addAll(nonpriorTransactionPriceList(transactionPriceList));
            break;
          case SortType.ascendingSort:
            List<TransactionPrices> willSortList = transactionPriceList;
            willSortList.sort(ascendingTransectionPriceSymbolSort);
            sortedTransactionPriceList = willSortList;
            break;
          case SortType.desccendingSort:
            List<TransactionPrices> willSortList = transactionPriceList;
            willSortList.sort(descendingTransectionPriceSymbolSort);
            sortedTransactionPriceList = willSortList;
            break;
        }
        break;
      case TabType.lastPrice:
        switch (selectedSortType) {
          case SortType.defaultSort:
            sortedTransactionPriceList.addAll(
              priorTransactionPriceList(transactionPriceList),
            );
            sortedTransactionPriceList.addAll(nonpriorTransactionPriceList(transactionPriceList));
            break;
          case SortType.ascendingSort:
            List<TransactionPrices> willSortList = transactionPriceList;
            willSortList.sort(ascendingTransectionPriceLastPriceSort);
            sortedTransactionPriceList = willSortList;
            break;
          case SortType.desccendingSort:
            List<TransactionPrices> willSortList = transactionPriceList;
            willSortList.sort(descendingTransectionPriceLastPriceSort);
            sortedTransactionPriceList = willSortList;
            break;
        }
        break;
      case TabType.volume:
        switch (selectedSortType) {
          case SortType.defaultSort:
            sortedTransactionPriceList.addAll(
              priorTransactionPriceList(transactionPriceList),
            );
            sortedTransactionPriceList.addAll(nonpriorTransactionPriceList(transactionPriceList));
            break;
          case SortType.ascendingSort:
            List<TransactionPrices> willSortList = transactionPriceList;
            willSortList.sort(ascendingTransectionPriceVolumeSort);
            sortedTransactionPriceList = willSortList;
            break;
          case SortType.desccendingSort:
            List<TransactionPrices> willSortList = transactionPriceList;
            willSortList.sort(descendingTransectionPriceVolumeSort);
            sortedTransactionPriceList = willSortList;
            break;
        }
    }
    notifyListeners();

    serviceLocator<TableListDataStoreController>().setCurrentTransactionPriceList = sortedTransactionPriceList;
  }

  /// ascending sort by symbol
  int ascendingTransectionPriceSymbolSort(
      TransactionPrices firstTransactionPrice, TransactionPrices secondTransactionPrice) {
    if (firstTransactionPrice.base != secondTransactionPrice.base) {
      return firstTransactionPrice.base.compareTo(secondTransactionPrice.base);
    } else {
      return firstTransactionPrice.qoute.compareTo(secondTransactionPrice.qoute);
    }
  }

  /// descending sort by symbol
  int descendingTransectionPriceSymbolSort(
      TransactionPrices firstTransactionPrice, TransactionPrices secondTransactionPrice) {
    if (secondTransactionPrice.base != firstTransactionPrice.base) {
      return secondTransactionPrice.base.compareTo(firstTransactionPrice.base);
    } else {
      return secondTransactionPrice.qoute.compareTo(firstTransactionPrice.qoute);
    }
  }

  /// ascending sort by lastPrice
  int ascendingTransectionPriceLastPriceSort(
      TransactionPrices firstTransactionPrice, TransactionPrices secondTransactionPrice) {
    return firstTransactionPrice.lastPrice.compareTo(secondTransactionPrice.lastPrice);
  }

  /// descending sort by lastPrice
  int descendingTransectionPriceLastPriceSort(
      TransactionPrices firstTransactionPrice, TransactionPrices secondTransactionPrice) {
    return firstTransactionPrice.lastPrice.compareTo(secondTransactionPrice.lastPrice);
  }

  /// ascending sort by volume
  int ascendingTransectionPriceVolumeSort(
      TransactionPrices firstTransactionPrice, TransactionPrices secondTransactionPrice) {
    return firstTransactionPrice.volume.compareTo(secondTransactionPrice.volume);
  }

  /// descending sort by volume
  int descendingTransectionPriceVolumeSort(
      TransactionPrices firstTransactionPrice, TransactionPrices secondTransactionPrice) {
    return firstTransactionPrice.volume.compareTo(secondTransactionPrice.volume);
  }

  /// select for non-prior transactions
  List<TransactionPrices> nonpriorTransactionPriceList(List<TransactionPrices> transactionPriceList) {
    var ret = transactionPriceList
        .where((element) => (element.base != "BTC" && element.base != "ETH" && element.base != "WOO"))
        .toList();
    ret.sort(ascendingTransectionPriceSymbolSort);
    return ret;
  }

  /// select for prior transactions
  List<TransactionPrices> priorTransactionPriceList(List<TransactionPrices> transactionPriceList) {
    var ret = transactionPriceList
        .where((element) => (element.base == "BTC" || element.base == "ETH" || element.base == "WOO"))
        .toList();
    ret.sort(ascendingTransectionPriceSymbolSort);
    return ret;
  }
}
