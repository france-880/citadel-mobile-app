import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:permission_handler/permission_handler.dart';
import 'facial_recognition_instructions.dart';
import 'student_dashboard_screen.dart';

class CameraPermissionScreen extends StatefulWidget {
  const CameraPermissionScreen({super.key});

  @override
  State<CameraPermissionScreen> createState() => _CameraPermissionScreenState();
}

class _CameraPermissionScreenState extends State<CameraPermissionScreen> {
  bool _isRequesting = false;

  @override
  void initState() {
    super.initState();
    // 🌐 AUTO-SKIP for Web/Browser Testing
    // When running in browser, automatically go to dashboard since camera doesn't work well on web
    if (kIsWeb) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _skipFacialRecognition();
      });
    }
  }

  Future<void> _requestCameraPermission() async {
    // 🌐 DISABLED FOR WEB - Uncomment for mobile testing
    /* 
    setState(() {
      _isRequesting = true;
    });

    try {
      final status = await Permission.camera.request();

      if (!mounted) return;

      if (status.isGranted) {
        // Permission granted, navigate to instructions
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const FacialRecognitionInstructions(),
          ),
        );
      } else if (status.isDenied) {
        // Permission denied
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Camera permission is required for facial recognition'),
            backgroundColor: Colors.orange,
            duration: Duration(seconds: 3),
          ),
        );
      } else if (status.isPermanentlyDenied) {
        // Permission permanently denied, show dialog to open settings
        _showPermissionDeniedDialog();
      }
    } catch (e) {
      debugPrint('Error requesting camera permission: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error: $e'),
          backgroundColor: Colors.red,
        ),
      );
    } finally {
      if (mounted) {
        setState(() {
          _isRequesting = false;
        });
      }
    }
    */
    
    // 🌐 FOR WEB: Just skip to dashboard
    _skipFacialRecognition();
  }

  void _showPermissionDeniedDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Camera Permission Required'),
        content: const Text(
          'Camera access is permanently denied. Please enable it in your device settings to use facial recognition.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              openAppSettings();
              Navigator.pop(context);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF064F32),
            ),
            child: const Text('Open Settings'),
          ),
        ],
      ),
    );
  }

  void _skipFacialRecognition() {
    // Skip facial recognition and go to dashboard
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => const StudentDashboardScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Camera Icon
              Container(
                width: 120,
                height: 120,
                decoration: BoxDecoration(
                  color: const Color(0xFF064F32).withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.camera_alt_rounded,
                  size: 60,
                  color: Color(0xFF064F32),
                ),
              ),

              const SizedBox(height: 40),

              // Title
              const Text(
                'Camera Access',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Poppins',
                  color: Color(0xFF064F32),
                ),
                textAlign: TextAlign.center,
              ),

              const SizedBox(height: 16),

              // Description
              const Text(
                'We need access to your camera for facial recognition verification. This helps us confirm your identity securely.',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.black87,
                  height: 1.5,
                ),
                textAlign: TextAlign.center,
              ),

              const SizedBox(height: 48),

              // Allow Button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _isRequesting ? null : _requestCameraPermission,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF064F32),
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    elevation: 0,
                  ),
                  child: _isRequesting
                      ? const SizedBox(
                          height: 20,
                          width: 20,
                          child: CircularProgressIndicator(
                            color: Colors.white,
                            strokeWidth: 2,
                          ),
                        )
                      : const Text(
                          'Allow Camera Access',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                ),
              ),

              const SizedBox(height: 16),

              // Skip Button
              SizedBox(
                width: double.infinity,
                child: OutlinedButton(
                  onPressed: _skipFacialRecognition,
                  style: OutlinedButton.styleFrom(
                    foregroundColor: const Color(0xFF064F32),
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    side: const BorderSide(
                      color: Color(0xFF064F32),
                      width: 2,
                    ),
                  ),
                  child: const Text(
                    'Skip for Now',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 24),

              // Privacy Note
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.lock_outline,
                    size: 16,
                    color: Colors.grey[600],
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      'Your privacy is important. Images are only used for verification.',
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey[600],
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

