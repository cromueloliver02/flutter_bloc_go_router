import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../blocs/blocs.dart';
import '../cubits/cubits.dart';
import '../repositories/repositories.dart';

final GetIt sl = GetIt.instance;

void init() {
  // external depdencies
  sl.registerSingletonAsync<SharedPreferences>(
    () => SharedPreferences.getInstance(),
  );

  // repositories
  sl.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(prefs: sl<SharedPreferences>()),
  );
  sl.registerLazySingleton<ProductRepository>(() => ProductRepositoryImpl());

  // blocs (singleton)
  sl.registerLazySingleton<ProductListBloc>(
    () => ProductListBloc(productRepository: sl<ProductRepository>()),
  );

  // blocs (factory)
  // TODO: might register it as singleton instance soon
  sl.registerFactory<AuthBloc>(
    () => AuthBloc(authRepository: sl<AuthRepository>()),
  );
  sl.registerFactory<SubmitProductBloc>(() => SubmitProductBloc());

  // cubits (singleton)
  sl.registerFactory<SignInCubit>(
    () => SignInCubit(authRepository: sl<AuthRepository>()),
  );

  // cubits (factory)
}
