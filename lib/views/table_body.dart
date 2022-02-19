import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:woo_network/controllers/search_controller.dart';
import 'package:woo_network/controllers/sort_controller.dart';
import 'package:woo_network/controllers/table_list_data_store_controller.dart';
import 'package:woo_network/core/helpers/tab_type.dart';
import 'package:woo_network/core/init/injection_container.dart';
import 'package:woo_network/views/transaction_price_label.dart';

class TableBody extends StatelessWidget {
  const TableBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer2(
      builder: (BuildContext context, SortController sortController, SearchController searchController, Widget? child) {
        return Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  'Symbol',
                  style:
                      TextStyle(color: sortController.selectedTabType == TabType.symbol ? Colors.amber : Colors.white),
                ),
                Text(
                  'Last Price',
                  style:
                      TextStyle(color: sortController.selectedTabType == TabType.symbol ? Colors.amber : Colors.white),
                ),
                Text(
                  'Volume',
                  style:
                      TextStyle(color: sortController.selectedTabType == TabType.symbol ? Colors.amber : Colors.white),
                ),
              ],
            ),
            if (sortController.sortedTransactionPriceList.isEmpty) ...[
              const Text(
                'No results found',
                style: TextStyle(
                  color: Colors.white,
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
