import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:personal_finance_tracker/data/repository/auth_repository.dart';

import 'auth_repository_test.mocks.dart';

@GenerateMocks([FirebaseAuth, UserCredential, User])
void main() {
  late AuthRepository authRepository;
  late MockFirebaseAuth mockFirebaseAuth;
  late MockUserCredential mockUserCredential;
  late MockUser mockUser;

  setUpAll(() async {
    mockFirebaseAuth = MockFirebaseAuth();
    authRepository = AuthRepository(mockFirebaseAuth);
    mockUserCredential = MockUserCredential();
    mockUser = MockUser();
  });

  group(
    'AuthRepository Login',
    () {
      test(
        'Login return Users when credentials are correct',
        () async {
          const email = 'testuser@test.com';
          const password = 'password123';

          when(mockFirebaseAuth.signInWithEmailAndPassword(
            email: email,
            password: password,
          )).thenAnswer((_) async => mockUserCredential);

          when(mockUserCredential.user).thenReturn(mockUser);

          final user = await authRepository.login(
            email: email,
            password: password,
          );

          expect(user, mockUser);

          verify(mockFirebaseAuth.signInWithEmailAndPassword(
            email: email,
            password: password,
          )).called(1);
        },
      );

      test(
        'Login throws exception when FirebaseAuth throws an error',
        () {
          const email = 'testuser@test.com';
          const password = 'wrongpassword';

          when(mockFirebaseAuth.signInWithEmailAndPassword(
            email: email,
            password: password,
          )).thenThrow(FirebaseAuthException(
            code: 'wrong-password',
            message:
                'The password is invalid or the user does not have a password.',
          ));

          Future<void> authLogin() => authRepository.login(
                email: email,
                password: password,
              );

          expect(authLogin, throwsException);
        },
      );
    },
  );

  group(
    'AuthRespository Registration',
    () {
      test(
        'Successful Registration',
        () async {
          const String email = 'testuser2@test.com';
          const String password = 'password123';

          Future<UserCredential?> userRegistration() async =>
              mockFirebaseAuth.createUserWithEmailAndPassword(
                email: email,
                password: password,
              );

          when(userRegistration()).thenAnswer((_) async => mockUserCredential);

          when(mockUserCredential.user).thenReturn(mockUser);

          final user = await authRepository.register(
            email: email,
            password: password,
          );

          expect(user, mockUser);

          verify(userRegistration()).called(1);
        },
      );

      test('Unsuccessful Registration - Email Already Exist', () {
        const String email = 'testuser2@test.com';
        const String password = 'password123';

        when(mockFirebaseAuth.createUserWithEmailAndPassword(
          email: email,
          password: password,
        )).thenThrow(
          FirebaseAuthException(
            code: 'email-already-exists',
            message:
                'The provided email is already in use by an existing user. Each user must have a unique email.',
          ),
        );

        Future<void> authRegistration() async => authRepository.register(
              email: email,
              password: password,
            );

        expect(authRegistration, throwsException);
      });
    },
  );
}
