import 'package:firebase_auth/firebase_auth.dart';

class AuthRepository {
  final firebaseAuthIntance = FirebaseAuth.instance;

  // Login
  Future<void> login({
    required String email,
    required String password,
  }) async {
    await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  // Logout
  Future<void> logout() async {
    await FirebaseAuth.instance.signOut();
  }

  // Register
  Future<bool> register({
    required String email,
    required String password,
  }) async {
    return true;
  }

  // Check if user is active
  Future<bool> isLogin() async {
    final user = firebaseAuthIntance.currentUser;
    await Future.delayed(const Duration(seconds: 1)); // add delay

    if (user == null) {
      return false;
    } else {
      return true;
    }
  }
}
