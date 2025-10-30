import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:camera/camera.dart';
import 'package:screen_brightness/screen_brightness.dart';
import 'facial_recognition_success.dart';

class FacialRecognitionCapture extends StatefulWidget {
  const FacialRecognitionCapture({super.key});

  @override
  State<FacialRecognitionCapture> createState() =>
      _FacialRecognitionCaptureState();
}

class _FacialRecognitionCaptureState extends State<FacialRecognitionCapture> {
  CameraController? _cameraController;
  bool _isCameraInitialized = false;
  bool _isInitializing = false;
  bool _isProcessing = false;
  List<CameraDescription>? _cameras;
  double _originalBrightness = 0.5;
  final ScreenBrightness _screenBrightness = ScreenBrightness();

  @override
  void initState() {
    super.initState();
    _initializeCamera();
    _setMaxBrightness();
    _startFaceDetection();
  }

  @override
  void dispose() {
    _cameraController?.dispose();
    _restoreBrightness();
    super.dispose();
  }

  Future<void> _setMaxBrightness() async {
    try {
      // Save original brightness
      _originalBrightness = await _screenBrightness.current;

      // Set to maximum brightness for better face detection
      await _screenBrightness.setScreenBrightness(1.0);
      debugPrint('Screen brightness set to maximum');
    } catch (e) {
      debugPrint('Error setting brightness: $e');
    }
  }

  Future<void> _restoreBrightness() async {
    try {
      // Restore original brightness
      await _screenBrightness.setScreenBrightness(_originalBrightness);
      debugPrint('Screen brightness restored');
    } catch (e) {
      debugPrint('Error restoring brightness: $e');
    }
  }

  Future<void> _initializeCamera() async {
    if (_isInitializing) return;

    setState(() {
      _isInitializing = true;
    });

    try {
      // Get available cameras
      _cameras = await availableCameras();

      if (_cameras == null || _cameras!.isEmpty) {
        throw Exception('No cameras found');
      }

      // Find front camera
      CameraDescription? frontCamera;
      for (var camera in _cameras!) {
        if (camera.lensDirection == CameraLensDirection.front) {
          frontCamera = camera;
          break;
        }
      }

      if (frontCamera == null) {
        throw Exception('Front camera not found');
      }

      // Dispose existing controller if any
      await _cameraController?.dispose();

      // Initialize camera controller
      _cameraController = CameraController(
        frontCamera,
        ResolutionPreset.high,
        enableAudio: false,
        imageFormatGroup: ImageFormatGroup.jpeg,
      );

      // Initialize the camera
      await _cameraController!.initialize();

      if (mounted) {
        setState(() {
          _isCameraInitialized = true;
          _isInitializing = false;
        });
      }
    } catch (e) {
      debugPrint('Error initializing camera: $e');
      if (mounted) {
        setState(() {
          _isInitializing = false;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Camera initialization failed: $e"),
            backgroundColor: Colors.red,
            duration: const Duration(seconds: 3),
            action: SnackBarAction(
              label: 'Retry',
              textColor: Colors.white,
              onPressed: () => _initializeCamera(),
            ),
          ),
        );
      }
    }
  }

  void _startFaceDetection() {
    // Simulate automatic face detection after 4 seconds
    Future.delayed(const Duration(seconds: 4), () {
      if (mounted && !_isProcessing) {
        _performFacialVerification();
      }
    });
  }

  Future<void> _performFacialVerification() async {
    if (_isProcessing) return;

    setState(() {
      _isProcessing = true;
    });

    // Add haptic feedback
    HapticFeedback.mediumImpact();

    // Simulate face verification process
    await Future.delayed(const Duration(seconds: 2));

    if (!mounted) return;

    // Restore brightness before navigating
    await _restoreBrightness();

    // Navigate to success screen
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => const FacialRecognitionSuccess(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Stack(
          children: [
            // Camera Preview
            if (_isCameraInitialized && _cameraController != null)
              SizedBox.expand(
                child: CameraPreview(_cameraController!),
              )
            else
              Container(
                color: Colors.black,
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      if (_isInitializing)
                        const CircularProgressIndicator(
                          color: Colors.white,
                          strokeWidth: 3,
                        )
                      else
                        const Icon(
                          Icons.camera_alt,
                          size: 80,
                          color: Colors.white54,
                        ),
                      const SizedBox(height: 16),
                      Text(
                        _isInitializing
                            ? "Initializing Camera..."
                            : "Camera not available",
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      if (!_isInitializing && !_isCameraInitialized)
                        Padding(
                          padding: const EdgeInsets.only(top: 16),
                          child: ElevatedButton(
                            onPressed: _initializeCamera,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF064F32),
                              foregroundColor: Colors.white,
                            ),
                            child: const Text('Retry'),
                          ),
                        ),
                    ],
                  ),
                ),
              ),

            // Overlay with face guide
            Positioned.fill(
              child: CustomPaint(
                painter: FaceGuidePainter(isProcessing: _isProcessing),
              ),
            ),

            // Top Bar
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.black.withOpacity(0.7),
                      Colors.transparent,
                    ],
                  ),
                ),
                child: Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.close, color: Colors.white),
                      onPressed: () => Navigator.pop(context),
                    ),
                    const Spacer(),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: const Row(
                        children: [
                          Icon(
                            Icons.brightness_high,
                            color: Colors.white,
                            size: 16,
                          ),
                          SizedBox(width: 4),
                          Text(
                            'Auto Brightness',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Bottom Instructions
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                    colors: [
                      Colors.black.withOpacity(0.8),
                      Colors.transparent,
                    ],
                  ),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (_isProcessing)
                      Column(
                        children: [
                          const CircularProgressIndicator(
                            color: Color(0xFF064F32),
                            strokeWidth: 3,
                          ),
                          const SizedBox(height: 16),
                          const Text(
                            'Verifying...',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      )
                    else
                      Column(
                        children: [
                          const Icon(
                            Icons.face_outlined,
                            color: Colors.white,
                            size: 40,
                          ),
                          const SizedBox(height: 12),
                          const Text(
                            'Position your face within the frame',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'Verification will happen automatically',
                            style: TextStyle(
                              color: Colors.white.withOpacity(0.8),
                              fontSize: 14,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ],
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

// Custom painter for face guide overlay
class FaceGuidePainter extends CustomPainter {
  final bool isProcessing;

  FaceGuidePainter({required this.isProcessing});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = isProcessing
          ? const Color(0xFF064F32).withOpacity(0.8)
          : Colors.white.withOpacity(0.8)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 4;

    final center = Offset(size.width / 2, size.height / 2 - 50);
    final radius = size.width * 0.35;

    // Draw oval for face guide
    final rect = Rect.fromCenter(
      center: center,
      width: radius * 2,
      height: radius * 2.3,
    );

    canvas.drawOval(rect, paint);

    // Draw corner guides
    final cornerPaint = Paint()
      ..color = isProcessing
          ? const Color(0xFF064F32)
          : Colors.white
      ..style = PaintingStyle.stroke
      ..strokeWidth = 6
      ..strokeCap = StrokeCap.round;

    final cornerLength = 30.0;

    // Top-left corner
    canvas.drawLine(
      Offset(rect.left, rect.top + cornerLength),
      Offset(rect.left, rect.top),
      cornerPaint,
    );
    canvas.drawLine(
      Offset(rect.left, rect.top),
      Offset(rect.left + cornerLength, rect.top),
      cornerPaint,
    );

    // Top-right corner
    canvas.drawLine(
      Offset(rect.right - cornerLength, rect.top),
      Offset(rect.right, rect.top),
      cornerPaint,
    );
    canvas.drawLine(
      Offset(rect.right, rect.top),
      Offset(rect.right, rect.top + cornerLength),
      cornerPaint,
    );

    // Bottom-left corner
    canvas.drawLine(
      Offset(rect.left, rect.bottom - cornerLength),
      Offset(rect.left, rect.bottom),
      cornerPaint,
    );
    canvas.drawLine(
      Offset(rect.left, rect.bottom),
      Offset(rect.left + cornerLength, rect.bottom),
      cornerPaint,
    );

    // Bottom-right corner
    canvas.drawLine(
      Offset(rect.right - cornerLength, rect.bottom),
      Offset(rect.right, rect.bottom),
      cornerPaint,
    );
    canvas.drawLine(
      Offset(rect.right, rect.bottom - cornerLength),
      Offset(rect.right, rect.bottom),
      cornerPaint,
    );

    // Darken outside the oval
    final outerPaint = Paint()
      ..color = Colors.black.withOpacity(0.6)
      ..style = PaintingStyle.fill;

    final path = Path()
      ..addRect(Rect.fromLTWH(0, 0, size.width, size.height))
      ..addOval(rect)
      ..fillType = PathFillType.evenOdd;

    canvas.drawPath(path, outerPaint);
  }

  @override
  bool shouldRepaint(FaceGuidePainter oldDelegate) {
    return oldDelegate.isProcessing != isProcessing;
  }
}

