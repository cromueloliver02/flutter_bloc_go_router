import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'submit_product_event.dart';
part 'submit_product_state.dart';

class SubmitProductBloc extends Bloc<SubmitProductEvent, SubmitProductState> {
  SubmitProductBloc() : super(SubmitProductInitial()) {
    on<SubmitProductEvent>((event, emit) {});
  }
}
