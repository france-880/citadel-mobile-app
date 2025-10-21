# API Integration Guide

This guide explains how the Flutter mobile app connects to the Laravel backend API.

## 📁 File Structure

```
lib/
├── config/
│   └── api_config.dart          # API configuration and endpoints
├── services/
│   ├── api.dart                 # Main API service class
│   └── auth_service.dart        # Authentication service
├── common/
│   ├── login_page.dart          # Updated login page with API integration
│   └── api_test_page.dart       # API testing page
└── main.dart                    # Updated with API test route
```

## 🔧 Configuration

### 1. API Base URL Configuration

Edit `lib/config/api_config.dart` to set your backend URL:

```dart
class ApiConfig {
  // For local development
  static const String baseUrl = 'http://192.168.1.2:8000/api';
  
  // For Android emulator
  // static const String baseUrl = 'http://10.0.2.2:8000/api';
  
  // For physical device (replace with your computer's IP)
  // static const String baseUrl = 'http://192.168.1.100:8000/api';
  
  // For production
  // static const String baseUrl = 'https://your-domain.com/api';
}
```

### 2. Dependencies

The following packages are required (already added to `pubspec.yaml`):

```yaml
dependencies:
  http: ^1.2.2                    # HTTP requests
  shared_preferences: ^2.2.2      # Local storage for tokens
```

## 🚀 Features

### ✅ Implemented Features

1. **API Service Class** (`lib/services/api.dart`)
   - Generic HTTP methods (GET, POST, PUT, DELETE)
   - Automatic token handling
   - Error handling and response parsing
   - Connection testing

2. **Authentication Service** (`lib/services/auth_service.dart`)
   - User login/logout
   - Token management
   - User data persistence
   - Password reset functionality
   - Profile management

3. **Data Models**
   - `User` model for user data
   - `LoginRequest` and `LoginResponse` models
   - `ApiResponse` wrapper for API responses

4. **Updated Login Page**
   - Real API integration
   - Loading states
   - Error handling
   - Role-based navigation
   - Forgot password functionality

5. **API Test Page**
   - Connection testing
   - Authentication testing
   - Debug information

## 🔌 API Endpoints Used

The app connects to these Laravel API endpoints:

- `POST /api/login` - User authentication
- `POST /api/logout` - User logout
- `GET /api/me` - Get current user data
- `PUT /api/profile` - Update user profile
- `PUT /api/change-password` - Change password
- `POST /api/forgot-password` - Request password reset
- `POST /api/reset-password` - Reset password
- `GET /api/test` - Test API connection

## 🧪 Testing the Integration

### 1. Start Your Laravel Backend

Make sure your Laravel backend is running:

```bash
cd web-app/citadel-backend/citadel-backend
php artisan serve
```

### 2. Test API Connection

1. Run the Flutter app
2. Navigate to `/api_test` route
3. Tap "Test API Connection" button
4. Check the result

### 3. Test Authentication

1. In the API test page, tap "Test Login"
2. Or use the main login page with real credentials

## 🔐 Authentication Flow

1. **Login Process:**
   ```dart
   final response = await AuthService.login(username, password);
   if (response.success) {
     // Token and user data are automatically saved
     // Navigate to appropriate dashboard based on user role
   }
   ```

2. **Token Management:**
   - Tokens are automatically included in API requests
   - Stored securely using SharedPreferences
   - Automatically cleared on logout

3. **User Data:**
   - User information is cached locally
   - Can be refreshed from API when needed

## 🎯 Usage Examples

### Making API Calls

```dart
// GET request
final response = await ApiService.get('/users');

// POST request
final response = await ApiService.post('/users', {
  'name': 'John Doe',
  'email': 'john@example.com'
});

// PUT request
final response = await ApiService.put('/users/1', {
  'name': 'Updated Name'
});

// DELETE request
final response = await ApiService.delete('/users/1');
```

### Authentication

```dart
// Login
final response = await AuthService.login('username', 'password');

// Check if logged in
final isLoggedIn = await AuthService.isLoggedIn();

// Get current user
final user = await AuthService.getCurrentUser();

// Logout
await AuthService.logout();
```

## 🛠️ Troubleshooting

### Common Issues

1. **Connection Refused**
   - Check if Laravel backend is running
   - Verify the API base URL in `api_config.dart`
   - For Android emulator, use `10.0.2.2` instead of `localhost`

2. **CORS Issues**
   - Make sure your Laravel backend has CORS configured
   - Check `config/cors.php` in your Laravel project

3. **Authentication Errors**
   - Verify the login endpoint returns the expected format
   - Check if the token is being saved correctly

4. **Network Errors**
   - Check your internet connection
   - Verify the backend URL is accessible

### Debug Steps

1. Use the API Test Page to verify connection
2. Check the console for error messages
3. Verify the Laravel API responses match the expected format
4. Test with Postman or similar tools first

## 📱 Next Steps

1. **Add More API Endpoints:**
   - Extend `ApiService` with specific methods for your endpoints
   - Create additional service classes for different features

2. **Improve Error Handling:**
   - Add retry logic for failed requests
   - Implement offline support

3. **Add Loading States:**
   - Use the existing loading pattern in other screens
   - Add skeleton loaders for better UX

4. **Security Enhancements:**
   - Add certificate pinning for production
   - Implement token refresh logic

## 🔗 Related Files

- `web-app/citadel-backend/citadel-backend/routes/api.php` - Laravel API routes
- `web-app/citadel-backend/citadel-backend/app/Http/Controllers/API/AuthController.php` - Auth controller
- `mobile-app/citadel-mobile-app/lib/services/` - All API-related services

## 📞 Support

If you encounter any issues with the API integration, check:

1. Laravel backend logs
2. Flutter console output
3. Network connectivity
4. API endpoint responses

The API test page (`/api_test`) is your best friend for debugging connection issues!
