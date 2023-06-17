import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../models/models.dart';
import '../../repositories/repositories.dart';

part 'user_list_event.dart';
part 'user_list_state.dart';

class UserListBloc extends Bloc<UserListEvent, UserListState> {
  final UserRepository _userRepository;

  UserListBloc({
    required UserRepository userRepository,
  })  : _userRepository = userRepository,
        super(UserListState.initial()) {
    on<UserListStarted>(_onUsersStarted);
  }

  void _onUsersStarted(
      UserListStarted event, Emitter<UserListState> emit) async {
    try {
      emit(state.copyWith(status: () => UserListStatus.loading));

      final List<User> users = await _userRepository.getUsers();

      emit(state.copyWith(
        userList: () => users,
        status: () => UserListStatus.success,
      ));
    } catch (err) {
      emit(state.copyWith(status: () => UserListStatus.failure));
    }
  }
}
