import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:image_picker/image_picker.dart' as image_picker;
import 'package:intl/intl.dart';
import '../providers/auth_providers.dart';
import 'avatar_generator.dart';

class Profile extends StatelessWidget {
  const Profile({super.key});

  String _formatDate(String? dateStr) {
    if (dateStr == null || dateStr.isEmpty) return "—";
    try {
      final date = DateTime.parse(dateStr);
      return DateFormat('MMMM dd, yyyy').format(date);
    } catch (e) {
      return dateStr;
    }
  }

  String _formatRole(String role) {
    switch (role.toLowerCase()) {
      case 'prof':
      case 'professor':
        return 'Professor';
      case 'program_head':
      case 'program-head':
        return 'Program Head';
      case 'dean':
        return 'Dean';
      default:
        return role;
    }
  }

  @override
  Widget build(BuildContext context) {
    const accentGreen = Color(0xFF4CAF50);
    final authProvider = Provider.of<AuthProvider>(context);
    final user = authProvider.user;

    return Scaffold(
      backgroundColor: const Color(0xFFFFFFFF),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(20, 20, 20, 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 🔹 Back Button
              InkWell(
                borderRadius: BorderRadius.circular(12),
                onTap: () => Navigator.pop(context),
                child: Container(
                  width: 42,
                  height: 42,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        // ignore: deprecated_member_use
                        color: Colors.grey.withOpacity(0.25),
                        blurRadius: 5,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: const Icon(
                    Icons.arrow_back_ios_new_rounded,
                    color: Colors.black87,
                    size: 22,
                  ),
                ),
              ),

              const SizedBox(height: 28),

              // 🔹 Title
              const Center(
                child: Text(
                  "Profile Information",
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    fontFamily: "Sora",
                  ),
                ),
              ),

              const SizedBox(height: 36),

              // 👤 Profile Header Section
              Center(
                child: Column(
                  children: [
                    Stack(
                      children: [
                        AvatarGenerator.buildAvatarWithBorder(
                          fullName: user?.fullname,
                          radius: 56,
                          imageUrl: user?.photoUrl,
                          borderColor: accentGreen,
                          borderWidth: 2,
                        ),
                        Positioned(
                          bottom: 0,
                          right: 0,
                          child: _buildCameraButton(context),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Text(
                      user?.fullname ?? "User",
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                        fontFamily: "Sora",
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 32),

              // 📋 Profile Details Section
              if (user?.dob != null)
                ProfileInfoTile(
                  icon: Icons.cake_outlined,
                  label: "Birthday",
                  value: _formatDate(user?.dob),
                ),
              ProfileInfoTile(
                icon: Icons.work_outline,
                label: "Role",
                value: _formatRole(user?.role ?? ""),
              ),
              if (user?.email != null && user!.email!.isNotEmpty)
                ProfileInfoTile(
                  icon: Icons.email_outlined,
                  label: "Email",
                  value: user.email!,
                ),
              if (user?.contact != null && user!.contact!.isNotEmpty)
                ProfileInfoTile(
                  icon: Icons.phone_outlined,
                  label: "Contact",
                  value: user.contact!,
                ),
              if (user?.address != null && user!.address!.isNotEmpty)
                ProfileInfoTile(
                  icon: Icons.home_outlined,
                  label: "Address",
                  value: user.address!,
                ),
              if (user?.gender != null && user!.gender!.isNotEmpty)
                ProfileInfoTile(
                  icon: Icons.person_outline,
                  label: "Gender",
                  value: user.gender!,
                ),
            ],
          ),
        ),
      ),
    );
  }

  // 📸 Reusable Camera Button Widget
  Widget _buildCameraButton(BuildContext context) {
    final image_picker.ImagePicker picker = image_picker.ImagePicker();
    final authProvider = Provider.of<AuthProvider>(context);
    final user = authProvider.user;

    return GestureDetector(
      onTap: () {
        showDialog(
          context: context,
          barrierDismissible: true,
          builder: (context) {
            return Dialog(
              backgroundColor: const Color(0xFFFFFFFF),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(24, 24, 24, 32),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Align(
                      alignment: Alignment.topRight,
                      child: GestureDetector(
                        onTap: () => Navigator.pop(context),
                        child: Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12),
                            boxShadow: [
                              BoxShadow(
                                // ignore: deprecated_member_use
                                color: Colors.grey.withOpacity(0.25),
                                blurRadius: 5,
                                offset: const Offset(0, 2),
                              ),
                            ],
                          ),
                          child: const Icon(
                            Icons.close,
                            size: 28,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    AvatarGenerator.buildAvatar(
                      fullName: user?.fullname,
                      radius: 56,
                      imageUrl: user?.photoUrl,
                    ),
                    const SizedBox(height: 24),

                    _photoOptionButton(
                      icon: Icons.photo_camera,
                      label: "Take a Photo",
                      onPressed: () async {
                        final image_picker.XFile? image =
                            await picker.pickImage(source: image_picker.ImageSource.camera);
                        if (image != null) {
                          // ignore: avoid_print
                          print("Camera image: ${image.path}");
                          // ignore: use_build_context_synchronously
                          Navigator.pop(context);
                        }
                      },
                    ),
                    const SizedBox(height: 12),
                    _photoOptionButton(
                      icon: Icons.photo_library,
                      label: "Choose from Gallery",
                      onPressed: () async {
                        final image_picker.XFile? image =
                            await picker.pickImage(source: image_picker.ImageSource.gallery);
                        if (image != null) {
                          // ignore: avoid_print
                          print("Gallery image: ${image.path}");
                          // ignore: use_build_context_synchronously
                          Navigator.pop(context);
                        }
                      },
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
      child: Container(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.white,
          border: Border.all(color: Colors.green, width: 3),
          boxShadow: [
            BoxShadow(
              // ignore: deprecated_member_use
              color: Colors.black.withOpacity(0.15),
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        padding: const EdgeInsets.all(4),
        child: const Icon(
          Icons.add_a_photo_rounded,
          size: 16,
          color: Colors.black,
        ),
      ),
    );
  }

  Widget _photoOptionButton({
    required IconData icon,
    required String label,
    required VoidCallback onPressed,
  }) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton.icon(
        icon: Icon(icon, size: 22),
        label: Text(
          label,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            fontFamily: "Sora",
          ),
        ),
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFFF1F8E9),
          foregroundColor: const Color(0xFF4CAF50),
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
          elevation: 2,
        ),
        onPressed: onPressed,
      ),
    );
  }
}

// 🧩 Profile Info Tile (Improved UI)
class ProfileInfoTile extends StatelessWidget {
  final IconData? icon;
  final String label;
  final String value;

  const ProfileInfoTile({
    super.key,
    this.icon,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    const accentGreen = Color(0xFF4CAF50);

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: BoxDecoration(
        color: const Color(0xFFFFF8F3),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            // ignore: deprecated_member_use
            color: Colors.black.withOpacity(0.05),
            blurRadius: 6,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              // ignore: deprecated_member_use
              color: accentGreen.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: accentGreen, size: 22),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    fontFamily: "Sora",
                    color: Colors.black54,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  value,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    fontFamily: "Sora",
                    color: Colors.black87,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
