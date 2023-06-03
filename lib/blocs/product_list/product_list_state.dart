part of 'product_list_bloc.dart';

enum ProductListStatus { initial, loading, success, failure }

class ProductListState extends Equatable {
  final List<String> productList;
  final ProductListStatus status;

  const ProductListState({
    required this.productList,
    required this.status,
  });

  factory ProductListState.initial() {
    return const ProductListState(
      productList: <String>[],
      status: ProductListStatus.initial,
    );
  }

  @override
  List<Object> get props => [productList, status];

  @override
  String toString() =>
      'ProductListState(productList: $productList, status: $status)';

  ProductListState copyWith({
    List<String> Function()? productList,
    ProductListStatus Function()? status,
  }) {
    return ProductListState(
      productList: productList != null ? productList() : this.productList,
      status: status != null ? status() : this.status,
    );
  }
}
