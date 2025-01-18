import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/repository/auth_repository.dart';
import 'login_event.dart';
import 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final AuthRepository authRepository;

  LoginBloc({
    required this.authRepository,
  }) : super(LoginInitial()) {
    on<LoginWithEmailPassword>(
      _onLoginWithEmailPassword,
    );
  }

  void _onLoginWithEmailPassword(event, emit) async {
    print(!event.isValidEmail);
    if (!event.isValidEmail) {
      emit(
        LoginFailure(errorMessage: 'Invalid Email!'),
      );
      return;
    }

    if (!event.isValidPassword) {
      emit(
        LoginFailure(errorMessage: 'Invalid Password!'),
      );
      return;
    }

    emit(LoginLoading());

    try {
      await authRepository.login(
        email: event.email,
        password: event.password,
      );

      emit(LoginSuccess());
    } catch (error) {
      emit(LoginStopLoading());
      print(error);
      emit(
        LoginFailure(errorMessage: 'Login Failed!'),
      );
    }
  }
}
