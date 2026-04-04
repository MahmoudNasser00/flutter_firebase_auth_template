import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubit/auth_cubit.dart';

class SocialLogin extends StatelessWidget {
  const SocialLogin({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(
          icon: const Icon(Icons.facebook, color: Colors.white),
          onPressed: () {},
        ),
        IconButton(
          icon: const Icon(Icons.apple, color: Colors.white),
          onPressed: () {},
        ),
        IconButton(
          icon: const Icon(Icons.g_mobiledata, color: Colors.white),
          onPressed: () {
            context.read<AuthCubit>().googleLogin();
          },
        ),
      ],
    );
  }
}
