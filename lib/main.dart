import 'package:flutter/material.dart';
import 'common/splash_screen.dart';
import 'common/login_page.dart';
import 'common/forgot_password_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'UCC App',
      theme: ThemeData(primarySwatch: Colors.green),
      home: const SplashScreen(),

      // 👉 dito natin dineclare yung routes
      routes: {
        '/login': (context) => const LoginPage(),
        '/forgot_password': (context) => const ForgotPasswordPage(),
      },
    );
  }
}
