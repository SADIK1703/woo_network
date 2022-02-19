import 'package:flutter/material.dart';
import 'package:woo_network/core/helpers/sort_type.dart';
import 'package:woo_network/core/helpers/tab_type.dart';

class SortController extends ChangeNotifier {
  SortType selectedSortType = SortType.defaultSort;
  TabType selectedTabType = TabType.symbol;

  
}
