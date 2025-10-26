import 'package:flutter/material.dart';

class GetInTouchWithUs extends StatelessWidget {
  const GetInTouchWithUs({super.key});

  @override
  Widget build(BuildContext context) {
    const accentGreen = Color(0xFF4CAF50); // main green accent

    return Scaffold(
      backgroundColor: const Color(0xFFFFFFFF),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 🔹 Back Button
              Row(
                children: [
                  InkWell(
                    borderRadius: BorderRadius.circular(12),
                    onTap: () => Navigator.pop(context),
                    child: Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            // ignore: deprecated_member_use
                            color: Colors.grey.withOpacity(0.3),
                            spreadRadius: 1,
                            blurRadius: 4,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: const Icon(
                        Icons.arrow_back_ios_new,
                        color: Colors.black,
                        size: 22,
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 30),

              // 🔸 Green Email Icon Header
              Center(
                child: Container(
                  width: 53,
                  height: 53,
                  decoration: BoxDecoration(
                    // ignore: deprecated_member_use
                    color: accentGreen.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Icon(
                    Icons.email_outlined,
                    color: accentGreen,
                    size: 30,
                  ),
                ),
              ),

              const SizedBox(height: 20),

              // 🔹 Title
              const Center(
                child: Text(
                  "Get in Touch with Us!",
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    fontFamily: "Sora",
                  ),
                ),
              ),

              const SizedBox(height: 10),

              const Center(
                child: Text(
                  "Have questions or need support?\nWe’re here to help!",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 14,
                    fontFamily: "Sora",
                    fontWeight: FontWeight.w500,
                    color: Colors.black87,
                  ),
                ),
              ),

              const SizedBox(height: 30),

              // 🔸 Contact Info Cards
              Expanded(
                child: ListView(
                  children: [
                    _buildContactCard(
                      icon: Icons.call,
                      iconColor: accentGreen,
                      label: "Call Us:",
                      value: "+63 912 345 6789",
                    ),
                    _buildContactCard(
                      icon: Icons.email,
                      iconColor: accentGreen,
                      label: "Email:",
                      value: "citadel.support@ucc.edu.ph",
                    ),
                    _buildContactCard(
                      icon: Icons.location_on,
                      iconColor: accentGreen,
                      label: "Visit Us:",
                      value:
                          "University of Caloocan City – Engineering Campus",
                    ),
                    _buildContactCard(
                      icon: Icons.public,
                      iconColor: accentGreen,
                      label: "Follow Us:",
                      value: "https://www.facebook.com/fastdraft20",
                    ),
                    _buildContactCard(
                      icon: Icons.access_time_filled,
                      iconColor: accentGreen,
                      label: "Office Hours:",
                      value: "Mon – Fri | 8:00 AM – 5:00 PM",
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

  // 🧩 Reusable Contact Card Widget
  Widget _buildContactCard({
    required IconData icon,
    required Color iconColor,
    required String label,
    required String value,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: const Color(0xFFFFF8F3),
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            // ignore: deprecated_member_use
            color: Colors.black.withOpacity(0.06),
            blurRadius: 6,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 🔹 Icon Container
          Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              // ignore: deprecated_member_use
              color: iconColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon, color: iconColor, size: 20),
          ),
          const SizedBox(width: 12),

          // 🔹 Text Layout (vertical stack)
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: const TextStyle(
                    fontFamily: "Sora",
                    fontWeight: FontWeight.w700,
                    fontSize: 14,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  value,
                  style: const TextStyle(
                    fontFamily: "Sora",
                    fontWeight: FontWeight.w400,
                    fontSize: 14,
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
