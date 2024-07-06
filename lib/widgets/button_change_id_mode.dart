import 'package:flutter/material.dart';

class ButtonChangeIdMode extends StatelessWidget {
  const ButtonChangeIdMode(
      {super.key, required this.isLogin, required this.onPressed});
  final bool isLogin;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text(isLogin
            ? "Don't you have an account?"
            : "Already have an account?"),
        TextButton(
          onPressed: onPressed,
          child: Text(isLogin ? "Register" : "Login"),
        ),
      ],
    );
  }
}
