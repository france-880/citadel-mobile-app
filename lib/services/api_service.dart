import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart' show kIsWeb;

class ApiService {
  // 🌐 CONFIGURATION: Choose your testing mode
  // Change this constant to switch between different testing modes
  static const bool USE_REAL_DEVICE = false; // Set to true when testing on real phone
  
  // 📱 YOUR NETWORK IP ADDRESS
  // Current IP from ipconfig: 192.168.100.26
  // Update this if your IP changes (run 'ipconfig' to check)
  static const String NETWORK_IP = '192.168.100.26';

  // 🎯 AUTO-DETECT: Web browser vs Emulator vs Real Device
  static String get baseUrl {
    if (kIsWeb) {
      // 🌐 Running in Web Browser (Chrome, Edge, etc.)
      return 'http://127.0.0.1:8000/api';
    } else if (USE_REAL_DEVICE) {
      // 📱 Running on REAL PHONE via WiFi
      // Make sure to run: php artisan serve --host=0.0.0.0 --port=8000
      return 'http://$NETWORK_IP:8000/api';
    } else {
      // 🖥️ Running on Android Emulator
      // 10.0.2.2 is the special IP for emulator to access host machine's localhost
      return 'http://10.0.2.2:8000/api';
    }
  }
  static Future<http.Response> post(
    String endpoint,
    Map<String, dynamic> data, {
    String? token,
  }) async {
    try {
      final headers = {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      };

      if (token != null && token.isNotEmpty) {
        headers['Authorization'] = 'Bearer $token';
      }

      final response = await http.post(
        Uri.parse('$baseUrl/$endpoint'),
        headers: headers,
        body: jsonEncode(data),
      );
      return response;
    } catch (e) {
      throw Exception('Network error: $e');
    }
  }

  static Future<http.Response> get(String endpoint, String token) async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/$endpoint'),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );
      return response;
    } catch (e) {
      throw Exception('Network error: $e');
    }
  }

  static Future<http.Response> put(
    String endpoint,
    String token,
    Map<String, dynamic> data,
  ) async {
    try {
      final response = await http.put(
        Uri.parse('$baseUrl/$endpoint'),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode(data),
      );
      return response;
    } catch (e) {
      throw Exception('Network error: $e');
    }
  }
}