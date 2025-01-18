import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/repository/auth_repository.dart';
import 'register_event.dart';
import 'register_state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  final AuthRepository authRepository;

  RegisterBloc({
    required this.authRepository,
  }) : super(RegisterInitial()) {
    on<RegisterWithEmailAndPassword>(
      _onRegisterWithEmailAndPassword,
    );
  }

  void _onRegisterWithEmailAndPassword(event, emit) async {
    if (!event.isValidEmail) {
      emit(RegisterFailure(
        errorMessage: 'Invalid email address',
      ));
      return;
    }

    if (!event.isValidPassword) {
      emit(RegisterFailure(
        errorMessage: 'Password must be 8 characters or more',
      ));
      return;
    }

    if (!event.isValidConfirmPassword) {
      emit(RegisterFailure(
        errorMessage: 'Confirm Password must be the same of your password',
      ));
      return;
    }

    emit(RegisterLoading());

    try {
      await authRepository.register(
        email: event.email,
        password: event.password,
      );
      emit(RegisterSuccess());
    } catch (error) {
      emit(RegisterStopLoading());
      emit(RegisterFailure(
        errorMessage: 'Something went wrong',
      ));
      print(error);
    }
  }
}
