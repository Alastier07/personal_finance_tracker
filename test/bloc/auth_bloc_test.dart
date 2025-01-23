import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:personal_finance_tracker/blocs/auth/auth_bloc.dart';
import 'package:personal_finance_tracker/blocs/auth/auth_event.dart';
import 'package:personal_finance_tracker/blocs/auth/auth_state.dart';
import 'package:personal_finance_tracker/data/repository/auth_repository.dart';

import 'login_bloc_test.mocks.dart';

@GenerateMocks([AuthRepository])
void main() {
  late MockAuthRepository mockAuthRepository;
  late AuthBloc authBloc;

  setUp(() {
    mockAuthRepository = MockAuthRepository();
    authBloc = AuthBloc(authRepository: mockAuthRepository);
  });

  blocTest<AuthBloc, AuthState>(
      'emits Unauthenticated when logout is successful',
      build: () {
        when(mockAuthRepository.logout()).thenAnswer((_) async => true);
        return authBloc;
      },
      act: (bloc) => bloc.add(LoggedOut()),
      expect: () => [Unauthenticated()],
      verify: (_) {
        verify(mockAuthRepository.logout()).called(1);
      });

  blocTest<AuthBloc, AuthState>(
    'emits LogoutFailure when logout is unsuccessful',
    build: () {
      when(mockAuthRepository.logout()).thenThrow(
        Exception('Something went wrong, please try again'),
      );
      return authBloc;
    },
    act: (bloc) => bloc.add(LoggedOut()),
    expect: () => [
      LogoutFailure(errorMessage: 'Something went wrong, please try again'),
    ],
  );
}
