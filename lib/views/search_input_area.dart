import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:woo_network/controllers/search_controller.dart';
import 'package:woo_network/views/table_body.dart';

class SearchInputArea extends StatelessWidget {
  const SearchInputArea({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (BuildContext context, SearchController searchController, Widget? child) {
        return Column(
          children: [
            TextFormField(
              style: const TextStyle(color: Colors.yellow),
              onChanged: (value) {
                searchController.search(value);
              },
              autovalidateMode: AutovalidateMode.onUserInteraction,
            ),
            const Expanded(child: TableBody()),
          ],
        );
      },
    );
  }
}
