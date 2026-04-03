
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubit/auth_cubit.dart';

class SocialLogin extends StatelessWidget {
  const SocialLogin({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 20),
        const Text("Or continue with"),
        const SizedBox(height: 10),
        IconButton(
          icon: const Icon(Icons.g_mobiledata, size: 40),
          onPressed: () {
            context.read<AuthCubit>().googleLogin();
          },
        ),
      ],
    );
  }
}
