import 'package:flutter/material.dart';
import 'facial_recognition_capture.dart';

class FacialRecognitionInstructions extends StatelessWidget {
  const FacialRecognitionInstructions({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),

              // Title
              const Text(
                "Let's verify your identity with a selfie",
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Poppins',
                  color: Color(0xFF064F32),
                  height: 1.2,
                ),
              ),

              const SizedBox(height: 32),

              // Instructions List
              _buildInstructionItem(
                icon: Icons.wb_sunny_outlined,
                title: 'Find good lighting',
                description: 'Make sure your face is well-lit and clearly visible',
              ),

              const SizedBox(height: 24),

              _buildInstructionItem(
                icon: Icons.face_outlined,
                title: 'Do not cover your face',
                description: 'Remove sunglasses, masks, or anything covering your face',
              ),

              const SizedBox(height: 24),

              _buildInstructionItem(
                icon: Icons.center_focus_strong_outlined,
                title: 'Position your face',
                description: 'Keep your face centered within the frame',
              ),

              const SizedBox(height: 24),

              _buildInstructionItem(
                icon: Icons.mood_outlined,
                title: 'Look straight ahead',
                description: 'Face the camera directly and stay still',
              ),

              const Spacer(),

              // Preview Image/Icon
              Center(
                child: Container(
                  width: 150,
                  height: 150,
                  decoration: BoxDecoration(
                    color: const Color(0xFF064F32).withOpacity(0.1),
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: const Color(0xFF064F32),
                      width: 3,
                    ),
                  ),
                  child: const Icon(
                    Icons.face,
                    size: 80,
                    color: Color(0xFF064F32),
                  ),
                ),
              ),

              const Spacer(),

              // Continue Button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const FacialRecognitionCapture(),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF064F32),
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    elevation: 0,
                  ),
                  child: const Text(
                    'Continue',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInstructionItem({
    required IconData icon,
    required String title,
    required String description,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 48,
          height: 48,
          decoration: BoxDecoration(
            color: const Color(0xFF064F32).withOpacity(0.1),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(
            icon,
            color: const Color(0xFF064F32),
            size: 28,
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                description,
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey[600],
                  height: 1.4,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

