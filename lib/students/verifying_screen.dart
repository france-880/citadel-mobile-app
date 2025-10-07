import 'package:flutter/material.dart';

class VerifyingScreen extends StatefulWidget {
  const VerifyingScreen({super.key});

  @override
  State<VerifyingScreen> createState() => _VerifyingScreenState();
}

class _VerifyingScreenState extends State<VerifyingScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 2), () {
      _showVerifiedSheet();
    });
  }

  void _showVerifiedSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.verified_user, size: 60, color: Colors.green),
              const SizedBox(height: 16),
              const Text(
                "You are verified!",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              const Text(
                "Maria Leonora Theresa\nBSIT 2A\nModern Math\n09-22-25\n09:14 AM",
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF064F32),
                  minimumSize: const Size(double.infinity, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                onPressed: () {
                  Navigator.pop(context); // close bottom sheet
                  Navigator.pop(context); // back to QR Scanner
                  Navigator.pop(context); // back to MySchedule
                },
                child: const Text("Done", style: TextStyle(color: Colors.white)),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FCF9),
      body: SafeArea(
        child: Column(
          children: [
            Align(
              alignment: Alignment.topLeft,
              child: IconButton(
                icon: const Icon(Icons.close, size:30),
                onPressed: () => Navigator.pop(context),
              ),
            ),
            const Spacer(),
            const Text(
              "Verifying...",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            const Text(
              "Please align your face within the circle\nto verify your attendance.",
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 40),
            const CircleAvatar(
              radius: 100,
              backgroundColor: Colors.green,
              child: Icon(Icons.person, size: 120, color: Colors.white),
            ),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}
