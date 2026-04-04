import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/utils/validators.dart';
import '../../home/home_view.dart';
import '../cubit/auth_cubit.dart';
import '../widgets/password_field.dart';
import '../widgets/social_buttons.dart';
import 'register_view.dart';
import 'forgot_password_view.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final formKey = GlobalKey<FormState>();
  final email = TextEditingController();
  final password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 40),

                const Text(
                  "Sign In",
                  style: TextStyle(fontSize: 34, fontWeight: FontWeight.bold),
                ),

                const SizedBox(height: 10),

                const Text(
                  "Welcome back 👋",
                  style: TextStyle(color: Colors.grey),
                ),

                const SizedBox(height: 40),

                TextFormField(
                  controller: email,
                  validator: Validators.email,
                  decoration: const InputDecoration(
                    labelText: "Email",
                    border: OutlineInputBorder(),
                  ),
                ),

                const SizedBox(height: 16),

                PasswordField(controller: password),

                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    child: const Text("Forgot Password"),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const ForgotPasswordView(),
                        ),
                      );
                    },
                  ),
                ),

                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    child: const Text("Login"),
                    onPressed: () async {
                      if (formKey.currentState!.validate()) {
                        try {
                          await FirebaseAuth.instance
                              .signInWithEmailAndPassword(
                                email: email.text,
                                password: password.text,
                              );

                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(builder: (_) => const HomeView()),
                          );
                        } catch (e) {
                          ScaffoldMessenger.of(
                            context,
                          ).showSnackBar(SnackBar(content: Text(e.toString())));
                        }
                      }
                    },
                  ),
                ),

                const SizedBox(height: 30),

                const Row(
                  children: [
                    Expanded(child: Divider()),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 8),
                      child: Text("OR"),
                    ),
                    Expanded(child: Divider()),
                  ],
                ),

                const SizedBox(height: 20),

                SocialButtons(
                  onGoogle: () {
                    context.read<AuthCubit>().googleLogin();
                    print("Google login pressed");
                  },

                  onApple: () {
                    context.read<AuthCubit>().googleLogin();
                    print("Apple login pressed");
                  },
                ),
                const Spacer(),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Don't have account?"),
                    TextButton(
                      child: const Text("Register"),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const RegisterView(),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
