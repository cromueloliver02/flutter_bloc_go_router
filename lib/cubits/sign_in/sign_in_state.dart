part of 'sign_in_cubit.dart';

enum SignInStatus { initial, loading, success, failure }

class SignInState extends Equatable {
  final SignInStatus status;

  const SignInState({
    required this.status,
  });

  factory SignInState.initial() {
    return const SignInState(status: SignInStatus.initial);
  }

  @override
  List<Object> get props => [status];

  @override
  String toString() => 'SignInState(status: $status)';

  SignInState copyWith({
    SignInStatus Function()? status,
  }) {
    return SignInState(
      status: status != null ? status() : this.status,
    );
  }
}
