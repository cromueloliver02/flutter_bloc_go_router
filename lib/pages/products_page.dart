import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/blocs.dart';

class ProductsPage extends StatelessWidget {
  const ProductsPage({super.key});

  static const String name = 'product';
  static const String path = name;

  static final List<BlocProvider> blocProviders = [
    BlocProvider<SubmitProductBloc>(create: (ctx) => SubmitProductBloc()),
  ];

  @override
  Widget build(BuildContext context) {
    final ProductListBloc productListBloc = context.read<ProductListBloc>();
    debugPrint('PRODUCTS - ProductListBloc $productListBloc');

    final SubmitProductBloc submitProductBloc =
        context.read<SubmitProductBloc>();
    debugPrint('PRODUCTS - SubmitProductBloc $submitProductBloc');

    return Scaffold(
      appBar: AppBar(),
      body: const Center(
        child: Text('PRODUCTS PAGE'),
      ),
    );
  }
}
