import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/blocs.dart';

class ProductList extends StatelessWidget {
  const ProductList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductListBloc, ProductListState>(
      buildWhen: (prev, curr) => prev.status != curr.status,
      builder: (ctx, state) {
        if (state.productList.isEmpty) {
          return const Center(child: Text('No products to show'));
        }

        return ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: state.productList.length,
          itemBuilder: (ctx, idx) => ListTile(
            leading: const Icon(Icons.circle, size: 10),
            title: Text(state.productList[idx]),
          ),
        );
      },
    );
  }
}
