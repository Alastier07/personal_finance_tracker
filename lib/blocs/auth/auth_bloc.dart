import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/repository/auth_repository.dart';
import 'auth_event.dart';
import 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository authRepository;

  AuthBloc({required this.authRepository}) : super(AuthInitial()) {
    on<AppStarted>((event, emit) async {
      final isAuthenticated = await authRepository.isLogin();

      if (isAuthenticated) {
        emit(Authenticated());
      } else {
        emit(Unauthenticated());
      }
    });

    on<LoggedIn>((event, emit) async {
      emit(Authenticated());
    });

    on<LoggedOut>((event, emit) async {
      try {
        await authRepository.logout();
        emit(Unauthenticated());
      } catch (error) {
        print(error);
        emit(
          LogoutFailure(errorMessage: 'Something went wrong, please try again'),
        );
      }
    });
  }
}
