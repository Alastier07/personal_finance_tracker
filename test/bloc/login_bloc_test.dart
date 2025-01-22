import 'package:bloc_test/bloc_test.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:personal_finance_tracker/blocs/login/login_bloc.dart';
import 'package:personal_finance_tracker/blocs/login/login_event.dart';
import 'package:personal_finance_tracker/blocs/login/login_state.dart';
import 'package:personal_finance_tracker/data/repository/auth_repository.dart';

import '../data/repository/auth/auth_repository_test.mocks.dart';
import 'login_bloc_test.mocks.dart';

@GenerateMocks([AuthRepository, User])
void main() {
  late MockAuthRepository mockAuthRepository;
  late MockUser mockUser;
  late LoginBloc loginBloc;

  setUp(() {
    mockAuthRepository = MockAuthRepository();
    loginBloc = LoginBloc(
      authRepository: mockAuthRepository,
      //   timestamp: mockTimeStamp,
    );
    mockUser = MockUser();
  });

  group('LoginBloc', () {
    const String email = 'testuser@test.com';
    const String password = 'password123';
    blocTest<LoginBloc, LoginState>(
      'emits LoginLoading, LoginSuccess when LoginWithEmailPassword is added',
      build: () {
        when(mockAuthRepository.login(
          email: email,
          password: password,
        )).thenAnswer((_) async => mockUser);

        return loginBloc;
      },
      act: (bloc) => bloc.add(
        const LoginWithEmailPassword(
          email: email,
          password: password,
        ),
      ),
      expect: () => [LoginLoading(), LoginSuccess()],
      verify: (_) {
        verify(mockAuthRepository.login(
          email: email,
          password: password,
        )).called(1);
      },
    );

    blocTest<LoginBloc, LoginState>(
      'emits LoginFailure when LoginWithEmailPassword email is Invalid',
      build: () => loginBloc,
      act: (bloc) {
        const String invalidEmail = 'invalid000001';

        bloc.add(const LoginWithEmailPassword(
          email: invalidEmail,
          password: password,
        ));
      },
      expect: () => [LoginFailure(errorMessage: 'Invalid Email!')],
    );

    blocTest<LoginBloc, LoginState>(
      'emits LoginFailure when LoginWithEmailPassword password is Invalid or Empty',
      build: () => loginBloc,
      act: (bloc) {
        const String invalidPassword = '';

        bloc.add(const LoginWithEmailPassword(
          email: email,
          password: invalidPassword,
        ));
      },
      expect: () => [LoginFailure(errorMessage: 'Invalid Password!')],
    );

    blocTest<LoginBloc, LoginState>(
      'emits LoginFailure when LoginWithEmailPassword user or password is Wrong',
      build: () {
        const String invalidEmail = 'wrongemail@test.com';
        const String invalidPassword = 'wrongpassword';

        when(mockAuthRepository.login(
          email: invalidEmail,
          password: invalidPassword,
        )).thenThrow(Exception('Login failed!'));

        return loginBloc;
      },
      act: (bloc) {
        const String invalidEmail = 'wrongemail@test.com';
        const String invalidPassword = 'wrongpassword';

        bloc.add(const LoginWithEmailPassword(
          email: invalidEmail,
          password: invalidPassword,
        ));
      },
      expect: () => [
        LoginLoading(),
        LoginStopLoading(),
        LoginFailure(errorMessage: 'Login Failed!')
      ],
    );
  });
}
