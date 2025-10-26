import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:citadel/services/auth_services.dart';
import 'package:citadel/providers/auth_providers.dart';
import 'package:citadel/prof/home_page.dart';
import 'package:citadel/students/student_dashboard_screen.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final TextEditingController _studentNumberController =
      TextEditingController();
  final TextEditingController _emailController = TextEditingController();

  bool _isForgotPassword = false;
  bool _obscurePassword = true;
  final bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);

    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Column(
        children: [
          // TOP LOGO
          Expanded(
            flex: 2,
            child: Container(
              color: Colors.white,
              child: Center(
                child: Image.asset(
                  "assets/images/ucc_logo.png",
                  width: 330,
                  height: 330,
                  fit: BoxFit.contain,
                ),
              ),
            ),
          ),

          // LOGIN / FORGOT AREA
          Expanded(
            flex: 4,
            child: Container(
              decoration: const BoxDecoration(
                color: Color(0xFF064F32),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(32),
                  topRight: Radius.circular(32),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(32.0),
                child: SingleChildScrollView(
                  child: AnimatedSwitcher(
                    duration: const Duration(milliseconds: 500),
                    transitionBuilder: (child, animation) {
                      final offsetAnimation = Tween<Offset>(
                        begin: child.key == const ValueKey("forgot")
                            ? const Offset(0, -0.3)
                            : const Offset(0, 0.3),
                        end: Offset.zero,
                      ).animate(animation);

                      return FadeTransition(
                        opacity: animation,
                        child: SlideTransition(
                          position: offsetAnimation,
                          child: child,
                        ),
                      );
                    },
                    child: _isForgotPassword
                        ? _buildForgotForm()
                        : _buildLoginForm(authProvider),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ---------------- LOGIN FORM ----------------
  Widget _buildLoginForm(AuthProvider authProvider) {
    return Column(
      key: const ValueKey("login"),
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Text(
          "Welcome",
          style: TextStyle(
            color: Colors.white,
            fontSize: 34,
            fontWeight: FontWeight.bold,
            height: 1.3,
          ),
          textAlign: TextAlign.center,
        ),
        const Text(
          "Login to your account",
          style: TextStyle(color: Colors.white70, fontSize: 18, height: 1.2),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 40),

        _buildLabel("Email or Username"),
        const SizedBox(height: 6),
        _buildTextBox(_usernameController, "Enter email or username", false),

        const SizedBox(height: 20),

        _buildLabel("Password"),
        const SizedBox(height: 6),
        _buildTextBox(_passwordController, "Enter password", true),

        Align(
          alignment: Alignment.centerRight,
          child: TextButton(
            onPressed: () {
              setState(() => _isForgotPassword = true);
            },
            child: const Text(
              "Forgot Password?",
              style: TextStyle(color: Color(0xFFFF9800), fontSize: 14),
            ),
          ),
        ),

        const SizedBox(height: 40),

        _isLoading
            ? const CircularProgressIndicator(color: Colors.white)
            : _buildButton("Login", () async {
                final username = _usernameController.text.trim();
                final password = _passwordController.text.trim();

                if (username.isEmpty || password.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Please enter username and password'),
                    ),
                  );
                  return;
                }

                final result = await AuthService.login(
                  username: username,
                  password: password,
                );

                if (result['success'] == true) {
                  final user = result['user'];

                  // Normalize origin & role to avoid mismatches between backend
                  // slugs and frontend checks. Backend may use 'accounts' or
                  // 'users' for professors and uses 'prof' as the role slug.
                  final originRaw = (user['origin'] ?? '')
                      .toString()
                      .toLowerCase();
                  final roleRaw = (user['role'] ?? '').toString().toLowerCase();

                  final origin = originRaw;
                  final role = roleRaw;

                  final bool isStudent = origin == 'students';
                  final bool isProfessor =
                      (origin == 'users' || origin == 'accounts') &&
                      (role == 'prof' ||
                          role == 'professor' ||
                          role == 'faculty');
                  final bool isProgramHead =
                      (origin == 'users' || origin == 'accounts') &&
                      role == 'program_head';

                  if (isStudent) {
                    // Go to Student Dashboard
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const StudentDashboardScreen(),
                      ),
                    );
                  } else if (isProfessor || isProgramHead) {
                    // Go to Professor Dashboard
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (_) => const HomePage()),
                    );
                  } else {
                    // If we get here, backend returned an account we don't handle
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Invalid account type')),
                    );
                  }
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(result['message'] ?? 'Login failed'),
                    ),
                  );
                }
              }),
      ],
    );
  }

  // ---------------- FORGOT PASSWORD FORM ----------------
  Widget _buildForgotForm() {
    return Column(
      key: const ValueKey("forgot"),
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Text(
          "Forgot Password?",
          style: TextStyle(
            color: Colors.white,
            fontSize: 28,
            fontWeight: FontWeight.bold,
            height: 1.3,
          ),
          textAlign: TextAlign.center,
        ),
        const Text(
          "Please enter your credentials\nto reset your password.",
          style: TextStyle(color: Colors.white70, fontSize: 16, height: 1.3),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 40),

        _buildLabel("Student Number"),
        const SizedBox(height: 6),
        _buildTextBox(_studentNumberController, "Enter student number", false),

        const SizedBox(height: 20),

        _buildLabel("Email"),
        const SizedBox(height: 6),
        _buildTextBox(_emailController, "Enter email", false),

        const SizedBox(height: 40),

        _buildButton("Send", () {
          _showSnackBar("Password reset feature coming soon!", true);
        }),

        const SizedBox(height: 16),

        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "Remember Password? ",
              style: TextStyle(color: Colors.white, fontSize: 14),
            ),
            GestureDetector(
              onTap: () {
                setState(() => _isForgotPassword = false);
              },
              child: const Text(
                "Sign In",
                style: TextStyle(
                  color: Color(0xFFFF9800),
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  // ---------------- HELPERS ----------------
  Widget _buildLabel(String text) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Text(
        text,
        style: const TextStyle(color: Colors.white, fontSize: 16),
      ),
    );
  }

  Widget _buildTextBox(
    TextEditingController controller,
    String hint,
    bool isPassword,
  ) {
    return TextField(
      controller: controller,
      obscureText: isPassword ? _obscurePassword : false,
      style: const TextStyle(color: Colors.white),
      decoration: InputDecoration(
        filled: true,
        fillColor: const Color(0xFF033D27),
        hintText: hint,
        hintStyle: const TextStyle(color: Colors.white70),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide.none,
        ),
        suffixIcon: isPassword
            ? IconButton(
                icon: Icon(
                  _obscurePassword ? Icons.visibility_off : Icons.visibility,
                  color: Colors.white70,
                ),
                onPressed: () {
                  setState(() {
                    _obscurePassword = !_obscurePassword;
                  });
                },
              )
            : null,
      ),
    );
  }

  Widget _buildButton(String text, VoidCallback onPressed) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFFFF9800),
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
        ),
        onPressed: onPressed,
        child: Text(text, style: const TextStyle(fontSize: 18)),
      ),
    );
  }

  void _showSnackBar(String message, bool success) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: success ? Colors.green : Colors.red,
        duration: const Duration(seconds: 2),
      ),
    );
  }
}
