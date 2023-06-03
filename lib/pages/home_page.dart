import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_go_router/pages/pages.dart';
import 'package:go_router/go_router.dart';

import '../blocs/blocs.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  static const String name = 'home';
  static const String path = '/$name';

  static List<BlocProvider> blocProviders = [
    BlocProvider<ProductListBloc>(create: (ctx) => ProductListBloc()),
  ];

  @override
  Widget build(BuildContext context) {
    final AuthBloc authBloc = context.read<AuthBloc>();
    debugPrint('HOME - AuthBloc $authBloc');

    final ProductListBloc productListBloc = context.read<ProductListBloc>();
    debugPrint('HOME - ProductListBloc $productListBloc');

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text('HOME PAGE'),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => context.goNamed(ProductsPage.name),
              child: const Text('Go To Products'),
            ),
          ],
        ),
      ),
    );
  }
}
