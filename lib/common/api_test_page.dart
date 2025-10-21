import 'package:flutter/material.dart';
import '../services/api_service.dart';
import '../services/auth_service.dart';

class ApiTestPage extends StatefulWidget {
  const ApiTestPage({super.key});

  @override
  State<ApiTestPage> createState() => _ApiTestPageState();
}

class _ApiTestPageState extends State<ApiTestPage> {
  bool _isLoading = false;
  String _testResult = '';
  String _authStatus = '';

  @override
  void initState() {
    super.initState();
    _checkAuthStatus();
  }

  Future<void> _checkAuthStatus() async {
    final isLoggedIn = await AuthService.isLoggedIn();
    final user = await AuthService.getCurrentUser();

    setState(() {
      _authStatus = isLoggedIn
          ? 'Logged in as: ${user?.name ?? 'Unknown'} (${user?.role ?? 'No role'})'
          : 'Not logged in';
    });
  }

  Future<void> _testApiConnection() async {
    setState(() {
      _isLoading = true;
      _testResult = '';
    });

    try {
      final response = await ApiService.testConnection();

      setState(() {
        _testResult = response.success
            ? '✅ API Connection Successful!\n\nResponse: ${response.data}'
            : '❌ API Connection Failed!\n\nError: ${response.error}';
      });
    } catch (e) {
      setState(() {
        _testResult = '❌ Exception occurred: ${e.toString()}';
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> _testLogin() async {
    setState(() {
      _isLoading = true;
      _testResult = '';
    });

    try {
      // Test with dummy credentials - replace with actual test credentials
      final response = await AuthService.login('test@example.com', 'password');

      setState(() {
        _testResult = response.success
            ? '✅ Login Test Successful!\n\nUser: ${response.data}'
            : '❌ Login Test Failed!\n\nError: ${response.error}';
      });

      await _checkAuthStatus();
    } catch (e) {
      setState(() {
        _testResult = '❌ Login Exception: ${e.toString()}';
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> _logout() async {
    setState(() {
      _isLoading = true;
    });

    try {
      await AuthService.logout();
      setState(() {
        _testResult = '✅ Logout successful!';
        _authStatus = 'Not logged in';
      });
    } catch (e) {
      setState(() {
        _testResult = '❌ Logout failed: ${e.toString()}';
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('API Test Page'),
        backgroundColor: const Color(0xFF064F32),
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Authentication Status',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(_authStatus),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 16),

            ElevatedButton(
              onPressed: _isLoading ? null : _testApiConnection,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF064F32),
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 12),
              ),
              child: _isLoading
                  ? const CircularProgressIndicator(color: Colors.white)
                  : const Text('Test API Connection'),
            ),

            const SizedBox(height: 8),

            ElevatedButton(
              onPressed: _isLoading ? null : _testLogin,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFFF9800),
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 12),
              ),
              child: const Text('Test Login (with dummy credentials)'),
            ),

            const SizedBox(height: 8),

            ElevatedButton(
              onPressed: _isLoading ? null : _logout,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 12),
              ),
              child: const Text('Logout'),
            ),

            const SizedBox(height: 16),

            if (_testResult.isNotEmpty)
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Test Result',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        _testResult,
                        style: const TextStyle(fontFamily: 'monospace'),
                      ),
                    ],
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
