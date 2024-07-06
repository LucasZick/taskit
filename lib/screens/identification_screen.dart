import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:taskit/providers/user_data_provider.dart';
import 'package:taskit/services/auth_service.dart';
import 'package:taskit/utils/nickname_generator.dart';
import 'package:taskit/widgets/button_change_id_mode.dart';
import 'package:taskit/widgets/button_switch_brightness.dart';
import 'package:taskit/widgets/form_error_message.dart';
import 'package:taskit/widgets/form_title.dart';
import 'package:taskit/widgets/login_form.dart';
import 'package:taskit/widgets/register_form.dart';

class IdentificationScreen extends StatefulWidget {
  const IdentificationScreen({super.key});

  @override
  State<IdentificationScreen> createState() => _IdentificationScreenState();
}

class _IdentificationScreenState extends State<IdentificationScreen> {
  final loginFormKey = GlobalKey<FormState>();
  final registerFormKey = GlobalKey<FormState>();

  final TextEditingController _usernameController =
      TextEditingController(text: NicknameGenerator.generateNickname());
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _passwordConfirmationController =
      TextEditingController();

  bool isLogin = true;

  String? errorMessage;

  login(
    BuildContext context,
    AuthService authService,
    UserDataProvider userDataProvider,
  ) async {
    setErrorMessage(null);
    if (loginFormKey.currentState!.validate()) {
      try {
        User? currentUser = await authService.signInWithEmailAndPassword(
          _emailController.text,
          _passwordController.text,
        );
        Navigator.of(context).popAndPushNamed('/');
      } on FirebaseAuthException catch (err) {
        setErrorMessage(err.message);
      }
    }
  }

  register(
    BuildContext context,
    AuthService authService,
    UserDataProvider userDataProvider,
  ) async {
    setErrorMessage(null);
    if (registerFormKey.currentState!.validate()) {
      try {
        User? currentUser = await authService.createUserWithEmailAndPassword(
          _emailController.text,
          _passwordController.text,
          _usernameController.text,
        );
      } on FirebaseAuthException catch (err) {
        setErrorMessage(err.message);
      }
    }
  }

  toggleLoginMode() {
    setState(() {
      isLogin = !isLogin;
      errorMessage = null;
    });
  }

  setErrorMessage(String? message) {
    setState(() {
      errorMessage = message;
    });
  }

  @override
  Widget build(BuildContext context) {
    double frameWidth = MediaQuery.of(context).size.width * 0.8;

    AuthService authService = Provider.of<AuthService>(context);
    UserDataProvider userDataProvider =
        Provider.of<UserDataProvider>(context, listen: true);

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        actions: const [ButtonSwitchBrightness()],
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: SizedBox(
            width: frameWidth * 0.3,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                AnimatedSize(
                  duration: const Duration(milliseconds: 200),
                  child: isLogin
                      ? LoginForm(
                          formKey: loginFormKey,
                          emailController: _emailController,
                          passwordController: _passwordController,
                        )
                      : RegisterForm(
                          formKey: registerFormKey,
                          usernameController: _usernameController,
                          emailController: _emailController,
                          passwordController: _passwordController,
                          passwordConfirmationController:
                              _passwordConfirmationController,
                        ),
                ),
                FormErrorMessage(errorMessage: errorMessage),
                ButtonChangeIdMode(
                  isLogin: isLogin,
                  onPressed: toggleLoginMode,
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 50),
                  child: Divider(),
                ),
                TextButton(
                  onPressed: () => isLogin
                      ? login(context, authService, userDataProvider)
                      : register(context, authService, userDataProvider),
                  child: FormTitle(label: isLogin ? "SIGN IN" : "SIGN UP"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
