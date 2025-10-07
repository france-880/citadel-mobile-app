import 'package:flutter/material.dart';
import 'schedule_page.dart'; // 📅 Schedule Page
import 'program_page.dart'; // 🎓 Program Page
import '../students/settings.dart'; // ⚙️ Settings Page
import 'attendance_page.dart'; // Attendance Page

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  String _formatDate(DateTime dt) {
    const weekdays = [
      'Monday',
      'Tuesday',
      'Wednesday',
      'Thursday',
      'Friday',
      'Saturday',
      'Sunday',
    ];
    const months = [
      '',
      'January',
      'February',
      'March',
      'April',
      'May',
      'June',
      'July',
      'August',
      'September',
      'October',
      'November',
      'December',
    ];

    final weekday = weekdays[dt.weekday - 1];
    final month = months[dt.month];
    return '$weekday, $month ${dt.day}, ${dt.year}';
  }

  @override
  Widget build(BuildContext context) {
    final today = _formatDate(DateTime.now());

    return Scaffold(
      backgroundColor: const Color(0xFFFFFFFF),
      body: PageView(
        controller: _pageController,
        onPageChanged: (index) {
          setState(() => _selectedIndex = index);
        },
        children: [
          _buildHomeContent(today), // 🏠 Home
          const SchedulePage(), // 📅 Schedule
          const ProgramPage(), // 🎓 Program
          const Settings(), // ⚙️ Settings
        ],
      ),

      // 🔹 Bottom Navigation
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _selectedIndex,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
            _pageController.animateToPage(
              index,
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeInOut,
            );
          });
        },
        selectedItemColor: Colors.green,
        unselectedItemColor: Colors.grey,
        showUnselectedLabels: true,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_month),
            label: "Schedule",
          ),
          BottomNavigationBarItem(icon: Icon(Icons.school), label: "Programs"),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: "Settings",
          ),
        ],
      ),
    );
  }

  // ======================
  // 🏠 HOME CONTENT
  // ======================
  Widget _buildHomeContent(String today) {
    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Greeting Header
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    "Hello Professor,\nDumbledore!",
                    style: const TextStyle(
                      fontSize: 23,
                      fontWeight: FontWeight.bold,
                      fontFamily: "Poppins",
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Material(
                  elevation: 1,
                  borderRadius: BorderRadius.circular(12),
                  color: Colors.white,
                  clipBehavior: Clip.antiAlias,
                  child: InkWell(
                    borderRadius: BorderRadius.circular(12),
                    onTap: () {
                      // Add drawer or modal action here
                    },
                    child: Container(
                      width: 40,
                      height: 40,
                      padding: const EdgeInsets.all(8),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Container(
                            width: 15,
                            height: 2,
                            decoration: BoxDecoration(
                              color: Colors.black87,
                              borderRadius: BorderRadius.circular(2),
                            ),
                          ),
                          Container(
                            width: 23,
                            height: 2,
                            decoration: BoxDecoration(
                              color: Colors.black87,
                              borderRadius: BorderRadius.circular(2),
                            ),
                          ),
                          Container(
                            width: 15,
                            height: 2,
                            decoration: BoxDecoration(
                              color: Colors.black87,
                              borderRadius: BorderRadius.circular(2),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 4),
            Text(
              today,
              style: const TextStyle(
                fontFamily: "Roboto",
                fontWeight: FontWeight.bold,
                fontSize: 14,
                color: Color(0xFF8C8C8C),
              ),
            ),

            const SizedBox(height: 20),

            // 🔹 Your Next Class Section
            const Text(
              "Your next class",
              style: TextStyle(
                fontSize: 16,
                fontFamily: "Sora",
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            _nextClassCard(),
            const SizedBox(height: 20),

            // 🔹 Overview Section
            const Text(
              "Here's your overview today",
              style: TextStyle(
                fontSize: 16,
                fontFamily: "Sora",
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),

            Row(
              children: const [
                Expanded(
                  child: StatCard(
                    count: "7",
                    label: "Programs",
                    icon: Icons.school,
                    bgColor: Color(0xFFACFFB3), // light green
                    iconBgColor: Color(0xFF22C55E), // green
                    countColor: Color(0xFF2D632D),
                    labelColor: Color(0xFF57955A),
                  ),
                ),
                SizedBox(width: 16),
                Expanded(
                  child: StatCard(
                    count: "100",
                    label: "Students",
                    icon: Icons.people_alt,
                    bgColor: Color(0xFFFFE2AC), // light orange
                    iconBgColor: Color(0xFFF59E0B), // orange
                    countColor: Color(0xFF635A2D),
                    labelColor: Color(0xFF957B57),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 20),
            const Text(
              "Check your student attendance",
              style: TextStyle(
                fontSize: 16,
                fontFamily: "Sora",
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),

            // 🔹 Static Attendance Cards
            _attendanceGrid(),
          ],
        ),
      ),
    );
  }

  // 🔹 Next Class Card
  Widget _nextClassCard() {
    return Card(
      elevation: 5,
      color: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text.rich(
              TextSpan(
                children: [
                  TextSpan(
                    text: "IT 101 – ",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                      fontFamily: "Roboto",
                    ),
                  ),
                  TextSpan(
                    text: "Computer Programming",
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                      fontFamily: "Roboto",
                    ),
                  ),
                ],
              ),
            ),
            const Text(
              "BSIT 2A",
              style: TextStyle(
                color: Colors.black,
                fontFamily: "Worksans",
                fontWeight: FontWeight.w600,
                fontSize: 14,
              ),
            ),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFF1F8E9),
                    foregroundColor: const Color(0xFF57955A),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    padding: EdgeInsets.symmetric(
                      vertical: 8,
                      horizontal: MediaQuery.of(context).size.width * 0.08,
                    ),
                  ),
                  child: const Text(
                    "See now",
                    style: TextStyle(
                      fontFamily: "Sora", // 🔹 custom font
                      fontWeight: FontWeight.w600,
                      fontSize: 12, // 🔹 semibold
                    ),
                  ),
                ),

                // 🔹 Elevated + Shifted Icon Button
                Transform.translate(
                  offset: const Offset(0, -6), // iangat ng kaunti (negative Y)
                  child: Material(
                    elevation: 1, // shadow
                    borderRadius: BorderRadius.circular(12),
                    clipBehavior: Clip.antiAlias,
                    color: Colors.white,
                    child: IconButton(
                      iconSize:
                          MediaQuery.of(context).size.width *
                          0.08, // mas malaki yung icon
                      icon: const Icon(
                        Icons.bookmark_border_rounded,
                        color: Color(0xFF57955A),
                      ),
                      onPressed: () {
                        // action dito
                      },
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // 🔹 Static GridView for Attendance Cards
  Widget _attendanceGrid() {
    double screenWidth = MediaQuery.of(context).size.width;
    int crossAxisCount = screenWidth > 600 ? 3 : 2;

    return GridView(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: crossAxisCount,
        crossAxisSpacing: 16,
        mainAxisSpacing: 8,
        childAspectRatio: 0.7,
      ),
      children: [
        _attendanceCard(
          title: "BSIS 1B",
          students: "35 Students",
          imageUrl: "assets/images/section_banner.jpg",
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const AttendancePage()),
            );
          },
        ),
        _attendanceCard(
          title: "BSIT 2A",
          students: "40 Students",
          imageUrl: "assets/images/section_banner.jpg",
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const AttendancePage()),
            );
          },
        ),
        _attendanceCard(
          title: "BSEMC 3B",
          students: "28 Students",
          imageUrl: "assets/images/section_banner.jpg",
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const AttendancePage()),
            );
          },
        ),
        _attendanceCard(
          title: "BSCS 4A",
          students: "32 Students",
          imageUrl: "assets/images/section_banner.jpg",
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const AttendancePage()),
            );
          },
        ),
      ],
    );
  }

  // 🔹 Attendance Card
  Widget _attendanceCard({
    required String title,
    required String students,
    required String imageUrl,
    required VoidCallback onPressed,
  }) {
    return Card(
      elevation: 5,
      color: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.asset(
                imageUrl,
                height: 100,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              title,
              style: const TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 15,
                fontFamily: "Sora",
              ),
            ),
            Text(
              students,
              style: const TextStyle(
                color: Color(0xFFAEAEAE),
                fontSize: 13,
                fontWeight: FontWeight.w500,
                fontFamily: "Roboto",
              ),
            ),
            const Spacer(),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: onPressed,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFF1F8E9),
                  foregroundColor: const Color(0xFF57955A),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 10,
                  ),
                ),
                child: const Text(
                  "See more",
                  style: TextStyle(
                    fontFamily: "Sora",
                    fontWeight: FontWeight.w600,
                    fontSize: 12,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ======================
// 📊 Reusable StatCard Widget
// ======================
class StatCard extends StatelessWidget {
  final String count;
  final String label;
  final IconData icon;
  final Color bgColor;
  final Color iconBgColor;
  final Color countColor;
  final Color labelColor;

  const StatCard({
    super.key,
    required this.count,
    required this.label,
    required this.icon,
    required this.bgColor,
    required this.iconBgColor,
    required this.countColor,
    required this.labelColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(16),
      ),
      padding: const EdgeInsets.all(16),
      child: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                count,
                style: TextStyle(
                  fontSize: MediaQuery.of(context).size.width > 600 ? 32 : 24,
                  fontWeight: FontWeight.bold,
                  fontFamily: "Trispace",
                  color: countColor,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                label,
                style: TextStyle(
                  fontFamily: "Roboto",
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: labelColor,
                ),
              ),
            ],
          ),
          Positioned(
            right: 0,
            top: 0,
            child: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: iconBgColor,
                shape: BoxShape.circle,
              ),
              child: Icon(icon, color: Colors.white, size: 20),
            ),
          ),
        ],
      ),
    );
  }
}