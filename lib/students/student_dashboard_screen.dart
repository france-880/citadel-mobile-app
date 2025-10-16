import 'package:flutter/material.dart';
import 'my_schedule_screen.dart';
import 'settings.dart';
import 'logs_screen.dart'; // ✅ Import LogsScreen

class StudentDashboardScreen extends StatefulWidget {
  const StudentDashboardScreen({super.key});

  @override
  State<StudentDashboardScreen> createState() => _StudentDashboardScreenState();
}

class _StudentDashboardScreenState extends State<StudentDashboardScreen> {
  int _selectedIndex = 0;

  final List<Widget> _screens = [
    const _DashboardHome(), // Your existing dashboard
    const MyScheduleScreen(),
    const Settings(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_selectedIndex],
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              offset: const Offset(0, -2),
              blurRadius: 4,
              spreadRadius: 0,
            ),
          ],
        ),
        child: BottomNavigationBar(
          backgroundColor: Colors.white,
          elevation: 0, // Remove default elevation
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
          selectedItemColor: const Color(0xFFEC5B05), // 🔸 Orange
          unselectedItemColor: Colors.grey,
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: "Dashboard"),
            BottomNavigationBarItem(icon: Icon(Icons.calendar_today), label: "My Schedule"),
            BottomNavigationBarItem(icon: Icon(Icons.settings), label: "Settings"),
          ],
        ),
      ),
    );
  }
}

/// This is your original Student Dashboard design (kept intact)
class _DashboardHome extends StatelessWidget {
  const _DashboardHome();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFFFFF),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Dashboard",
                style: TextStyle(
                  fontSize: 23,
                  fontWeight: FontWeight.bold,
                  fontFamily: "Poppins",
                ),
              ),
              const SizedBox(height: 4),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [

              // Your next class
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 5,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Your next class",
                          style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                        ),
                        SizedBox(height: 8),
                        Text(
                          "IT 101",
                          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          "Computer Programming",
                          style: TextStyle(fontSize: 14, color: Colors.black54),
                        ),
                      ],
                    ),
                    const Icon(Icons.bookmark_border, size: 32, color: Colors.green),
                  ],
                ),
              ),

              const SizedBox(height: 20),

            // Today Classes
            Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
                const Text(
                "Today Classes",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                GestureDetector(
                onTap: () {
                    Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const MyScheduleScreen()),
                    );
                },
                child: const Text("See all", style: TextStyle(color: Colors.green)),
                ),
            ],
            ),
              const SizedBox(height: 12),

              _classCard("7:00 AM", "Object-Oriented Programming", "Room 301 - North", "Mr. Juan Dela Cruz"),
              const SizedBox(height: 12),
              _classCard("10:00 AM", "Life and Works of Rizal", "Room 102 - North", "Ms. Jane Lopez"),

              const SizedBox(height: 20),

              // Your Logs
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Your Logs",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const LogsScreen()),
                      );
                    },
                    child: const Text("See all", style: TextStyle(color: Colors.green)),
                  ),
                ],
              ),
              const SizedBox(height: 12),

              _logCard("Time In", "You entered in campus at 6:45AM", "06:48 AM"),
              const SizedBox(height: 12),
              _logCard("Class", "Your next class will start in 10 minutes", "06:50 AM"),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Class card widget
  static Widget _classCard(String time, String subject, String room, String teacher) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        children: [
          Text(
            time,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.green),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(subject, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                Text(room, style: const TextStyle(fontSize: 14, color: Colors.black54)),
                Text(teacher, style: const TextStyle(fontSize: 14, color: Colors.black54)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Log card widget
  static Widget _logCard(String title, String message, String time) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: const Color(0xFFDCFCE7),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              title,
              style: const TextStyle(color: Colors.green, fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(child: Text(message, style: const TextStyle(fontSize: 14))),
          Text(time, style: const TextStyle(color: Colors.black54)),
        ],
      ),
    );
  }
}
