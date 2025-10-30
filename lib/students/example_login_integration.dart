// Example integration of facial recognition flow after student login
// This file demonstrates how to trigger the facial recognition flow
// for first-time student login

import 'package:flutter/material.dart';
import 'camera_permission_screen.dart';
import 'student_dashboard_screen.dart';

class ExampleLoginScreen extends StatefulWidget {
  const ExampleLoginScreen({super.key});

  @override
  State<ExampleLoginScreen> createState() => _ExampleLoginScreenState();
}

class _ExampleLoginScreenState extends State<ExampleLoginScreen> {
  bool _isLoading = false;

  /// Simulate login process
  Future<void> _handleLogin(String studentId, String password) async {
    setState(() {
      _isLoading = true;
    });

    try {
      // TODO: Replace with actual API call
      // Example: final response = await AuthAPI.login(studentId, password);

      // Simulate API call
      await Future.delayed(const Duration(seconds: 2));

      // Mock response data
      final bool isFirstTimeLogin = true; // From API response
      final bool hasFacialRecognition = false; // From API response

      if (!mounted) return;

      if (isFirstTimeLogin && !hasFacialRecognition) {
        // Navigate to facial recognition flow
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const CameraPermissionScreen(),
          ),
        );
      } else {
        // Navigate directly to dashboard
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const StudentDashboardScreen(),
          ),
        );
      }
    } catch (e) {
      debugPrint('Login error: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Login failed: $e'),
          backgroundColor: Colors.red,
        ),
      );
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Student Login'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Example Login Screen',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 40),
            ElevatedButton(
              onPressed: _isLoading
                  ? null
                  : () => _handleLogin('student123', 'password'),
              child: _isLoading
                  ? const CircularProgressIndicator()
                  : const Text('Login (First Time)'),
            ),
          ],
        ),
      ),
    );
  }
}

/// Example backend integration for saving facial recognition status
class FacialRecognitionAPI {
  /// Save facial recognition completion status to backend
  static Future<void> saveFacialRecognitionStatus({
    required String studentId,
    required bool isCompleted,
  }) async {
    try {
      // TODO: Replace with actual API call
      // Example:
      // final response = await dio.post(
      //   '/api/students/$studentId/facial-recognition',
      //   data: {'completed': isCompleted},
      // );

      debugPrint('Facial recognition status saved for student: $studentId');
    } catch (e) {
      debugPrint('Error saving facial recognition status: $e');
      rethrow;
    }
  }

  /// Check if student has completed facial recognition
  static Future<bool> checkFacialRecognitionStatus(String studentId) async {
    try {
      // TODO: Replace with actual API call
      // Example:
      // final response = await dio.get(
      //   '/api/students/$studentId/facial-recognition-status',
      // );
      // return response.data['completed'] ?? false;

      // Mock response
      return false;
    } catch (e) {
      debugPrint('Error checking facial recognition status: $e');
      return false;
    }
  }
}

