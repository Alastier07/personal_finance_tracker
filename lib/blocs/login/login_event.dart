abstract class LoginEvent {
  const LoginEvent();
}

class LoginWithEmailPassword extends LoginEvent {
  final String email;
  final String password;

  const LoginWithEmailPassword({
    required this.email,
    required this.password,
  });

  bool get isValidEmail => email.contains('@');
  bool get isValidPassword => password.length >= 8;
}
