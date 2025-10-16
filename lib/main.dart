import 'package:flutter/material.dart';
import 'common/login_page.dart';
import 'common/forgot_password_page.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'services/api_service.dart';
import 'prof/home_page.dart';
import 'students/student_dashboard_screen.dart';
void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}


class _MyAppState extends State<MyApp> {
  Widget _home = const Scaffold(body: Center(child: CircularProgressIndicator()));

  @override
  void initState() {
    super.initState();
    _checkAuth();
  }

  Future<void> _checkAuth() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    
    if (token == null) {
      setState(() => _home = const LoginPage());
      return;
    }

    final api = ApiService();
    try {
      final user = await api.getUser();
      final role = user['role'];

      if (role == 'prof') {
        setState(() => _home = const HomePage());
      } else if (role == 'student') {
        setState(() => _home = const StudentDashboardScreen());
      } else {
        // Unsupported role for mobile app
        await api.logout();
        setState(() => _home = const LoginPage());
      }
    } catch (e) {
      // Token invalid or expired → clear and show login
      await api.logout();
      setState(() => _home = const LoginPage());
    }
  }


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'UCC App',
      theme: ThemeData(primarySwatch: Colors.green),
      // home: const SplashScreen(),
     home: _home,
      // 👉 dito natin dineclare yung routes
      routes: {
        '/login': (context) => const LoginPage(),
        '/forgot_password': (context) => const ForgotPasswordPage(),
      },
    );
  }
}


