import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../models/models.dart';
import '../../repositories/repositories.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository _authRepository;

  AuthBloc({
    required AuthRepository authRepository,
  })  : _authRepository = authRepository,
        super(AuthState.initial()) {
    on<AuthStarted>(_onAuthStarted);
    on<AuthSignOutRequested>(_onAuthSignOutRequested);
  }

  void _onAuthStarted(
    AuthStarted event,
    Emitter<AuthState> emit,
  ) async {
    final Stream<User?> userAuthStream = _authRepository.userStateChanges;

    await emit.onEach<User?>(
      userAuthStream,
      onData: (User? user) {
        if (user == null) {
          emit(state.copyWith(
            user: () => null,
            status: () => AuthStatus.unauthenticated,
          ));
        }

        if (user != null) {
          emit(state.copyWith(
            user: () => user,
            status: () => AuthStatus.authenticated,
          ));
        }
      },
    );
  }

  void _onAuthSignOutRequested(
    AuthSignOutRequested event,
    Emitter<AuthState> emit,
  ) async {
    await _authRepository.signOut();
  }

  @override
  Future<void> close() {
    debugPrint('AuthBloc closed...');
    return super.close();
  }
}
