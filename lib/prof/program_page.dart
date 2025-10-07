import 'package:flutter/material.dart';
import 'attendance_page.dart';

class ProgramPage extends StatelessWidget {
  const ProgramPage({super.key});

  @override
  Widget build(BuildContext context) {
    final programs = [
      {
        "title": "BSIT 1A",
        "students": "37 Students",
        "image": "assets/images/section_banner.jpg",
      },
      {
        "title": "BSIS 1B",
        "students": "35 Students",
        "image": "assets/images/section_banner.jpg",
      },
      {
        "title": "BSIS 2B",
        "students": "36 Students",
        "image": "assets/images/section_banner.jpg",
      },
      {
        "title": "BSIT 2A",
        "students": "38 Students",
        "image": "assets/images/section_banner.jpg",
      },
      {
        "title": "BSEMC 1B",
        "students": "39 Students",
        "image": "assets/images/section_banner.jpg",
      },
      {
        "title": "BSCS 3B",
        "students": "38 Students",
        "image": "assets/images/section_banner.jpg",
      },
      {
        "title": "BSCEMC 3A",
        "students": "38 Students",
        "image": "assets/images/section_banner.jpg",
      },
    ];

    return Scaffold(
      backgroundColor: const Color(0xFFFFFFFF),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            const Padding(
              padding: EdgeInsets.fromLTRB(16, 16, 16, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Programs",
                    style: TextStyle(
                      fontSize: 23,
                      fontWeight: FontWeight.bold,
                      fontFamily: "Poppins",
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    "Student Sections",
                    style: TextStyle(
                      fontSize: 14,
                      fontFamily: "Roboto",
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF8C8C8C),
                    ),
                  ),
                  SizedBox(height: 16),
                ],
              ),
            ),

            // Grid of program cards
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: GridView.builder(
                  itemCount: programs.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 16,
                    mainAxisSpacing: 16,
                    childAspectRatio: 0.7,
                  ),
                  itemBuilder: (context, index) {
                    final program = programs[index];
                    return Card(
                      elevation: 4,
                      color: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(12),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(12),
                              child: Image.asset(
                                program["image"]!,
                                height: 100,
                                width: double.infinity,
                                fit: BoxFit.cover,
                              ),
                            ),
                            const SizedBox(height: 10),
                            Text(
                              program["title"]!,
                              style: const TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 16,
                                fontFamily: "Sora",
                              ),
                            ),
                            Text(
                              program["students"]!,
                              style: const TextStyle(
                                color: Colors.grey,
                                fontSize: 13,
                                fontFamily: "Roboto",
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            const Spacer(),
                            SizedBox(
                              width: double.infinity,
                              child: ElevatedButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          const AttendancePage(),
                                    ),
                                  );
                                },
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
                                  "Attendance",
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
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}