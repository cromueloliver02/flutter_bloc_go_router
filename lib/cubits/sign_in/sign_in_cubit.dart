import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../repositories/repositories.dart';

part 'sign_in_state.dart';

class SignInCubit extends Cubit<SignInState> {
  final AuthRepository _authRepository;

  SignInCubit({
    required AuthRepository authRepository,
  })  : _authRepository = authRepository,
        super(SignInState.initial());

  void signIn() async {
    try {
      emit(state.copyWith(status: () => SignInStatus.loading));

      await _authRepository.signIn();

      emit(state.copyWith(status: () => SignInStatus.success));
    } catch (err) {
      emit(state.copyWith(status: () => SignInStatus.failure));
    }
  }
}
