import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:woo_network/controllers/primary_tab_state_controller.dart';
import 'package:woo_network/controllers/search_controller.dart';
import 'package:woo_network/controllers/sort_controller.dart';
import 'package:woo_network/controllers/table_list_data_store_controller.dart';
import 'package:woo_network/views/table_tab_view.dart';

import 'core/init/injection_container.dart' as dependency_injection;

void main() async {
  await dependency_injection.init();
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider<TableListDataStoreController>(create: (_) => TableListDataStoreController()),
    ChangeNotifierProvider<PrimaryTabController>(create: (_) => PrimaryTabController()),
    ChangeNotifierProvider<SearchController>(create: (_) => SearchController()),
    ChangeNotifierProvider<SortController>(create: (_) => SortController()),
  ], child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const SafeArea(
        child: Scaffold(
          backgroundColor: Colors.black,
          body: TableTabView(),
        ),
      ),
    );
  }
}
