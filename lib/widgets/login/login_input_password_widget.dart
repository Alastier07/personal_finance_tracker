import 'package:flutter/material.dart';

class LoginInputPasswordWidget extends StatefulWidget {
  final TextEditingController passwordController;
  final String? label;

  const LoginInputPasswordWidget({
    super.key,
    required this.passwordController,
    this.label,
  });

  @override
  State<LoginInputPasswordWidget> createState() =>
      _LoginInputPasswordWidgetState();
}

class _LoginInputPasswordWidgetState extends State<LoginInputPasswordWidget> {
  bool _hidePassword = true;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.passwordController,
      obscureText: _hidePassword,
      decoration: InputDecoration(
        label: Text(widget.label ?? 'Password'),
        suffixIcon: IconButton(
          onPressed: () {
            setState(() {
              _hidePassword = _hidePassword ? false : true;
            });
          },
          icon: const Icon(Icons.visibility_off_rounded),
        ),
      ),
      keyboardType: TextInputType.visiblePassword,
    );
  }
}
