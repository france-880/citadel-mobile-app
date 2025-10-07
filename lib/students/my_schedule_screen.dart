import 'package:flutter/material.dart';
import 'qr_scanner_screen.dart';

class MyScheduleScreen extends StatelessWidget {
  const MyScheduleScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F9F6),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          "My Schedule",
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black),
        ),
        centerTitle: false,
        actions: [
          IconButton(
            icon: const Icon(Icons.qr_code_scanner, color: Colors.black),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => QrScannerScreen()),
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("For 1st Semester", style: TextStyle(color: Colors.black54)),

            const SizedBox(height: 12),

            // Month selector
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Row(
                    children: [
                      Icon(Icons.calendar_today, color: Colors.black54),
                      SizedBox(width: 8),
                      Text("Sep 2025", style: TextStyle(fontWeight: FontWeight.bold)),
                    ],
                  ),
                  Text("Today", style: TextStyle(color: Colors.green)),
                ],
              ),
            ),

            const SizedBox(height: 16),

            // Days row
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: const [
                Text("S"), Text("M"), Text("T"), Text("W"),
                Text("T"), Text("F"), Text("S"),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: const [
                Text("14"), Text("15"), Text("16"),
                Text("17"), Text("18"), Text("19"), Text("20"),
              ],
            ),

            const SizedBox(height: 20),

            // Schedule items
            _scheduleItem("7:00 AM", "Computer Programming", "CSS 101", "Room 301 - North", "Juan Dela Cruz"),
            const SizedBox(height: 12),
            _scheduleItem("10:00 AM", "Computer Programming", "CSS 101", "Room 301 - North", "Juan Dela Cruz"),
            const SizedBox(height: 12),
            _scheduleItem("01:30 PM", "Computer Programming", "CSS 101", "Room 301 - North", "Juan Dela Cruz"),
            const SizedBox(height: 12),
            _scheduleItem("05:00 PM", "Computer Programming", "CSS 101", "Room 301 - North", "Juan Dela Cruz"),
          ],
        ),
      ),
    );
  }

  static Widget _scheduleItem(String time, String subject, String code, String room, String teacher) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(time, style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.black87)),
        const SizedBox(height: 6),
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.green),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(subject, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              Text(code, style: const TextStyle(color: Colors.black54)),
              Row(
                children: [
                  const Icon(Icons.location_on, size: 16, color: Colors.black54),
                  const SizedBox(width: 4),
                  Text(room, style: const TextStyle(color: Colors.black54)),
                ],
              ),
              Row(
                children: [
                  const Icon(Icons.person, size: 16, color: Colors.black54),
                  const SizedBox(width: 4),
                  Text(teacher, style: const TextStyle(color: Colors.black54)),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
