import 'package:flutter/material.dart';
import 'package:taskit/utils/validators.dart';

class LoginForm extends StatefulWidget {
  const LoginForm(
      {super.key,
      required this.formKey,
      required this.emailController,
      required this.passwordController});
  final GlobalKey formKey;
  final TextEditingController emailController;
  final TextEditingController passwordController;

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  late bool obscurePassword;

  toggleObscurePassword() {
    setState(() {
      obscurePassword = !obscurePassword;
    });
  }

  @override
  void initState() {
    obscurePassword = true;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: widget.formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextFormField(
            controller: widget.emailController,
            enableSuggestions: false,
            validator: Validators.validateEmail,
            decoration: const InputDecoration(
              prefixIcon: Icon(Icons.email),
              labelText: "Email",
            ),
          ),
          const SizedBox(height: 10),
          TextFormField(
            controller: widget.passwordController,
            enableSuggestions: false,
            validator: Validators.validatePassword,
            obscureText: obscurePassword,
            decoration: InputDecoration(
              prefixIcon: const Icon(Icons.password_rounded),
              suffixIcon: IconButton(
                onPressed: toggleObscurePassword,
                icon: Icon(
                  obscurePassword ? Icons.visibility_off : Icons.visibility,
                ),
              ),
              labelText: "Password",
            ),
          ),
        ],
      ),
    );
  }
}
