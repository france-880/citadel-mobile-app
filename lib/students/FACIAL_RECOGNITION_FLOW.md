# Facial Recognition Flow for First-Time Student Login

## Overview
This facial recognition system is designed for first-time student login after their account is created from the web app. The flow ensures secure identity verification through a multi-step process.

## Flow Steps

### 1. Camera Permission Screen (`camera_permission_screen.dart`)
**Purpose:** Request camera access from the user

**Features:**
- Clean UI with camera icon
- "Allow Camera Access" button
- "Skip for Now" option
- Privacy note to reassure users
- Handles permission states:
  - Granted → Navigate to instructions
  - Denied → Show warning
  - Permanently Denied → Open app settings dialog

**Usage:**
```dart
Navigator.push(
  context,
  MaterialPageRoute(
    builder: (context) => const CameraPermissionScreen(),
  ),
);
```

---

### 2. Facial Recognition Instructions (`facial_recognition_instructions.dart`)
**Purpose:** Guide users on how to take a good selfie for verification

**Instructions Shown:**
- ☀️ Find good lighting
- 😊 Do not cover your face
- 🎯 Position your face
- 👀 Look straight ahead

**Features:**
- Visual guide with icons
- Clear, concise instructions
- Preview icon showing expected face position
- Continue button to proceed

---

### 3. Facial Recognition Capture (`facial_recognition_capture.dart`)
**Purpose:** Capture and verify facial biometrics

**Key Features:**

#### Auto Brightness
- Automatically sets screen brightness to maximum (100%) when entering
- Restores original brightness when leaving or after verification
- Shows "Auto Brightness" indicator in top-right

#### Camera Features
- Uses front-facing camera
- High resolution preset for better accuracy
- Real-time camera preview
- Custom face guide overlay with oval frame
- Corner guides for precise positioning

#### Visual Feedback
- Darkened overlay outside face guide
- Color changes during processing:
  - White overlay → Waiting for position
  - Green overlay → Processing verification
- Instructions at bottom:
  - "Position your face within the frame"
  - "Verification will happen automatically"

#### Auto Detection
- Automatically detects face after 4 seconds
- No manual capture button needed
- Shows "Verifying..." during processing

#### Error Handling
- Retry button if camera fails to initialize
- User-friendly error messages
- Loading indicators

---

### 4. Facial Recognition Success (`facial_recognition_success.dart`)
**Purpose:** Confirm successful verification and welcome user

**Features:**

#### Success Animation
- Elastic bounce animation for check icon
- Fade-in animations for text
- Haptic feedback (vibration) for tactile confirmation

#### Information Display
- "Facial Verified" title
- Success message
- Feature highlights:
  - 📱 Quick attendance with QR
  - 📅 View your class schedule
  - 📊 Track your attendance logs

#### Navigation
- "Continue to Dashboard" button
- Removes all previous routes (clean navigation stack)
- Navigates to `StudentDashboardScreen`

---

## Integration Guide

### Step 1: Import the First Screen
```dart
import 'package:citadel/students/camera_permission_screen.dart';
```

### Step 2: Trigger on First Login
After student login, check if facial recognition is completed:

```dart
if (isFirstTimeLogin && !hasFacialRecognition) {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => const CameraPermissionScreen(),
    ),
  );
}
```

### Step 3: Track Completion
After successful verification, save to backend/local storage:

```dart
// In facial_recognition_success.dart, before navigating to dashboard
await _saveFacialRecognitionStatus();
```

---

## Dependencies Required

Add these to `pubspec.yaml`:

```yaml
dependencies:
  camera: ^0.11.0+6
  permission_handler: ^11.0.1
  screen_brightness: ^1.0.1
```

---

## Platform Permissions

### Android (AndroidManifest.xml)
```xml
<uses-permission android:name="android.permission.CAMERA" />
<uses-feature android:name="android.hardware.camera" android:required="true" />
```

### iOS (Info.plist)
```xml
<key>NSCameraUsageDescription</key>
<string>This app needs access to camera for facial verification</string>
```

---

## Technical Details

### Auto Brightness Implementation
```dart
final ScreenBrightness _screenBrightness = ScreenBrightness();

// Save original brightness
_originalBrightness = await _screenBrightness.current;

// Set maximum brightness
await _screenBrightness.setScreenBrightness(1.0);

// Restore when done
await _screenBrightness.setScreenBrightness(_originalBrightness);
```

### Camera Initialization
```dart
_cameraController = CameraController(
  frontCamera,
  ResolutionPreset.high,
  enableAudio: false,
  imageFormatGroup: ImageFormatGroup.jpeg,
);
```

### Custom Face Guide Overlay
- Uses `CustomPainter` to draw oval with corner guides
- Changes color based on processing state
- Creates darkened overlay outside face area
- Responsive to screen size

---

## User Experience Flow

```
Student Login (First Time)
    ↓
Camera Permission Screen
    ↓ (Allow)
Instructions Screen
    ↓ (Continue)
Facial Capture Screen
    ↓ (Auto-detect & verify)
Success Screen
    ↓ (Continue)
Student Dashboard
```

---

## Error Scenarios

1. **Camera Permission Denied**
   - Show warning message
   - Allow retry

2. **Camera Permission Permanently Denied**
   - Show dialog
   - Provide button to open app settings

3. **Camera Initialization Failed**
   - Show error message
   - Provide retry button

4. **User Skips Process**
   - Navigate back to previous screen
   - Can be triggered again later

---

## Future Enhancements

- [ ] Actual facial recognition ML model integration
- [ ] Liveness detection (blink detection)
- [ ] Multi-angle capture for better accuracy
- [ ] Backend API integration for storing facial data
- [ ] Retry mechanism if verification fails
- [ ] Progress indicator for each step

---

## Notes

- Current implementation simulates verification (4-second delay)
- Replace simulation with actual facial recognition API call
- Consider GDPR/privacy compliance for facial data storage
- Implement secure transmission (HTTPS) for facial data
- Add ability to retake photo if user is not satisfied

