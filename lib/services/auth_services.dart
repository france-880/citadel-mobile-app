import 'dart:convert';
import 'package:citadel/services/api_services.dart';

class AuthService {
  // Login
  static Future<Map<String, dynamic>> login({
    required String username,
    required String password,
  }) async {
    try {
      // send both 'username' and 'email' to accommodate backends expecting
      // either field (the UI accepts email or username in one input)
      final response = await ApiService.post('login', {
        'username': username,
        'email': username,
        'password': password,
      });

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return {
          'success': true,
          'token': data['token'],
          'user': data['user'], // includes role + origin
        };
      } else {
        final error = jsonDecode(response.body);
        return {
          'success': false,
          'message': error['message'] ?? 'Login failed',
        };
      }
    } catch (e) {
      return {'success': false, 'message': 'Connection error: $e'};
    }
  }

  // 🚪 Logout
  static Future<Map<String, dynamic>> logout(String token) async {
    try {
      final response = await ApiService.post('logout', {}, token: token);

      if (response.statusCode == 200) {
        return {'success': true, 'message': 'Logged out successfully'};
      } else {
        return {'success': false, 'message': 'Logout failed'};
      }
    } catch (e) {
      return {'success': false, 'message': 'Connection error: $e'};
    }
  }

  // 🔑 Change Password
  static Future<Map<String, dynamic>> changePassword({
    required String token,
    required String currentPassword,
    required String newPassword,
  }) async {
    try {
      final response = await ApiService.put('change-password', token, {
        'current_password': currentPassword,
        'password': newPassword,
        'password_confirmation': newPassword,
      });

      if (response.statusCode == 200) {
        final result = jsonDecode(response.body);
        return {'success': true, 'message': result['message']};
      } else {
        final error = jsonDecode(response.body);
        return {
          'success': false,
          'message': error['message'] ?? 'Password change failed',
        };
      }
    } catch (e) {
      return {'success': false, 'message': 'Connection error: $e'};
    }
  }
}
