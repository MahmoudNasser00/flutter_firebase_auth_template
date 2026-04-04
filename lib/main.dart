import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'features/auth/views/login_view.dart';
import 'features/home/home_view.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: FirebaseAuth.instance.currentUser == null
          ? const LoginView()
          : const HomeView(),
    );
  }
}
