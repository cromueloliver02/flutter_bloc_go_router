import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'submit_product_event.dart';
part 'submit_product_state.dart';

class SubmitProductBloc extends Bloc<SubmitProductEvent, SubmitProductState> {
  SubmitProductBloc() : super(SubmitProductState.initial()) {
    on<SubmitProductEvent>((event, emit) {});
    on<SubmitProductResetRequested>(_onSubmitProductResetRequested);
  }

  void _onSubmitProductResetRequested(
    SubmitProductResetRequested event,
    Emitter<SubmitProductState> emit,
  ) {
    debugPrint('SubmitProductBloc resetted...');
    emit(SubmitProductState.initial());
  }

  @override
  Future<void> close() {
    debugPrint('SubmitProductBloc closed...');
    return super.close();
  }
}
