part of 'user_list_bloc.dart';

enum UserListStatus { initial, loading, success, failure }

class UserListState extends Equatable {
  final List<User> userList;
  final UserListStatus status;

  const UserListState({
    required this.userList,
    required this.status,
  });

  factory UserListState.initial() {
    return const UserListState(
      userList: <User>[],
      status: UserListStatus.initial,
    );
  }

  @override
  List<Object> get props => [userList, status];

  @override
  String toString() => 'UserListState(userList: $userList, status: $status)';

  UserListState copyWith({
    List<User> Function()? userList,
    UserListStatus Function()? status,
  }) {
    return UserListState(
      userList: userList != null ? userList() : this.userList,
      status: status != null ? status() : this.status,
    );
  }
}
