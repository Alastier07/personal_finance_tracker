import 'package:firebase_auth/firebase_auth.dart';

class AuthRepository {
  final firebaseAuthIntance = FirebaseAuth.instance;

  // Login
  Future<bool> login({
    required String email,
    required String password,
  }) async {
    return true;
  }

  // Logout
  Future<void> logout() async {}

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
    await Future.delayed(const Duration(seconds: 2)); // add delay

    if (user == null) {
      return false;
    } else {
      return true;
    }
  }
}
