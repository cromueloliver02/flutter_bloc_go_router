abstract class ProductRepository {
  Future<List<String>> getProducts();
}

class ProductRepositoryImpl implements ProductRepository {
  @override
  Future<List<String>> getProducts() async {
    await Future.delayed(const Duration(seconds: 2));

    final List<String> products = [
      'Bear Brand',
      'Chicharon ni Mang Juan',
      'Nagaraya',
    ];

    return products;
  }
}
