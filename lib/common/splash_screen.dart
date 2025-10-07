import 'dart:async';
import 'package:flutter/material.dart';
import '../common/login_page.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    // NAVIGATE TO LOGIN PAGE AFTER 3 SECONDS
    Timer(const Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const LoginPage()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset("assets/images/ucc_logo.png", width: 250, height: 310),
            const SizedBox(height: 5),
            const Text(
              "UCC",
              style: TextStyle(
                fontFamily: 'Sora',
                fontSize: 38,
                fontWeight: FontWeight.w600,
                color: Color(0xFF43A047),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
