import 'package:flutter/material.dart';
class Settings extends StatelessWidget {
  const Settings({super.key});

  // ✅ Helper for reusable settings items with onTap support
  Widget _settingsItem(BuildContext context, IconData icon, String title,
      {VoidCallback? onTap}) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Row(
          children: [
            Icon(icon, color: Colors.grey[700]),
            const SizedBox(width: 12),
            Text(
              title,
              style: const TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
  return Scaffold(
  appBar: AppBar(
    backgroundColor: const Color(0xFFF9FFFA),
    title: const Text(
      "Settings",
      style: TextStyle(
        fontSize: 22,
        fontWeight: FontWeight.bold,
      ),
    ),
  ),
    
       backgroundColor: const Color(0xFFF9FFFA),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Profile Header
              Row(
                children: [
                  const CircleAvatar(
                    radius: 35,
                    backgroundImage:
                        NetworkImage("https://i.pravatar.cc/150?img=3"),
                  ),
                  const SizedBox(width: 16),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Anastasha L. Bartolome",
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      const Text("20222486-N",
                          style: TextStyle(color: Colors.black54)),
                      const SizedBox(height: 6),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 2),
                        decoration: BoxDecoration(
                          color: Colors.green.shade100,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: const Text(
                          "Enrolled",
                          style: TextStyle(
                            color: Colors.green,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),

              const SizedBox(height: 24),

              // Account Section
              const Text(
                "Account",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              const SizedBox(height: 12),
              _settingsItem(context, Icons.person, "My Profile", onTap: () {
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(builder: (context) => const student_dashboard_screen()),
                // );
              }),
              _settingsItem(context, Icons.notifications, "Notifications"),

              const SizedBox(height: 24),

              // Help Center
              const Text(
                "Help Center",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              const SizedBox(height: 12),
              _settingsItem(context, Icons.help, "Frequently Asked Questions"),
              _settingsItem(context, Icons.chat, "Get in Touch with Us"),

              const SizedBox(height: 24),

              // About Section
              const Text(
                "About Citadel",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              const SizedBox(height: 12),
              _settingsItem(context, Icons.privacy_tip, "Privacy Statement"),
              _settingsItem(context, Icons.description, "Terms and Conditions"),

              const SizedBox(height: 30),

              // Sign out
              GestureDetector(
                onTap: () {
                  // TODO: Add logout logic
                },
                child: Row(
                  children: const [
                    Icon(Icons.logout, color: Colors.red),
                    SizedBox(width: 8),
                    Text(
                      "Sign Out",
                      style: TextStyle(
                          color: Colors.red, fontWeight: FontWeight.bold),
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
}
