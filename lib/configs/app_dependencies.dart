import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../blocs/blocs.dart';
import '../cubits/cubits.dart';
import '../repositories/repositories.dart';

final GetIt sl = GetIt.instance;

void init() {
  // external depdencies
  sl.registerFactory<Dio>(() => Dio());
  sl.registerSingletonAsync<SharedPreferences>(
    () => SharedPreferences.getInstance(),
  );

  // repositories
  sl.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(prefs: sl<SharedPreferences>()),
  );
  sl.registerFactory<ProductRepository>(() => ProductRepositoryImpl());
  sl.registerFactory<UserRepository>(
    () => UserRepositoryImpl(dio: sl<Dio>()),
  );
  sl.registerFactory<PostRepository>(
    () => PostRepositoryImpl(dio: sl<Dio>()),
  );

  // blocs (singleton)
  sl.registerLazySingleton<UserListBloc>(
    () => UserListBloc(userRepository: sl<UserRepository>()),
  );
  sl.registerLazySingleton<ProductListBloc>(
    () => ProductListBloc(productRepository: sl<ProductRepository>()),
  );

  // blocs (factory)
  sl.registerFactory<AuthBloc>(
    () => AuthBloc(authRepository: sl<AuthRepository>()),
  );
  sl.registerFactory<SubmitProductBloc>(() => SubmitProductBloc());

  // cubits (factory)
  sl.registerFactory<SignInCubit>(
    () => SignInCubit(authRepository: sl<AuthRepository>()),
  );
  sl.registerFactory<UserFormCubit>(() => UserFormCubit());
}
