import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../repositories/repositories.dart';

part 'product_list_event.dart';
part 'product_list_state.dart';

class ProductListBloc extends Bloc<ProductListEvent, ProductListState> {
  final ProductRepository _productRepository;

  ProductListBloc({
    required ProductRepository productRepository,
  })  : _productRepository = productRepository,
        super(ProductListState.initial()) {
    on<ProductListStarted>(_onProductListStarted);
  }

  void _onProductListStarted(
    ProductListStarted event,
    Emitter<ProductListState> emit,
  ) async {
    try {
      emit(state.copyWith(status: () => ProductListStatus.loading));

      final List<String> products = await _productRepository.getProducts();

      emit(state.copyWith(
        productList: () => products,
        status: () => ProductListStatus.success,
      ));
    } catch (err) {
      emit(state.copyWith(status: () => ProductListStatus.failure));
    }
  }
}
