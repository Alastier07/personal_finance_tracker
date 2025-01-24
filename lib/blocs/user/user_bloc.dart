import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:personal_finance_tracker/data/repository/user_repository.dart';

import 'user_event.dart';
import 'user_state.dart';

class UserBlock extends Bloc<UserEvent, UserState> {
  final UserRepository userRepository;

  UserBlock({required this.userRepository}) : super(UserInitial()) {
    on<UserFetch>((event, emit) async {
      try {
        final user = userRepository.userInfo();
        emit(UserLoaded(user: user));
      } catch (error) {
        print(error);
        emit(UserFailure());
      }
    });
  }
}
