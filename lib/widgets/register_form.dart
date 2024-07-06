import 'package:flutter/material.dart';
import 'package:taskit/utils/nickname_generator.dart';
import 'package:taskit/utils/validators.dart';

class RegisterForm extends StatefulWidget {
  const RegisterForm(
      {super.key,
      required this.formKey,
      required this.usernameController,
      required this.emailController,
      required this.passwordController,
      required this.passwordConfirmationController});
  final GlobalKey formKey;
  final TextEditingController usernameController;
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final TextEditingController passwordConfirmationController;

  @override
  State<RegisterForm> createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  late bool obscurePassword;

  String? _validatePasswordConfirmation(String? input) {
    if (input != widget.passwordController.text) {
      return 'Passwords do not match';
    }
    return null;
  }

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
            controller: widget.usernameController,
            enableSuggestions: false,
            validator: Validators.validateUsername,
            decoration: InputDecoration(
              prefixIcon: const Icon(Icons.person_rounded),
              suffixIcon: IconButton(
                  onPressed: () {
                    widget.usernameController.text =
                        NicknameGenerator.generateNickname();
                  },
                  icon: const Icon(Icons.refresh)),
              labelText: "Username",
            ),
          ),
          const SizedBox(height: 10),
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
            obscureText: obscurePassword,
            validator: Validators.validatePassword,
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
          const SizedBox(height: 10),
          TextFormField(
            controller: widget.passwordConfirmationController,
            enableSuggestions: false,
            obscureText: obscurePassword,
            validator: _validatePasswordConfirmation,
            decoration: const InputDecoration(
              prefixIcon: Icon(Icons.password_rounded),
              labelText: "Password confirmation",
            ),
          ),
        ],
      ),
    );
  }
}
