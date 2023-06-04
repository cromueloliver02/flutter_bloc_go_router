import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/blocs.dart';
import '../widgets/widgets.dart';
import 'pages.dart';

class ProductsPage extends StatefulWidget {
  const ProductsPage({super.key});

  static const String name = 'product';
  static const String path = name;

  static final SubmitProductBloc _submitProductBloc = SubmitProductBloc();
  static final List<BlocProvider> blocProviders = [
    ...HomePage.blocProviders,
    BlocProvider<SubmitProductBloc>.value(value: _submitProductBloc),
  ];

  @override
  State<ProductsPage> createState() => _ProductsPageState();
}

class _ProductsPageState extends State<ProductsPage> {
  @override
  Widget build(BuildContext context) {
    final ProductListBloc productListBloc = context.read<ProductListBloc>();
    debugPrint('PRODUCTS - ProductListBloc $productListBloc');

    final SubmitProductBloc submitProductBloc =
        context.read<SubmitProductBloc>();
    debugPrint('PRODUCTS - SubmitProductBloc $submitProductBloc');

    return Scaffold(
      appBar: AppBar(title: const Text('PRODUCTS PAGE')),
      body: Center(
        child: Column(
          children: [
            Expanded(
              child: BlocBuilder<ProductListBloc, ProductListState>(
                buildWhen: (prev, curr) => prev.status != curr.status,
                builder: (ctx, state) {
                  if (state.status == ProductListStatus.initial) {
                    return const SizedBox.shrink();
                  }

                  if (state.status == ProductListStatus.loading) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  if (state.status == ProductListStatus.failure) {
                    return const Center(
                      child: Text('Something went wrong'),
                    );
                  }

                  if (state.productList.isEmpty) {
                    return const Center(child: Text('No Products to Show'));
                  }

                  return ProductList(products: state.productList);
                },
              ),
            )
          ],
        ),
      ),
    );
  }

  @override
  void deactivate() {
    context.read<SubmitProductBloc>().add(SubmitProductResetRequested());
    super.deactivate();
  }
}
