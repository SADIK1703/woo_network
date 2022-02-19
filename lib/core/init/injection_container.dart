import 'package:get_it/get_it.dart';

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
}
