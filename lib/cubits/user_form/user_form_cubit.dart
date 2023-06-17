import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../models/models.dart';

part 'user_form_state.dart';

class UserFormCubit extends Cubit<UserFormState> {
  UserFormCubit() : super(UserFormState.initial());

  void onUserChanged(User? value) {
    if (value == null) return;

    emit(state.copyWith(selectedUser: () => value));
  }
}
