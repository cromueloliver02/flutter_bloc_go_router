import 'package:get_it/get_it.dart';

import '../repositories/repositories.dart';

final GetIt sl = GetIt.instance;

void init() {
  sl.registerLazySingleton<ProductRepository>(() => ProductRepositoryImpl());
}
