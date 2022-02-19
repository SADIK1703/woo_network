import 'package:get_it/get_it.dart';
import 'package:woo_network/controllers/primary_tab_state_controller.dart';
import 'package:woo_network/controllers/sort_controller.dart';

import '../../controllers/search_controller.dart';
import '../../controllers/table_list_data_store_controller.dart';

final serviceLocator = GetIt.instance;

Future<void> init() async {
  serviceLocator.registerLazySingleton<TableListDataStoreController>(
    () => TableListDataStoreController(),
  );
  serviceLocator.registerLazySingleton<SearchController>(
    () => SearchController(),
  );
  serviceLocator.registerLazySingleton<SortController>(
    () => SortController(),
  );
  serviceLocator.registerLazySingleton<PrimaryTabController>(
    () => PrimaryTabController(),
  );
}
