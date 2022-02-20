import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:woo_network/controllers/primary_tab_state_controller.dart';
import 'package:woo_network/controllers/search_controller.dart';
import 'package:woo_network/controllers/sort_controller.dart';
import 'package:woo_network/controllers/table_list_data_store_controller.dart';
import 'package:woo_network/core/helpers/sort_type.dart';
import 'package:woo_network/core/helpers/tab_type.dart';
import 'package:woo_network/core/init/injection_container.dart';
import 'package:woo_network/views/transaction_price_label.dart';

class TableBody extends StatelessWidget {
  const TableBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer3(
      builder: (
        BuildContext context,
        SortController sortController,
        SearchController searchController,
        PrimaryTabController primaryTabController,
        Widget? child,
      ) {
        return Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: const [
                CustomTab(text: 'Symbol', tabType: TabType.symbol),
                CustomTab(text: 'Last Price', tabType: TabType.lastPrice),
                CustomTab(text: 'Volume', tabType: TabType.volume),
              ],
            ),
            if (serviceLocator<TableListDataStoreController>().currentTransactionPriceList.isEmpty) ...[
              const Expanded(
                child: Center(
                  child: Text(
                    'No results found',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ] else ...[
              Expanded(
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: serviceLocator<TableListDataStoreController>().currentTransactionPriceList.length,
                  itemBuilder: (BuildContext context, int index) {
                    return TransactionPriceLabel(
                        transactionPrice:
                            serviceLocator<TableListDataStoreController>().currentTransactionPriceList[index]);
                  },
                ),
              ),
            ],
          ],
        );
      },
    );
  }
}

class CustomTab extends StatelessWidget {
  const CustomTab({
    Key? key,
    required this.text,
    required this.tabType,
  }) : super(key: key);
  final String text;
  final TabType tabType;
  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (BuildContext context, SortController sortController, Widget? child) {
      return GestureDetector(
        onTap: () {
          sortController.setSort(tabType);
        },
        child: SizedBox(
          height: 20,
          child: Row(
            children: [
              Text(
                text,
                style: TextStyle(
                  color: sortController.selectedTabType == tabType ? Colors.amber : Colors.white,
                ),
              ),
              if (sortController.selectedSortType != SortType.defaultSort && sortController.selectedTabType == tabType)
                Icon(
                  sortController.selectedSortType == SortType.ascendingSort
                      ? Icons.keyboard_arrow_up
                      : Icons.keyboard_arrow_down,
                  color: Colors.yellow,
                )
            ],
          ),
        ),
      );
    });
  }
}
