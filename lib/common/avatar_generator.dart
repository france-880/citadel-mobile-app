import 'package:flutter/material.dart';

/// Generates a colorful avatar with user initials (like Google, Microsoft, SHAREit)
class AvatarGenerator {
  // Predefined colors for avatars
  static final List<Color> avatarColors = [
    const Color(0xFF6366F1), // Indigo
    const Color(0xFFEC4899), // Pink
    const Color(0xFF8B5CF6), // Purple
    const Color(0xFF06B6D4), // Cyan
    const Color(0xFF10B981), // Green
    const Color(0xFFF59E0B), // Amber
    const Color(0xFFEF4444), // Red
    const Color(0xFF3B82F6), // Blue
    const Color(0xFF14B8A6), // Teal
    const Color(0xFFF97316), // Orange
  ];

  /// Get initials from full name (max 2 letters)
  static String getInitials(String? fullName) {
    if (fullName == null || fullName.trim().isEmpty) {
      return '?';
    }

    final parts = fullName.trim().split(' ');
    if (parts.length == 1) {
      // Single name: take first 2 letters
      return parts[0].substring(0, parts[0].length >= 2 ? 2 : 1).toUpperCase();
    } else {
      // Multiple names: take first letter of first and last name
      return '${parts[0][0]}${parts[parts.length - 1][0]}'.toUpperCase();
    }
  }

  /// Get color based on name (consistent color for same name)
  static Color getColorForName(String? fullName) {
    if (fullName == null || fullName.isEmpty) {
      return avatarColors[0];
    }

    // Use sum of character codes to get consistent color
    int sum = 0;
    for (int i = 0; i < fullName.length; i++) {
      sum += fullName.codeUnitAt(i);
    }

    return avatarColors[sum % avatarColors.length];
  }

  /// Build the avatar widget
  static Widget buildAvatar({
    required String? fullName,
    required double radius,
    String? imageUrl,
  }) {
    // If user has custom image, show that
    if (imageUrl != null && imageUrl.isNotEmpty) {
      return CircleAvatar(
        radius: radius,
        backgroundImage: NetworkImage(imageUrl),
        backgroundColor: Colors.grey[200],
      );
    }

    // Otherwise, generate initials avatar
    final initials = getInitials(fullName);
    final color = getColorForName(fullName);

    return CircleAvatar(
      radius: radius,
      backgroundColor: color,
      child: Text(
        initials,
        style: TextStyle(
          color: Colors.white,
          fontSize: radius * 0.5, // 50% of radius
          fontWeight: FontWeight.bold,
          fontFamily: 'Poppins',
        ),
      ),
    );
  }

  /// Build avatar with border (for profile pages)
  static Widget buildAvatarWithBorder({
    required String? fullName,
    required double radius,
    String? imageUrl,
    Color borderColor = const Color(0xFF4CAF50),
    double borderWidth = 2,
  }) {
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: borderColor, width: borderWidth),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: buildAvatar(
        fullName: fullName,
        radius: radius,
        imageUrl: imageUrl,
      ),
    );
  }
}

