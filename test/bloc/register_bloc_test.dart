import 'package:bloc_test/bloc_test.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:personal_finance_tracker/blocs/register/register_bloc.dart';
import 'package:personal_finance_tracker/blocs/register/register_event.dart';
import 'package:personal_finance_tracker/blocs/register/register_state.dart';
import 'package:personal_finance_tracker/data/repository/auth_repository.dart';

import '../data/repository/auth/auth_repository_test.mocks.dart';
import 'login_bloc_test.mocks.dart';

@GenerateMocks([AuthRepository, User])
void main() {
  late MockAuthRepository mockAuthRepository;
  late MockUser mockUser;
  late RegisterBloc registerBloc;

  setUp(() {
    mockAuthRepository = MockAuthRepository();
    registerBloc = RegisterBloc(authRepository: mockAuthRepository);
    mockUser = MockUser();
  });

  const email = 'testuser@test.com';
  const password = 'password123';
  const invalidEmail = 'invalidemail';
  const invalidPassword = '12345';
  const invalidConfirmPassword = 'dummy';

  blocTest<RegisterBloc, RegisterState>(
    'emits RegisterLoading, RegisterSuccess when RegisterWithEmailAndPassword is successful',
    build: () {
      when(mockAuthRepository.register(
        email: email,
        password: password,
      )).thenAnswer((_) async => mockUser);

      return registerBloc;
    },
    act: (bloc) => bloc.add(RegisterWithEmailAndPassword(
      email: email,
      password: password,
      confirmPassword: password,
    )),
    expect: () => [RegisterLoading(), RegisterSuccess()],
    verify: (_) {
      verify(mockAuthRepository.register(
        email: email,
        password: password,
      )).called(1);
    },
  );

  blocTest<RegisterBloc, RegisterState>(
    'emits RegisterFailure when RegisterWithEmailAndPassword email is invalid',
    build: () => registerBloc,
    act: (bloc) => bloc.add(RegisterWithEmailAndPassword(
      email: invalidEmail,
      password: password,
      confirmPassword: password,
    )),
    expect: () => [RegisterFailure(errorMessage: 'Invalid email address')],
  );

  blocTest<RegisterBloc, RegisterState>(
    'emits RegisterFailure when RegisterWithEmailAndPassword password is invalid',
    build: () => registerBloc,
    act: (bloc) => bloc.add(RegisterWithEmailAndPassword(
      email: email,
      password: invalidPassword,
      confirmPassword: invalidPassword,
    )),
    expect: () => [
      RegisterFailure(errorMessage: 'Password must be 8 characters or more')
    ],
  );

  blocTest<RegisterBloc, RegisterState>(
    'emits RegisterFailure when RegisterWithEmailAndPassword confirm password is invalid',
    build: () => registerBloc,
    act: (bloc) => bloc.add(RegisterWithEmailAndPassword(
      email: email,
      password: password,
      confirmPassword: invalidConfirmPassword,
    )),
    expect: () => [
      RegisterFailure(
          errorMessage: 'Confirm Password must be the same of your password')
    ],
  );

  blocTest<RegisterBloc, RegisterState>(
    'emits RegisterFailure when RegisterWithEmailAndPassword confirm password is invalid',
    build: () {
      when(mockAuthRepository.register(
        email: email,
        password: password,
      )).thenThrow(Exception('Something went wrong'));

      return registerBloc;
    },
    act: (bloc) => bloc.add(RegisterWithEmailAndPassword(
      email: email,
      password: password,
      confirmPassword: password,
    )),
    expect: () => [
      RegisterLoading(),
      RegisterStopLoading(),
      RegisterFailure(
          errorMessage: 'Confirm Password must be the same of your password'),
    ],
  );
}
