import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../models/models.dart';
import '../../repositories/repositories.dart';

part 'users_event.dart';
part 'users_state.dart';

class UsersBloc extends Bloc<UsersEvent, UsersState> {
  final UserRepository _userRepository;

  UsersBloc({
    required UserRepository userRepository,
  })  : _userRepository = userRepository,
        super(UsersState.initial()) {
    on<UsersStarted>(_onUsersStarted);
  }

  void _onUsersStarted(UsersStarted event, Emitter<UsersState> emit) async {
    try {
      emit(state.copyWith(status: () => UsersStatus.loading));

      final List<User> users = await _userRepository.getUsers();

      emit(state.copyWith(
        userList: () => users,
        status: () => UsersStatus.success,
      ));
    } catch (err) {
      emit(state.copyWith(status: () => UsersStatus.failure));
    }
  }
}
