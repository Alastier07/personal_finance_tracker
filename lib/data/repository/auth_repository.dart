import 'package:firebase_auth/firebase_auth.dart';

class AuthRepository {
  final FirebaseAuth firebaseAuth;

  AuthRepository(this.firebaseAuth);

  // Login
  Future<User?> login({
    required String email,
    required String password,
  }) async {
    final userCredential = await firebaseAuth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );

    return userCredential.user;
  }

  // Logout
  Future<void> logout() async {
    await firebaseAuth.signOut();
  }

  // Register
  Future<User?> register({
    required String email,
    required String password,
  }) async {
    final userCredential = await firebaseAuth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );

    return userCredential.user;
  }

  // Check if user is active
  Future<bool> isLogin() async {
    final user = firebaseAuth.currentUser;
    await Future.delayed(const Duration(seconds: 1)); // add delay

    if (user == null) {
      return false;
    } else {
      return true;
    }
  }
}
