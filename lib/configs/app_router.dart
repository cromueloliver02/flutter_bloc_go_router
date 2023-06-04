import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../pages/pages.dart';

class AppRouter {
  static final GoRouter router = GoRouter(
    initialLocation: LoginPage.path,
    routes: [
      GoRoute(
        path: LoginPage.path,
        name: LoginPage.name,
        builder: (ctx, state) => const LoginPage(),
      ),
      GoRoute(
        path: HomePage.path,
        name: HomePage.name,
        builder: (ctx, state) => MultiBlocProvider(
          providers: HomePage.blocProviders,
          child: const HomePage(),
        ),
        routes: [
          GoRoute(
            path: ProductsPage.path,
            name: ProductsPage.name,
            builder: (ctx, state) => MultiBlocProvider(
              providers: ProductsPage.blocProviders,
              child: const ProductsPage(),
            ),
          ),
        ],
      ),
    ],
  );
}
