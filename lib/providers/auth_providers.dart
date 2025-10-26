// lib/providers/auth_provider.dart
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../services/auth_services.dart';
import '../models/user_models.dart';

class AuthProvider with ChangeNotifier {
  String? _token;
  UserModel? _user;
  bool _isLoading = false;

  String? get token => _token;
  UserModel? get user => _user;
  bool get isLoading => _isLoading;
  bool get isAuthenticated => _token != null && _user != null;

  // 🔁 Initialize (load from local storage if needed)
  Future<void> initialize() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('token');
      final userJson = prefs.getString('user');

      if (token != null && userJson != null) {
        _token = token;
        try {
          final Map<String, dynamic> data = jsonDecode(userJson);
          _user = UserModel.fromJson(data);
        } catch (_) {
          _user = null;
        }
      }
      notifyListeners();
    } catch (e) {
      // ignore storage errors for now
    }
  }

  // 🔐 Login (Student / Professor)
  Future<bool> login(String username, String password) async {
    _isLoading = true;
    notifyListeners();

    try {
      final result = await AuthService.login(
        username: username,
        password: password,
      );

      if (result['success'] == true) {
        _token = result['token'];
        _user = UserModel.fromJson(result['user']);

        // Optionally save to secure storage
        await _saveToStorage();

        _isLoading = false;
        notifyListeners();
        return true;
      } else {
        _isLoading = false;
        notifyListeners();
        return false;
      }
    } catch (e) {
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }

  // 🚪 Logout
  Future<bool> logout() async {
    if (_token != null) {
      await AuthService.logout(_token!);
    }

    _token = null;
    _user = null;

    await _clearStorage();
    notifyListeners();
    return true;
  }

  // 🔑 Change Password
  Future<bool> changePassword(
    String currentPassword,
    String newPassword,
  ) async {
    if (_token == null) return false;

    try {
      final result = await AuthService.changePassword(
        token: _token!,
        currentPassword: currentPassword,
        newPassword: newPassword,
      );

      return result['success'] == true;
    } catch (e) {
      return false;
    }
  }

  // 💾 Local storage helpers
  Future<void> _saveToStorage() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      if (_token != null) await prefs.setString('token', _token!);
      if (_user != null) {
        await prefs.setString('user', jsonEncode(_user!.toJson()));
      }
    } catch (e) {
      // ignore storage errors
    }
  }

  Future<void> _clearStorage() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove('token');
      await prefs.remove('user');
    } catch (e) {
      // ignore
    }
  }
}
