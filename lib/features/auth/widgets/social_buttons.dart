import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SocialButtons extends StatelessWidget {
  final VoidCallback onGoogle;
  final VoidCallback onApple;

  const SocialButtons({
    super.key,
    required this.onGoogle,
    required this.onApple,
  });

  Widget button({
    required IconData icon,
    required String text,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,

      child: Container(
        width: double.infinity,
        height: 50,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.grey),
        ),

        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [FaIcon(icon), const SizedBox(width: 10), Text(text)],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        button(
          icon: FontAwesomeIcons.google,
          text: "Continue with Google",
          onTap: onGoogle,
        ),

        const SizedBox(height: 12),

        button(
          icon: FontAwesomeIcons.apple,
          text: "Continue with Apple",
          onTap: onApple,
        ),
      ],
    );
  }
}
