import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../pages/pages.dart';

class AppRouter {
  static final GoRouter router = GoRouter(
    initialLocation: HomePage.path,
    routes: [
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
              providers: [
                ...HomePage.blocProviders,
                ...ProductsPage.blocProviders,
              ],
              child: const ProductsPage(),
            ),
          ),
        ],
      ),
    ],
  );
}
