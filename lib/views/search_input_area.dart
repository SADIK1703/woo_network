import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:woo_network/controllers/search_controller.dart';
import 'package:woo_network/controllers/sort_controller.dart';
import 'package:woo_network/core/init/injection_container.dart';
import 'package:woo_network/views/table_body.dart';

class SearchInputArea extends StatelessWidget {
  SearchInputArea({Key? key}) : super(key: key) {
    serviceLocator<SortController>().applySort();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer2(
      builder: (BuildContext context, SearchController searchController, SortController sortController, Widget? child) {
        return Column(
          children: [
            TextFormField(
              cursorColor: Colors.yellow,
              enabled: true,
              decoration: const InputDecoration(
                labelText: 'Type for search',
                labelStyle: TextStyle(color: Colors.white),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.yellow,
                  ),
                ),
              ),
              style: const TextStyle(color: Colors.yellow),
              onChanged: (value) {
                searchController.search(value);
              },
              autovalidateMode: AutovalidateMode.always,
            ),
            const Expanded(
              child: Padding(
                padding: EdgeInsets.all(8),
                child: TableBody(),
              ),
            ),
          ],
        );
      },
    );
  }
}
