/// API Configuration for Citadel Mobile App
/// 
/// This file contains server URLs that the app will try to connect to.
/// Modify the server URLs below based on your network environment.
class ApiConfig {
  // List of server URLs to try in order
  // The app will automatically try each URL until one works
  static const List<String> serverUrls = [
    // Option 1: Your computer's IP address (most common)
    'http://192.168.100.26:8000/api',
    
    // Option 2: Alternative IP address (if your IP changes)
    'http://192.168.1.100:8000/api',
    
    // Option 3: For Android emulator (if testing on emulator)
    'http://10.0.2.2:8000/api',
    
    // Option 4: Local development (if running on same machine)
    'http://localhost:8000/api',
    
    // Option 5: Add your own server URLs here
    // 'http://YOUR_IP_ADDRESS:8000/api',
  ];
  
  // Connection timeout settings (in seconds)
  static const int connectTimeout = 15;
  static const int receiveTimeout = 15;
  static const int testTimeout = 5;
  
  // How to find your computer's IP address:
  // Windows: Open Command Prompt and type "ipconfig"
  // Look for "IPv4 Address" under your WiFi adapter
  // 
  // Mac: Open Terminal and type "ifconfig | grep inet"
  // Look for the IP address starting with 192.168.x.x
  //
  // Linux: Open Terminal and type "ip addr show" or "ifconfig"
  // Look for the IP address starting with 192.168.x.x
}
