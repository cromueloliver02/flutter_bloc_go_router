import 'package:flutter/material.dart';

class ProductList extends StatelessWidget {
  final List<String> products;

  const ProductList({
    super.key,
    required this.products,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: products.length,
      itemBuilder: (ctx, idx) => ListTile(
        leading: const Icon(Icons.circle, size: 10),
        title: Text(products[idx]),
      ),
    );
  }
}
