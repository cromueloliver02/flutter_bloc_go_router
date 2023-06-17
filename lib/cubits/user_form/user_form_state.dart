part of 'user_form_cubit.dart';

class UserFormState extends Equatable {
  final User? selectedUser;

  const UserFormState({
    required this.selectedUser,
  });

  factory UserFormState.initial() {
    return const UserFormState(selectedUser: null);
  }

  @override
  List<Object?> get props => [selectedUser];

  @override
  String toString() => 'UserFormState(selectedUser: $selectedUser)';

  UserFormState copyWith({
    User Function()? selectedUser,
  }) {
    return UserFormState(
      selectedUser: selectedUser != null ? selectedUser() : this.selectedUser,
    );
  }
}
