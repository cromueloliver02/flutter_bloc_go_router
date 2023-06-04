import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
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
    on<ProductListResetRequested>(_onProductListResetRequested);
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

  void _onProductListResetRequested(
    ProductListResetRequested event,
    Emitter<ProductListState> emit,
  ) {
    debugPrint('ProductListBloc resetted...');
    emit(ProductListState.initial());
  }

  @override
  Future<void> close() {
    debugPrint('ProductListBloc closed...');
    return super.close();
  }
}
