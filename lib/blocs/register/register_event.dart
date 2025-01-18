abstract class RegisterEvent {
  const RegisterEvent();
}

class RegisterWithEmailAndPassword extends RegisterEvent {
  final String email;
  final String password;
  final String confirmPassword;

  RegisterWithEmailAndPassword({
    required this.email,
    required this.password,
    required this.confirmPassword,
  });

  bool get isValidEmail => email.contains('@');
  bool get isValidPassword => password.length >= 8;
  bool get isValidConfirmPassword => password == confirmPassword;
}
