import 'dart:async';

import 'package:fireauth/repo/auth_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart' as fb_auth;

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository authRepository;

  late final StreamSubscription authSubscription;

  AuthBloc({required this.authRepository}) : super(AuthState.unknown()) {
    authSubscription = authRepository.user.listen((fb_auth.User? user) {
      add(AuthStateChangeEvent(user: user));
    });

    on<AuthStateChangeEvent>((event, emit) {
      if (event.user != null) {
        emit(
          state.copyWith(
            authStatus: AuthStatus.authenticated,
            user: event.user,
          ),
        );
      } else {
        emit(
          state.copyWith(
            authStatus: AuthStatus.unauthenticated,
            user: null,
          ),
        );
      }
    });

    on<SignoutEvent>((event, emit) async {
      await authRepository.signout();
    });
  }

  @override
  Future<void> close() {
    authSubscription.cancel();
    return super.close();
  }
}
