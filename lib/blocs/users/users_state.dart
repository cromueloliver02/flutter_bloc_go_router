part of 'users_bloc.dart';

enum UsersStatus { initial, loading, success, failure }

class UsersState extends Equatable {
  final List<User> userList;
  final UsersStatus status;

  const UsersState({
    required this.userList,
    required this.status,
  });

  factory UsersState.initial() {
    return const UsersState(
      userList: <User>[],
      status: UsersStatus.initial,
    );
  }

  @override
  List<Object> get props => [userList, status];

  @override
  String toString() => 'UsersState(userList: $userList, status: $status)';

  UsersState copyWith({
    List<User> Function()? userList,
    UsersStatus Function()? status,
  }) {
    return UsersState(
      userList: userList != null ? userList() : this.userList,
      status: status != null ? status() : this.status,
    );
  }
}
