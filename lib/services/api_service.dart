import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../config/api_config.dart';

class ApiService {
  // Get server URLs from configuration
  static List<String> get _serverUrls => ApiConfig.serverUrls;
  
  late Dio _dio;
  String _currentBaseUrl = _serverUrls[0];
  
  ApiService() {
    _dio = Dio(BaseOptions(
      baseUrl: _currentBaseUrl,
      headers: {'Accept': 'application/json'},
      connectTimeout: Duration(seconds: ApiConfig.connectTimeout),
      receiveTimeout: Duration(seconds: ApiConfig.receiveTimeout),
    ));
  }

  // Test server connection with automatic fallback
  Future<bool> testConnection() async {
    print('🔍 Testing server connections...');
    
    for (int i = 0; i < _serverUrls.length; i++) {
      final url = _serverUrls[i];
      print('🔄 Trying server ${i + 1}/${_serverUrls.length}: $url');
      
      try {
        // Create temporary Dio instance for testing
        final testDio = Dio(BaseOptions(
          baseUrl: url,
          headers: {'Accept': 'application/json'},
          connectTimeout: Duration(seconds: ApiConfig.testTimeout),
          receiveTimeout: Duration(seconds: ApiConfig.testTimeout),
        ));
        
        final response = await testDio.get('/');
        
        // If successful, update the main Dio instance
        _currentBaseUrl = url;
        _dio.options.baseUrl = url;
        
        print('✅ Server is reachable: $url');
        return true;
      } catch (e) {
        print('❌ Failed to connect to $url: $e');
        continue;
      }
    }
    
    print('❌ All servers are unreachable');
    return false;
  }

  // Get current working server URL
  String get currentServerUrl => _currentBaseUrl;
  
  // Get list of all available server URLs for debugging
  List<String> get availableServers => _serverUrls;

  Future<Map<String, dynamic>> login(String email, String password) async {
    try {
      print('🔐 Attempting login with: $email');
      print('🌐 API URL: ${_dio.options.baseUrl}/login');
      
      final response = await _dio.post('/login', data: {
        'email': email, // This field accepts both email and username from web app
        'password': password,
      });

      print('✅ Login successful! Response: ${response.data}');

      // Save token and user data
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('token', response.data['token']);
      await prefs.setString('user', response.data['user'].toString());

      return response.data;
    } on DioException catch (e) {
      print('❌ Login failed with DioException:');
      print('   Error: ${e.message}');
      print('   Status Code: ${e.response?.statusCode}');
      print('   Response Data: ${e.response?.data}');
      
      if (e.type == DioExceptionType.connectionTimeout || 
          e.type == DioExceptionType.receiveTimeout ||
          e.type == DioExceptionType.sendTimeout) {
        throw 'Connection timeout. Please check your internet connection and server status.';
      }
      
      if (e.type == DioExceptionType.connectionError) {
        throw 'Cannot connect to server. Please check if the server is running at ${_dio.options.baseUrl}';
      }
      
      if (e.response?.statusCode == 401) {
        throw 'Invalid username or password';
      }
      
      if (e.response?.statusCode == 422) {
        throw 'Validation error: ${e.response?.data['message'] ?? 'Invalid input'}';
      }
      
      throw e.response?.data['message'] ?? 'Login failed: ${e.message}';
    } catch (e) {
      print('❌ Unexpected error during login: $e');
      throw 'Unexpected error: $e';
    }
  }


  Future<void> logout() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('token');
      
      if (token != null) {
        // Call logout endpoint to revoke token on server
        await _dio.post('/logout', 
          options: Options(headers: {'Authorization': 'Bearer $token'}));
      }
      
      // Clear local storage
      await prefs.remove('token');
      await prefs.remove('user');
    } catch (e) {
      // Even if server logout fails, clear local storage
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove('token');
      await prefs.remove('user');
    }
  }


  Future<Map<String, dynamic>> getProfile() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');

    _dio.options.headers['Authorization'] = 'Bearer $token';

    final response = await _dio.get('/user'); // depende sa route mo
    return response.data;
  }

  Future<Map<String, dynamic>> getUser() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('token');
      if (token == null) throw 'No token found';

      final response = await _dio.get(
        '/user',
        options: Options(headers: {'Authorization': 'Bearer $token'}),
      );
      
      // Update stored user data
      await prefs.setString('user', response.data.toString());
      return response.data;
    } on DioException catch (e) {
      if (e.response?.statusCode == 401) {
        // Token expired, clear local storage
        final prefs = await SharedPreferences.getInstance();
        await prefs.remove('token');
        await prefs.remove('user');
        throw 'Session expired. Please login again.';
      }
      throw e.response?.data['message'] ?? 'Failed to fetch user';
    }
  }


}
