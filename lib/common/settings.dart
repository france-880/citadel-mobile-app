import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'login_page.dart';
import 'profile.dart';
import 'faq.dart';
import 'get_in_touch_with_us.dart';
import '../providers/auth_providers.dart';
import 'avatar_generator.dart';

class Settings extends StatelessWidget {
  const Settings({super.key});

  String _formatRole(String role) {
    // Format role for display
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
    final authProvider = Provider.of<AuthProvider>(context);
    final user = authProvider.user;

    return Scaffold(
      backgroundColor: const Color(0xFFFFFFFF),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Row(
                children: [
                  Text(
                    "Settings",
                    style: TextStyle(
                      fontSize: 23,
                      fontWeight: FontWeight.bold,
                      fontFamily: "Poppins",
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),

              Row(
                children: [
                  AvatarGenerator.buildAvatar(
                    fullName: user?.fullname,
                    radius: 35,
                    imageUrl: user?.photoUrl,
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          user?.fullname ?? "User",
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            fontFamily: "Sora",
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 4),
                        Text(
                          _formatRole(user?.role ?? ""),
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w300,
                            fontFamily: "Trispace",
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 30),

              buildSectionTitle("Account"),
              _buildSettingItem(
                Icons.person_outline,
                "My Profile",
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const Profile(),
                    ),
                  );
                },  
              ),

              const SizedBox(height: 24),

              buildSectionTitle("Help Center"),
              _buildSettingItem(
                Icons.help_outline,
                "Frequently Asked Questions",
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const FAQ()),
                  );
                },
              ),    

              _buildSettingItem(
                Icons.email_outlined,
                "Get in Touch with Us",
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const GetInTouchWithUs()),
                  );
                },
              ),

              const SizedBox(height: 24),

              buildSectionTitle("About Citadel"),
              _buildSettingItem(
                Icons.lock_outline,
                "Privacy Statement",
                onTap: () {
                  showPrivacyBottomSheet(context);
                },
              ),
              _buildSettingItem(
                Icons.article_outlined,
                "Terms and Conditions",
                onTap: () {
                  showTermsBottomSheet(context);
                },
              ),

              const SizedBox(height: 40),

              GestureDetector(
                onTap: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => const LoginPage()),
                  );
                },
                child: Row(
                  children: const [
                    Icon(Icons.logout, color: Color(0xFFE53935), size: 28),
                    SizedBox(width: 12),
                    Text(
                      "Sign Out",
                      style: TextStyle(
                        color: Color(0xFFE53935),
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                        fontFamily: "Sora",
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Text(
        title,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 15,
          fontFamily: "Sora",
        ),
      ),
    );
  }

  Widget _buildSettingItem(IconData icon, String title, {VoidCallback? onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Row(
          children: [
            Icon(icon, color: Colors.black87, size: 28),
            const SizedBox(width: 12),
            Text(
              title,
              style: const TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: 16,
                fontFamily: "Sora",
              ),
            ),
          ],
        ),
      ),
    );
  }

  // 🔒 Privacy Statement Bottom Sheet
  void showPrivacyBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: const Color(0xFFFFFFFF),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (context) {
        return FractionallySizedBox(
          heightFactor: 0.75,
          child: Column(
            children: [
              // Drag Handle
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 12),
                child: Container(
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(
                    color: Colors.black26,
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
              ),
              // Scrollable content only
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.fromLTRB(24, 0, 24, 32),
                  physics: const BouncingScrollPhysics(),
                  child: const _PrivacyContent(),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  // 📜 Terms and Conditions Bottom Sheet
  void showTermsBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: const Color(0xFFFFFFFF),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (context) {
        return FractionallySizedBox(
          heightFactor: 0.75,
          child: Column(
            children: [
              // Drag Handle
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 12),
                child: Container(
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(
                    color: Colors.black26,
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
              ),
              // Scrollable content only
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.fromLTRB(24, 0, 24, 32),
                  physics: const BouncingScrollPhysics(),
                  child: const _TermsContent(),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

// ✅ Privacy Statement Content (unchanged)
class _PrivacyContent extends StatelessWidget {
  const _PrivacyContent();

  @override
  Widget build(BuildContext context) {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Data Privacy Notice",
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w600,
            fontFamily: "Poppins",
          ),
        ),
        SizedBox(height: 12),
        Text(
          "In compliance with the Data Privacy Act of 2012 (Republic Act No. 10173), University of Caloocan City – Bagong Silang Campus values your privacy and is committed to protecting your personal information.",
          style: TextStyle(fontSize: 14, fontFamily: "Sora"),
        ),
        SizedBox(height: 12),
        Text(
          "Information We Collect",
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w700,
            fontFamily: "Sora",
          ),
        ),
        SizedBox(height: 8),
        Text(
          "We collect only the necessary personal data, including but not limited to:",
          style: TextStyle(fontSize: 14, fontFamily: "Sora"),
        ),
        SizedBox(height: 8),
        Text(
          "• Full Name\n• Student ID Number\n• Contact Information",
          style: TextStyle(fontSize: 14, fontFamily: "Sora"),
        ),
        SizedBox(height: 12),
        Text(
          "Purpose of Processing",
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w700,
            fontFamily: "Sora",
          ),
        ),
        SizedBox(height: 8),
        Text(
          "Your personal information is collected and processed solely for:",
          style: TextStyle(fontSize: 14, fontFamily: "Sora"),
        ),
        SizedBox(height: 8),
        Text(
          "• Verifying your identity and providing secure access to the system.\n• Facilitating school-related services, communication, and notifications.",
          style: TextStyle(fontSize: 14, fontFamily: "Sora"),
        ),
        SizedBox(height: 12),
        Text(
          "Data Protection Measures",
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w700,
            fontFamily: "Sora",
          ),
        ),
        SizedBox(height: 8),
        Text(
          "• Your personal data is stored securely and accessed only by authorized school personnel.\n• We do not sell, share, or disclose your personal data to third parties without your consent, unless required by law.\n• You may request the updating or deletion of your data, subject to school policies and legal retention requirements.",
          style: TextStyle(fontSize: 14, fontFamily: "Sora"),
        ),
        SizedBox(height: 12),
        Text(
          "Consent",
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w700,
            fontFamily: "Sora",
          ),
        ),
        SizedBox(height: 8),
        Text(
          "By using this application, you acknowledge that you have read and understood this Privacy Notice and that you consent to the collection and processing of your personal data as described herein.",
          style: TextStyle(fontSize: 14, fontFamily: "Sora"),
        ),
        SizedBox(height: 12),Text(
          "Inquiries",
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w700,
            fontFamily: "Sora",
          ),
        ),
        SizedBox(height: 8),
        Text(
          "For questions or concerns regarding data privacy, please contact: \nucc-caloocan.edu.ph",
          style: TextStyle(fontSize: 14, fontFamily: "Sora"),
        ),
      ],
    );
  }
}

// ✅ Terms & Conditions Content (unchanged)
class _TermsContent extends StatelessWidget {
  const _TermsContent();

  @override
  Widget build(BuildContext context) {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Terms and Conditions of Use",
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w600,
            fontFamily: "Poppins",
          ),
        ),
        SizedBox(height: 14),
        Text(
          "By accessing and using this application, you agree to comply with and be bound by the following Terms and Conditions. Please read them carefully.",
          style: TextStyle(fontSize: 14, fontFamily: "Sora"),
        ),
        SizedBox(height: 12),
        Text(
          "1. Authorized Use",
          style: TextStyle(
            fontSize: 14,
            fontFamily: "Sora",
            fontWeight: FontWeight.w700,
          ),
        ),
        SizedBox(height: 8),
        Text(
          "This application is intended solely for the use of students, parents/guardians, and authorized staff of University of Caloocan City - Bagong Silang Campus. Any unauthorized use is strictly prohibited.",
          style: TextStyle(fontSize: 14, fontFamily: "Sora"),
        ),
        SizedBox(height: 12),
        Text(
          "2. Accuracy of Information",
          style: TextStyle(
            fontSize: 14,
            fontFamily: "Sora",
            fontWeight: FontWeight.w700,
          ),
        ),
        SizedBox(height: 8),
        Text(
          "You are responsible for ensuring that the personal information and account details you provide are complete, accurate, and kept up to date at all times.",
          style: TextStyle(fontSize: 14, fontFamily: "Sora"),
        ),
        SizedBox(height: 12),
        Text(
          "3. Account Security",
          style: TextStyle(
            fontSize: 14,
            fontFamily: "Sora",
            fontWeight: FontWeight.w700,
          ),
        ),
        SizedBox(height: 8),
        Text(
          "You are responsible for maintaining the confidentiality of your login credentials. Any activity carried out under your account will be considered your responsibility. The University shall not be held liable for any loss or damage resulting from unauthorized use of your account.",
          style: TextStyle(fontSize: 14, fontFamily: "Sora"),
        ),
        SizedBox(height: 12),
        Text(
          "4. Prohibited Activities",
          style: TextStyle(
            fontSize: 14,
            fontFamily: "Sora",
            fontWeight: FontWeight.w700,
          ),
        ),
        SizedBox(height: 8),
        Text(
          "Users shall not engage in activities that may compromise the integrity or security of the system, including but not limited to:",
          style: TextStyle(fontSize: 14, fontFamily: "Sora"),
        ),
        SizedBox(height: 8),
        Text(
          "• Submitting false, misleading, or fraudulent information.\n• Attempting unauthorized access to accounts or restricted areas.\n• Uploading or distributing malicious content.\n• Misuse of the platform for purposes other than those intended by the school.",
          style: TextStyle(fontSize: 14, fontFamily: "Sora"),
        ),
        SizedBox(height: 12),
        Text(
          "5. Data Privacy",
          style: TextStyle(
            fontSize: 14,
            fontFamily: "Sora",
            fontWeight: FontWeight.w700,
          ),
        ),
        SizedBox(height: 8),
        Text(
          "The collection and processing of personal information are governed by our Data Privacy Policy, in compliance with the Data Privacy Act of 2012 (RA 10173).",
          style: TextStyle(fontSize: 14, fontFamily: "Sora"),
        ),
        SizedBox(height: 12),
        Text(
          "6. Amendments",
          style: TextStyle(
            fontSize: 14,
            fontFamily: "Sora",
            fontWeight: FontWeight.w700,
          ),
        ),
        SizedBox(height: 8),
        Text(
          "University of Caloocan City - Bagong Silang Campus reserves the right to amend or update these Terms and Conditions at any time. Continued use of the application constitutes acceptance of the revised terms.",
          style: TextStyle(fontSize: 14, fontFamily: "Sora"),
        ),
        SizedBox(height: 12),
        Text(
          "7. Support and Inquiries",
          style: TextStyle(
            fontSize: 14,
            fontFamily: "Sora",
            fontWeight: FontWeight.w700,
          ),
        ),
        SizedBox(height: 8),
        Text(
          "For assistance, concerns, or questions regarding the use of this application, please contact us at: \nucc-caloocan.edu.ph",
          style: TextStyle(fontSize: 14, fontFamily: "Sora"),
        ),
      ],
    );
  }
}
