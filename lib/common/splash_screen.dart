import 'dart:async';
import 'package:flutter/material.dart';
import '../common/login_page.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  Timer? _timer;

  @override
  void initState() {
    super.initState();

    // Only one Timer, no duplicated navigation calls
    _timer = Timer(const Duration(seconds: 3), () {
      if (!mounted) return; // <- ensures the widget still exists
      Navigator.of(
        context,
      ).pushReplacement(MaterialPageRoute(builder: (_) => const LoginPage()));
    });
  }

  @override
  void dispose() {
    // cancel the timer before widget is destroyed
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Replace with your actual asset path
            Image(
              image: AssetImage("assets/images/ucc_logo.png"),
              width: 250,
              height: 310,
            ),
            SizedBox(height: 5),
            Text(
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