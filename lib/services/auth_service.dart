import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'api_service.dart';

class AuthService {
  static const String _tokenKey = 'auth_token';
  static const String _userKey = 'user_data';

  // Login user
  static Future<ApiResponse> login(String username, String password) async {
    final loginRequest = LoginRequest(username: username, password: password);
    final response = await ApiService.post(
      ApiConfig.loginEndpoint,
      loginRequest.toJson(),
    );

    if (response.success) {
      // Save token and user data
      await _saveAuthData(response.data);
    }

    return response;
  }

  // Logout user
  static Future<void> logout() async {
    try {
      // Call logout API
      await ApiService.post(ApiConfig.logoutEndpoint, {});
    } catch (e) {
      // Continue with logout even if API call fails
      print('Logout API call failed: $e');
    } finally {
      // Clear local storage
      await _clearAuthData();
    }
  }

  // Get current user
  static Future<User?> getCurrentUser() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final userJson = prefs.getString(_userKey);

      if (userJson != null) {
        final userData = jsonDecode(userJson);
        return User.fromJson(userData);
      }
      return null;
    } catch (e) {
      print('Error getting current user: $e');
      return null;
    }
  }

  // Check if user is logged in
  static Future<bool> isLoggedIn() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString(_tokenKey);
    return token != null && token.isNotEmpty;
  }

  // Get auth token
  static Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_tokenKey);
  }

  // Refresh user data from API
  static Future<User?> refreshUserData() async {
    try {
      final response = await ApiService.get(ApiConfig.userEndpoint);

      if (response.success) {
        final user = User.fromJson(response.data);
        await _saveUserData(user);
        return user;
      }
      return null;
    } catch (e) {
      print('Error refreshing user data: $e');
      return null;
    }
  }

  // Save authentication data
  static Future<void> _saveAuthData(Map<String, dynamic> data) async {
    final prefs = await SharedPreferences.getInstance();

    // Save token
    if (data['token'] != null) {
      await prefs.setString(_tokenKey, data['token']);
    }

    // Save user data
    if (data['user'] != null) {
      await prefs.setString(_userKey, jsonEncode(data['user']));
    }
  }

  // Save user data only
  static Future<void> _saveUserData(User user) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_userKey, jsonEncode(user.toJson()));
  }

  // Clear authentication data
  static Future<void> _clearAuthData() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_tokenKey);
    await prefs.remove(_userKey);
  }

  // Change password
  static Future<ApiResponse> changePassword(
    String currentPassword,
    String newPassword,
  ) async {
    final data = {
      'current_password': currentPassword,
      'new_password': newPassword,
      'new_password_confirmation': newPassword,
    };

    return await ApiService.put(ApiConfig.changePasswordEndpoint, data);
  }

  // Update profile
  static Future<ApiResponse> updateProfile(
    Map<String, dynamic> profileData,
  ) async {
    return await ApiService.put(ApiConfig.profileEndpoint, profileData);
  }

  // Forgot password
  static Future<ApiResponse> forgotPassword(
    String studentNumber,
    String email,
  ) async {
    final data = {'student_number': studentNumber, 'email': email};

    return await ApiService.post(ApiConfig.forgotPasswordEndpoint, data);
  }

  // Reset password
  static Future<ApiResponse> resetPassword(
    String token,
    String password,
  ) async {
    final data = {
      'token': token,
      'password': password,
      'password_confirmation': password,
    };

    return await ApiService.post(ApiConfig.resetPasswordEndpoint, data);
  }
}
